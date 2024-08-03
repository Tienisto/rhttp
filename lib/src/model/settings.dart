import 'package:meta/meta.dart';
import 'package:rhttp/src/model/request.dart';
import 'package:rhttp/src/rust/api/client.dart' as rust_client;
import 'package:rhttp/src/rust/api/http.dart' as rust;

class ClientSettings {
  /// The preferred HTTP version to use.
  final HttpVersionPref httpVersionPref;

  /// The timeout for the request including time to establish a connection.
  final Duration? timeout;

  /// The timeout for establishing a connection.
  /// See [timeout] for the total timeout.
  final Duration? connectTimeout;

  /// Throws an exception if the status code is not 2xx.
  final bool throwOnStatusCode;

  const ClientSettings({
    this.httpVersionPref = HttpVersionPref.all,
    this.timeout,
    this.connectTimeout,
    this.throwOnStatusCode = false,
  });
}

@internal
extension ClientSettingsExt on ClientSettings {
  rust_client.ClientSettings toRustType() {
    return rust_client.ClientSettings(
      httpVersionPref: httpVersionPref._toRustType(),
      timeout: timeout,
      connectTimeout: connectTimeout,
    );
  }
}

extension on HttpVersionPref {
  rust.HttpVersionPref _toRustType() {
    return switch (this) {
      HttpVersionPref.http1_0 => rust.HttpVersionPref.http10,
      HttpVersionPref.http1_1 => rust.HttpVersionPref.http11,
      HttpVersionPref.http2 => rust.HttpVersionPref.http2,
      HttpVersionPref.http3 => rust.HttpVersionPref.http3,
      HttpVersionPref.all => rust.HttpVersionPref.all,
    };
  }
}
