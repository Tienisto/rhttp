import 'dart:typed_data';

import 'package:meta/meta.dart';
import 'package:rhttp/src/rust/api/error.dart' as rust;
import 'package:rhttp/src/rust/api/http.dart' as rust_http;

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

/// An exception thrown on a 4xx or 5xx status code.
class RhttpStatusCodeException extends RhttpException {
  /// The URL of the request that returned the status code.
  final String url;

  /// The status code of the response.
  final int statusCode;

  /// Response headers.
  final List<(String, String)> headers;

  Map<String, String> get headerMap => {
        for (final entry in headers) entry.$1: entry.$2,
      };

  /// The response body. For simplicity, we don't differentiate between
  /// text or bytes. Streams are always null.
  /// Can be [String], [Uint8List], or null.
  final Object? body;

  const RhttpStatusCodeException({
    required this.url,
    required this.statusCode,
    required this.headers,
    required this.body,
  });

  @override
  String toString() => '[$runtimeType] Status code: $statusCode. URL: $url';
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
    rhttpStatusCodeError: (url, code, headers, body) =>
        RhttpStatusCodeException(
      url: url,
      statusCode: code,
      headers: headers,
      body: switch (body) {
        rust_http.HttpResponseBody_Text() => body.field0,
        rust_http.HttpResponseBody_Bytes() => body.field0,
        rust_http.HttpResponseBody_Stream() => null,
      },
    ),
    rhttpInvalidClientError: () => const RhttpInvalidClientException(),
    rhttpUnknownError: (message) => RhttpUnknownException(message),
  );
}
