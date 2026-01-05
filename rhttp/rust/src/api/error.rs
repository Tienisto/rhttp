use crate::api::http::HttpResponseBody;
use std::fmt::Display;

#[derive(Clone, Debug)]
pub enum RhttpError {
    RhttpCancelError,
    RhttpTimeoutError,
    RhttpRedirectError,
    RhttpStatusCodeError(u16, Vec<(String, String)>, HttpResponseBody),
    RhttpInvalidCertificateError(String),
    RhttpConnectionError(String),
    RhttpUnknownError(String),
    RhttpWebSocketError(WebSocketError),
}

// Flutter Rust Bridge only supports anyhow, so we define string constants for the error messages.
pub(crate) const STREAM_CANCEL_ERROR: &str = "STREAM_CANCEL_ERROR";

impl Display for RhttpError {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        match self {
            RhttpError::RhttpCancelError => write!(f, "RhttpCancelError"),
            RhttpError::RhttpTimeoutError => write!(f, "RhttpTimeoutError"),
            RhttpError::RhttpRedirectError => write!(f, "RhttpRedirectError"),
            RhttpError::RhttpStatusCodeError(i, _, _) => {
                write!(f, "RhttpStatusCodeError: {i}")
            }
            RhttpError::RhttpInvalidCertificateError(d) => {
                write!(f, "RhttpInvalidCertificateError: {d}")
            }
            RhttpError::RhttpConnectionError(e) => write!(f, "RhttpConnectionError: {e}"),
            RhttpError::RhttpUnknownError(e) => write!(f, "{}", e),
            RhttpError::RhttpWebSocketError(e) => write!(f, "RhttpWebSocketError: {e}"),
        }
    }
}

impl std::error::Error for RhttpError {}

#[derive(Debug, Clone)]
pub enum WebSocketError {
    /// HTTP upgrade failed (not a 101 response, bad headers, and so on).
    HandshakeFailed { status: u16, reason: Option<String> },

    /// WebSocket protocol violation after upgrade.
    ProtocolError { message: String },

    /// An IO or transport-level failure occurred.
    TransportError { message: String },

    /// The peer closed the connection unexpectedly.
    ConnectionClosed {
        code: Option<u16>,
        reason: Option<String>,
    },

    /// A local close was initiated.
    ClosedLocally,

    /// An unknown error occurred during WebSocket usage.
    Unknown,
}

impl Display for WebSocketError {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        match self {
            WebSocketError::HandshakeFailed { status, reason } => {
                if let Some(reason) = reason {
                    return write!(f, "Handshake failed with {status}, reason: {reason}");
                }

                write!(f, "Handshake failed with {status}")
            }
            WebSocketError::ProtocolError { message } => write!(f, "Protocol Error: {message}"),
            WebSocketError::TransportError { message } => write!(f, "Transport Error: {message}"),
            WebSocketError::ConnectionClosed { code, reason } => {
                if let Some(reason) = reason {
                    if let Some(code) = code {
                        return write!(f, "Connection closed. Code {code}, reason: {reason}");
                    }

                    return write!(f, "Connection closed. Reason: {reason}");
                }

                if let Some(code) = code {
                    return write!(f, "Connection closed with code: {code}");
                }

                write!(f, "Connection closed.")
            }
            WebSocketError::ClosedLocally => write!(f, "Closed locally."),
            WebSocketError::Unknown => write!(f, "Unknown."),
        }
    }
}
