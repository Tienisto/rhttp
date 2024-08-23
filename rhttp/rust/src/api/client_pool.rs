use std::collections::HashMap;
use std::sync::{Arc, LazyLock, Mutex};

use crate::api::client::RequestClient;
use crate::api::error::RhttpError;
use crate::util::i64_address::get_i64_address;

static HTTP_CLIENTS: LazyLock<Arc<Mutex<HashMap<i64, RequestClient>>>> =
    LazyLock::new(|| Arc::new(Mutex::new(HashMap::new())));

pub(crate) fn register_client(client: RequestClient) -> Result<(i64, RequestClient), RhttpError> {
    let request_client_cloned = client.clone();

    let address = get_i64_address(&client);

    let mut map = HTTP_CLIENTS.lock().unwrap();
    map.insert(address, client);

    Ok((address, request_client_cloned))
}

pub(crate) fn get_client(address: i64) -> Option<RequestClient> {
    let clients = HTTP_CLIENTS.lock().ok()?;
    let client = clients.get(&address)?;
    Some(client.clone())
}

pub(crate) fn remove_client(address: i64) -> Option<RequestClient> {
    if let Ok(mut clients) = HTTP_CLIENTS.lock() {
        clients.remove(&address)
    } else {
        None
    }
}
