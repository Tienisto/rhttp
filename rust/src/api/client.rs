use crate::api::http::HttpVersionPref;
use chrono::Duration;

pub struct ClientSettings {
    pub http_version_pref: HttpVersionPref,
    pub timeout: Option<Duration>,
    pub connect_timeout: Option<Duration>,
    pub throw_on_status_code: bool,
    pub tls_settings: Option<TlsSettings>,
}

pub struct TlsSettings {
    pub verify_certificates: bool,
    pub min_tls_version: Option<TlsVersion>,
    pub max_tls_version: Option<TlsVersion>,
}

pub enum TlsVersion {
    Tls1_2,
    Tls1_3,
}

impl Default for ClientSettings {
    fn default() -> Self {
        ClientSettings {
            http_version_pref: HttpVersionPref::All,
            timeout: None,
            connect_timeout: None,
            throw_on_status_code: true,
            tls_settings: None,
        }
    }
}
