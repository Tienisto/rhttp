use crate::api::error::RhttpError;
use flutter_rust_bridge::for_generated::futures::channel::mpsc;
use futures_util::SinkExt;

pub struct Dart2RustStreamSink {
    sender: mpsc::Sender<Vec<u8>>,
}

pub struct Dart2RustStreamReceiver {
    pub(crate) receiver: mpsc::Receiver<Vec<u8>>,
}

pub fn create_stream() -> (Dart2RustStreamSink, Dart2RustStreamReceiver) {
    let (sender, receiver) = mpsc::channel(16 * 1024); // 16KB buffer
    (
        Dart2RustStreamSink { sender },
        Dart2RustStreamReceiver { receiver },
    )
}

impl Dart2RustStreamSink {
    pub async fn add(&mut self, data: Vec<u8>) -> Result<(), RhttpError> {
        self.sender
            .send(data)
            .await
            .map_err(|_| RhttpError::RhttpUnknownError("Failed to send data".to_string()))
    }

    pub async fn close(&mut self) -> Result<(), RhttpError> {
        self.sender
            .close()
            .await
            .map_err(|_| RhttpError::RhttpUnknownError("Failed to close stream".to_string()))
    }
}
