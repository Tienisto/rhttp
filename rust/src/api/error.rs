use crate::api::http::HttpResponseBody;
use std::fmt::Display;

#[derive(Debug)]
pub enum RhttpError {
    RhttpCancelError(String),
    RhttpTimeoutError(String),
    RhttpStatusCodeError(String, u16, Vec<(String, String)>, HttpResponseBody),
    RhttpInvalidCertificateError(String, String),
    RhttpInvalidClientError,
    RhttpUnknownError(String),
}

impl Display for RhttpError {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        match self {
            RhttpError::RhttpCancelError(s) => write!(f, "RhttpCancelError: {s}"),
            RhttpError::RhttpTimeoutError(s) => write!(f, "RhttpTimeoutError: {s}"),
            RhttpError::RhttpStatusCodeError(s, i, _, _) => {
                write!(f, "RhttpStatusCodeError: {i} - {s}")
            }
            RhttpError::RhttpInvalidCertificateError(s, d) => {
                write!(f, "RhttpInvalidCertificateError: {s}, {d}")
            }
            RhttpError::RhttpInvalidClientError => write!(f, "RhttpInvalidClientError"),
            RhttpError::RhttpUnknownError(e) => write!(f, "{}", e),
        }
    }
}

impl std::error::Error for RhttpError {}
