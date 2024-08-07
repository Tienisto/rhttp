use crate::api::client::{ClientSettings, TlsVersion};
use crate::api::error::RhttpError;
use crate::api::http::HttpVersionPref;
use crate::util::i64_address::get_i64_address;
use reqwest::tls;
use std::collections::HashMap;
use std::sync::{Arc, LazyLock, Mutex};

static HTTP_CLIENTS: LazyLock<Arc<Mutex<HashMap<i64, RequestClient>>>> =
    LazyLock::new(|| Arc::new(Mutex::new(HashMap::new())));

#[derive(Clone)]
pub(crate) struct RequestClient {
    pub(crate) client: reqwest::Client,
    pub(crate) http_version_pref: HttpVersionPref,
    pub(crate) throw_on_status_code: bool,
}

impl RequestClient {
    pub(crate) fn new_default() -> Self {
        create_client(ClientSettings::default()).unwrap()
    }
}

pub(crate) fn create_client(settings: ClientSettings) -> Result<RequestClient, RhttpError> {
    let client: reqwest::Client = {
        let mut client = reqwest::Client::builder();
        if let Some(timeout) = settings.timeout {
            client = client.timeout(
                timeout
                    .to_std()
                    .map_err(|e| RhttpError::RhttpUnknownError(e.to_string()))?,
            );
        }
        if let Some(timeout) = settings.connect_timeout {
            client = client.connect_timeout(
                timeout
                    .to_std()
                    .map_err(|e| RhttpError::RhttpUnknownError(e.to_string()))?,
            );
        }

        if let Some(tls_settings) = settings.tls_settings {
            if !tls_settings.verify_certificates {
                client = client.danger_accept_invalid_certs(true);
            }

            if let Some(min_tls_version) = tls_settings.min_tls_version {
                client = client.min_tls_version(match min_tls_version {
                    TlsVersion::Tls1_2 => tls::Version::TLS_1_2,
                    TlsVersion::Tls1_3 => tls::Version::TLS_1_3,
                });
            }

            if let Some(max_tls_version) = tls_settings.max_tls_version {
                client = client.max_tls_version(match max_tls_version {
                    TlsVersion::Tls1_2 => tls::Version::TLS_1_2,
                    TlsVersion::Tls1_3 => tls::Version::TLS_1_3,
                });
            }
        }

        client = match settings.http_version_pref {
            HttpVersionPref::Http10 | HttpVersionPref::Http11 => client.http1_only(),
            HttpVersionPref::Http2 => client.http2_prior_knowledge(),
            HttpVersionPref::Http3 => client.http3_prior_knowledge(),
            HttpVersionPref::All => client,
        };

        client
            .build()
            .map_err(|e| RhttpError::RhttpUnknownError(e.to_string()))?
    };

    Ok(RequestClient {
        client,
        http_version_pref: settings.http_version_pref,
        throw_on_status_code: settings.throw_on_status_code,
    })
}

pub(crate) fn register_client(
    settings: ClientSettings,
) -> Result<(i64, RequestClient), RhttpError> {
    let request_client = create_client(settings)?;
    let request_client_cloned = request_client.clone();

    let address = get_i64_address(&request_client);

    let mut map = HTTP_CLIENTS.lock().unwrap();
    map.insert(address, request_client);

    Ok((address, request_client_cloned))
}

pub(crate) fn get_client(address: i64) -> Option<RequestClient> {
    let clients = HTTP_CLIENTS.lock().ok()?;
    let client = clients.get(&address)?;
    Some(client.clone())
}

pub(crate) fn remove_client(address: i64) {
    if let Ok(mut clients) = HTTP_CLIENTS.lock() {
        clients.remove(&address);
    }
}
