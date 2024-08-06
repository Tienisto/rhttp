use std::fmt::Display;

#[derive(Debug)]
pub enum RhttpError {
    RhttpCancelError(String),
    RhttpTimeoutError(String),
    RhttpInvalidClientError,
    RhttpUnknownError(String),
}

impl Display for RhttpError {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        match self {
            RhttpError::RhttpCancelError(s) => write!(f, "RhttpCancelException: {s}"),
            RhttpError::RhttpTimeoutError(s) => write!(f, "RhttpTimeoutException: {s}"),
            RhttpError::RhttpInvalidClientError => write!(f, "RhttpInvalidClientException"),
            RhttpError::RhttpUnknownError(e) => write!(f, "{}", e),
        }
    }
}

impl std::error::Error for RhttpError {}
