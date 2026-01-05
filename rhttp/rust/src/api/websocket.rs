use std::sync::Arc;

use flutter_rust_bridge::frb;
use futures_util::{SinkExt, StreamExt};
use reqwest_websocket::{Message, RequestBuilderExt, WebSocket};
use tokio::{
    sync::{mpsc, Mutex, OnceCell},
    task::JoinHandle,
};

use crate::{
    api::{
        client::{ClientSettings, RequestClient},
        error::{RhttpError, WebSocketError},
        http::{retrieve_request, HttpBody, HttpHeaders, HttpMethod},
        stream,
    },
    frb_generated::{RustAutoOpaque, StreamSink},
};

#[derive(Debug, Clone)]
pub enum RhttpWebSocketEvent {
    Message(RhttpWebSocketMessage),
    Closed {
        code: Option<u16>,
        reason: Option<String>,
    },
    Error(WebSocketError),
}

#[frb(opaque)]
pub struct WebSocketHandle {
    /// Channel to send messages to the WebSocket task
    msg_tx: mpsc::UnboundedSender<RhttpWebSocketMessage>,
    /// Dart stream sink for incoming messages
    sink: Arc<OnceCell<StreamSink<RhttpWebSocketEvent>>>,
    /// Handle to the WebSocket task
    ws_task: Arc<Mutex<Option<JoinHandle<()>>>>,
}

/// Represents a [WebSocket](https://developer.mozilla.org/en-US/docs/Web/API/WebSocket)
/// message.
#[derive(Debug, Clone)]
pub enum RhttpWebSocketMessage {
    Text(String),
    Binary(Vec<u8>),
    Ping(Vec<u8>),
    Pong(Vec<u8>),
    Close { code: u16, reason: String },
}

fn message_to_frame(msg: RhttpWebSocketMessage) -> Message {
    match msg {
        RhttpWebSocketMessage::Text(s) => Message::Text(s),
        RhttpWebSocketMessage::Binary(b) => Message::Binary(b.into()),
        RhttpWebSocketMessage::Ping(b) => Message::Ping(b.into()),
        RhttpWebSocketMessage::Pong(b) => Message::Pong(b.into()),
        RhttpWebSocketMessage::Close { code: _, reason } => Message::Close {
            code: reqwest_websocket::CloseCode::Error,
            reason,
        },
    }
}

fn frame_to_message(msg: Message) -> RhttpWebSocketMessage {
    match msg {
        Message::Text(text) => RhttpWebSocketMessage::Text(text),
        Message::Binary(bytes) => RhttpWebSocketMessage::Binary(bytes.to_vec()),
        Message::Ping(bytes) => RhttpWebSocketMessage::Ping(bytes.to_vec()),
        Message::Pong(bytes) => RhttpWebSocketMessage::Pong(bytes.to_vec()),
        Message::Close { code, reason } => RhttpWebSocketMessage::Close {
            code: code.into(),
            reason,
        },
    }
}

fn map_ws_error(err: reqwest_websocket::Error) -> RhttpError {
    match err {
        reqwest_websocket::Error::Handshake(_) => {
            RhttpError::RhttpWebSocketError(WebSocketError::HandshakeFailed {
                status: 1,
                reason: None,
            })
        }
        reqwest_websocket::Error::Reqwest(error) => {
            RhttpError::RhttpUnknownError(format!("{error}"))
        }
        reqwest_websocket::Error::Tungstenite(_) => {
            RhttpError::RhttpWebSocketError(WebSocketError::Unknown)
        }
        _ => RhttpError::RhttpWebSocketError(WebSocketError::Unknown),
    }
}

#[frb]
pub async fn websocket_connect(
    _client: Option<RustAutoOpaque<RequestClient>>,
    settings: Option<ClientSettings>,
    method: HttpMethod,
    url: String,
    query: Option<Vec<(String, String)>>,
    headers: Option<HttpHeaders>,
    body: Option<HttpBody>,
    body_stream: Option<stream::Dart2RustStreamReceiver>,
) -> Result<WebSocketHandle, RhttpError> {
    log::info!("Client Settings: {:#?}", settings);
    let settings = if let Some(mut settings) = settings {
        // This is required due to https://github.com/jgraef/reqwest-websocket/issues/2.
        settings.http_version_pref = crate::api::http::HttpVersionPref::Http11;
        settings
    } else {
        ClientSettings {
            http_version_pref: crate::api::http::HttpVersionPref::Http11,
            ..Default::default()
        }
    };

    // A new client must be generated in order to make sure that only HTTP/1.1 is
    // used for the UPGRADE request.
    let client = RequestClient::new(settings)?;
    //let client = retrieve_client(client, settings)?;

    let request =
        retrieve_request(&client, method, url, query, headers, body, body_stream).await?;

    let websocket = connect_websocket(&client.client, request).await?;

    // Create a channel for sending messages to the WebSocket
    let (msg_tx, msg_rx) = mpsc::unbounded_channel::<RhttpWebSocketMessage>();

    let sink = Arc::new(OnceCell::new());
    let ws_task = Arc::new(Mutex::new(None));

    // Store the WebSocket and receiver in the task handle for later use
    let sink_clone = sink.clone();
    let ws_task_clone = ws_task.clone();

    // Spawn the WebSocket handler task
    let task = tokio::spawn(async move {
        run_websocket_task(websocket, msg_rx, sink_clone).await;
    });

    *ws_task_clone.lock().await = Some(task);

    Ok(WebSocketHandle {
        msg_tx,
        sink,
        ws_task,
    })
}

