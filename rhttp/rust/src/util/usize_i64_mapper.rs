/// Converts usize values to i64 values by using the negative range of i64 values.
/// This works because we are assuming that there are no 128-bit systems.
pub(crate) fn usize_to_i64(value: usize) -> i64 {
    if value > i64::MAX as usize {
        // Map values larger than i64::MAX to negative i64 values
        (-(value as i128) + i64::MAX as i128) as i64
    } else {
        value as i64
    }
}

pub(crate) fn i64_to_usize(value: i64) -> usize {
    if value < 0 {
        // Map negative i64 values back to large usize values
        (-(value as i128) + i64::MAX as i128) as usize
    } else {
        value as usize
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_usize_to_i64() {
        assert_eq!(usize_to_i64(0), 0);
        assert_eq!(usize_to_i64(1), 1);
        assert_eq!(usize_to_i64(9223372036854775807), 9223372036854775807);
        assert_eq!(usize_to_i64(9223372036854775808), -1);
        assert_eq!(usize_to_i64(9223372036854775809), -2);
        assert_eq!(usize_to_i64(18446744073709551614), -9223372036854775807);
        assert_eq!(usize_to_i64(18446744073709551615), -9223372036854775808);
    }

    #[test]
    fn test_i64_to_usize() {
        assert_eq!(i64_to_usize(0), 0);
        assert_eq!(i64_to_usize(1), 1);
        assert_eq!(i64_to_usize(9223372036854775807), 9223372036854775807);
        assert_eq!(i64_to_usize(-1), 9223372036854775808);
        assert_eq!(i64_to_usize(-2), 9223372036854775809);
        assert_eq!(i64_to_usize(-9223372036854775807), 18446744073709551614);
        assert_eq!(i64_to_usize(-9223372036854775808), 18446744073709551615);
    }

    #[test]
    fn test_integration() {
        let test_values: Vec<usize> = vec![
            0,
            1,
            (i64::MAX as usize) - 1,
            i64::MAX as usize,
            (i64::MAX as usize) + 1,
            (i64::MAX as usize) + 2,
            usize::MAX,
        ];

        for &val in &test_values {
            let converted = usize_to_i64(val);
            let reverted = i64_to_usize(converted);
            assert_eq!(val, reverted, "Failed for value: {val}");
        }
    }
}
