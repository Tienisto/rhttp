use crate::api::http::HttpVersionPref;
use chrono::Duration;

pub struct ClientSettings {
    pub http_version_pref: HttpVersionPref,
    pub timeout: Option<Duration>,
    pub connect_timeout: Option<Duration>,
}

impl Default for ClientSettings {
    fn default() -> Self {
        ClientSettings {
            http_version_pref: HttpVersionPref::All,
            timeout: None,
            connect_timeout: None,
        }
    }
}
