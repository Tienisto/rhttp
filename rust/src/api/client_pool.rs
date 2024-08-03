use crate::api::client::ClientSettings;
use crate::api::http::HttpVersionPref;
use anyhow::Result;
use std::collections::HashMap;
use std::sync::{Arc, LazyLock, Mutex};

static HTTP_CLIENTS: LazyLock<Arc<Mutex<HashMap<i64, RequestClient>>>> =
    LazyLock::new(|| Arc::new(Mutex::new(HashMap::new())));

#[derive(Clone)]
pub(crate) struct RequestClient {
    pub(crate) client: reqwest::Client,
    pub(crate) http_version_pref: HttpVersionPref,
}

impl RequestClient {
    pub(crate) fn new_default() -> Self {
        create_client(ClientSettings::default()).unwrap()
    }
}

pub(crate) fn create_client(settings: ClientSettings) -> Result<RequestClient> {
    let client: reqwest::Client = {
        let mut client = reqwest::Client::builder();
        if let Some(timeout) = settings.timeout {
            client = client.timeout(timeout.to_std()?);
        }
        if let Some(timeout) = settings.connect_timeout {
            client = client.connect_timeout(timeout.to_std()?);
        }
        client = match settings.http_version_pref {
            HttpVersionPref::Http10 | HttpVersionPref::Http11 => client.http1_only(),
            HttpVersionPref::Http2 => client.http2_prior_knowledge(),
            HttpVersionPref::Http3 => client.http3_prior_knowledge(),
            HttpVersionPref::All => client,
        };

        client.build()?
    };

    Ok(RequestClient {
        client,
        http_version_pref: settings.http_version_pref,
    })
}

pub(crate) fn register_client(settings: ClientSettings) -> Result<(i64, RequestClient)> {
    let request_client = create_client(settings)?;
    let request_client_cloned = request_client.clone();

    let address = &request_client as *const RequestClient as i64;

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
