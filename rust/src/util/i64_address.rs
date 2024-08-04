use crate::util::usize_i64_mapper::usize_to_i64;

pub(crate) fn get_i64_address<T>(value: &T) -> i64 {
    let address = value as *const T as usize;
    usize_to_i64(address)
}
