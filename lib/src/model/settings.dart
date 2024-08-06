import 'package:meta/meta.dart';
import 'package:rhttp/src/model/request.dart';
import 'package:rhttp/src/rust/api/client.dart' as rust_client;
import 'package:rhttp/src/rust/api/http.dart' as rust;

export 'package:rhttp/src/rust/api/client.dart' show TlsVersion;

class ClientSettings {
  /// The preferred HTTP version to use.
  final HttpVersionPref httpVersionPref;

  /// The timeout for the request including time to establish a connection.
  final Duration? timeout;

  /// The timeout for establishing a connection.
  /// See [timeout] for the total timeout.
  final Duration? connectTimeout;

  /// Throws an exception if the status code is 4xx or 5xx.
  final bool throwOnStatusCode;

  /// TLS settings.
  final TlsSettings? tlsSettings;

  const ClientSettings({
    this.httpVersionPref = HttpVersionPref.all,
    this.timeout,
    this.connectTimeout,
    this.throwOnStatusCode = true,
    this.tlsSettings,
  });
}

/// TLS settings for the client.
/// Used to configure HTTPS connections.
class TlsSettings {
  /// Verify the server's certificate.
  /// If set to `false`, the client will accept any certificate.
  /// This is insecure and should only be used for testing.
  final bool verifyCerts;

  /// The minimum TLS version to use.
  final rust_client.TlsVersion? minTlsVersion;

  /// The maximum TLS version to use.
  final rust_client.TlsVersion? maxTlsVersion;

  const TlsSettings({
    this.verifyCerts = true,
    this.minTlsVersion,
    this.maxTlsVersion,
  });
}

@internal
extension ClientSettingsExt on ClientSettings {
  rust_client.ClientSettings toRustType() {
    return rust_client.ClientSettings(
      httpVersionPref: httpVersionPref._toRustType(),
      timeout: timeout,
      connectTimeout: connectTimeout,
      throwOnStatusCode: throwOnStatusCode,
      tlsSettings: tlsSettings?._toRustType(),
    );
  }
}

extension on TlsSettings {
  rust_client.TlsSettings _toRustType() {
    return rust_client.TlsSettings(
      verifyCerts: verifyCerts,
      minTlsVersion: minTlsVersion,
      maxTlsVersion: maxTlsVersion,
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