/// Runs the WebSocket send/receive loop
async fn run_websocket_task(
    websocket: WebSocket,
    mut msg_rx: mpsc::UnboundedReceiver<RhttpWebSocketMessage>,
    sink: Arc<OnceCell<StreamSink<RhttpWebSocketEvent>>>,
) {
    // Split the WebSocket into sender and receiver
    let (mut ws_sender, mut ws_receiver) = websocket.split();

    loop {
        tokio::select! {
            // Handle outgoing messages from the channel
            Some(msg) = msg_rx.recv() => {
                let frame = message_to_frame(msg);
                if let Err(e) = ws_sender.send(frame).await {
                    log::error!("Failed to send WebSocket message: {}", e);
                    if let Some(sink) = sink.get() {
                        let _ = sink.add(RhttpWebSocketEvent::Error(WebSocketError::TransportError {
                            message: e.to_string(),
                        }));
                    }
                    break;
                }
            }

            // Handle incoming messages from the WebSocket
            result = ws_receiver.next() => {
                match result {
                    Some(Ok(msg)) => {
                        let message = frame_to_message(msg);
                        if let Some(sink) = sink.get() {
                            if sink.add(RhttpWebSocketEvent::Message(message)).is_err() {
                                log::error!("Failed to send message to Dart");
                                break;
                            }
                        }
                    }
                    Some(Err(e)) => {
                        log::error!("WebSocket receive error: {}", e);
                        if let Some(sink) = sink.get() {
                            let _ = sink.add(RhttpWebSocketEvent::Error(WebSocketError::TransportError {
                                message: e.to_string(),
                            }));
                        }
                        break;
                    }
                    None => {
                        // WebSocket closed
                        if let Some(sink) = sink.get() {
                            let _ = sink.add(RhttpWebSocketEvent::Closed {
                                code: None,
                                reason: None,
                            });
                        }
                        break;
                    }
                }
            }
        }
    }
}

#[frb]
pub async fn websocket_close(handle: &WebSocketHandle) -> Result<(), RhttpError> {
    let msg = RhttpWebSocketMessage::Close {
        code: 1,
        reason: "User enforced.".to_string(),
    };

    // Send close message through the channel
    handle
        .msg_tx
        .send(msg)
        .map_err(|_| RhttpError::RhttpUnknownError("WebSocket channel closed".into()))?;

    // Stop the WebSocket task if running
    if let Some(task) = handle.ws_task.lock().await.take() {
        task.abort();
    }

    Ok(())
}

pub async fn websocket_listen(
    handle: &WebSocketHandle,
    sink: StreamSink<RhttpWebSocketEvent>,
) -> Result<(), RhttpError> {
    // Register the sink for receiving messages
    handle
        .sink
        .set(sink)
        .map_err(|_| RhttpError::RhttpUnknownError("WebSocket listener already attached".into()))?;

    Ok(())
}

#[frb]
pub async fn websocket_send(
    handle: &WebSocketHandle,
    msg: RhttpWebSocketMessage,
) -> Result<(), RhttpError> {
    handle
        .msg_tx
        .send(msg)
        .map_err(|_| RhttpError::RhttpUnknownError("WebSocket channel closed".into()))
}

async fn connect_websocket(
    client: &reqwest::Client,
    request: reqwest::Request,
) -> Result<WebSocket, RhttpError> {
    log::info!("Sending UPGRADE request to {}", request.url().as_str());
    let builder = reqwest::RequestBuilder::from_parts(client.clone(), request);

    let response = builder.upgrade().send().await.map_err(map_ws_error)?;

    let websocket = response.into_websocket().await.map_err(map_ws_error)?;

    Ok(websocket)
}
