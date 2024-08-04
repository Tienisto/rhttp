use crate::util::i64_address::get_i64_address;
use std::collections::HashMap;
use std::sync::{Arc, LazyLock, Mutex};
use tokio_util::sync::CancellationToken;

static CANCEL_TOKENS: LazyLock<Arc<Mutex<HashMap<i64, CancellationToken>>>> =
    LazyLock::new(|| Arc::new(Mutex::new(HashMap::new())));

pub(crate) fn register_token(token: CancellationToken) -> i64 {
    let address = get_i64_address(&token);

    let mut map = CANCEL_TOKENS.lock().unwrap();
    map.insert(address, token);

    address
}

pub(crate) fn get_token(address: i64) -> Option<CancellationToken> {
    let map = CANCEL_TOKENS.lock().unwrap();
    map.get(&address).cloned()
}

pub(crate) fn remove_token(address: i64) -> Option<CancellationToken> {
    let mut map = CANCEL_TOKENS.lock().unwrap();
    map.remove(&address)
}
