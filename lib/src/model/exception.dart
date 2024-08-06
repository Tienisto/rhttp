import 'package:meta/meta.dart';
import 'package:rhttp/src/rust/api/error.dart' as rust;

/// The base class for all exceptions thrown by the `rhttp` library.
sealed class RhttpException {
  const RhttpException();
}

/// An exception thrown when a request is canceled.
class RhttpCancelException extends RhttpException {
  /// The URL of the request that was canceled.
  final String url;

  const RhttpCancelException(this.url);

  @override
  String toString() => '[$runtimeType] Request was canceled. URL: $url';
}

/// An exception thrown when a request times out.
class RhttpTimeoutException extends RhttpException {
  /// The URL of the request that timed out.
  final String url;

  const RhttpTimeoutException(this.url);

  @override
  String toString() => '[$runtimeType] Request timed out. URL: $url';
}

/// An exception thrown a request is made with an invalid client.
class RhttpInvalidClientException extends RhttpException {
  const RhttpInvalidClientException();

  @override
  String toString() =>
      '[$runtimeType] Invalid client. Is the client already disposed?';
}

/// An exception thrown when an unknown error occurs.
class RhttpUnknownException extends RhttpException {
  /// The error message
  final String message;

  const RhttpUnknownException(this.message);

  @override
  String toString() => '[$runtimeType] $message';
}

@internal
RhttpException parseError(rust.RhttpError error) {
  return error.when(
    rhttpCancelError: (url) => RhttpCancelException(url),
    rhttpTimeoutError: (url) => RhttpTimeoutException(url),
    rhttpInvalidClientError: () => const RhttpInvalidClientException(),
    rhttpUnknownError: (message) => RhttpUnknownException(message),
  );
}
