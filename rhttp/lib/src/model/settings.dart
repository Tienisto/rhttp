import 'dart:typed_data';

import 'package:meta/meta.dart';
import 'package:rhttp/src/model/request.dart';
import 'package:rhttp/src/rust/api/client.dart' as rust_client;
import 'package:rhttp/src/rust/api/http.dart' as rust;

export 'package:rhttp/src/rust/api/client.dart' show TlsVersion;

const _keepDuration = Duration(microseconds: -9999);
const _keepProxySettings = ProxySettings.noProxy();
const _keepTlsSettings = TlsSettings();

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

  /// Proxy settings.
  final ProxySettings? proxySettings;

  /// TLS settings.
  final TlsSettings? tlsSettings;

  const ClientSettings({
    this.httpVersionPref = HttpVersionPref.all,
    this.timeout,
    this.connectTimeout,
    this.throwOnStatusCode = true,
    this.proxySettings,
    this.tlsSettings,
  });

  ClientSettings copyWith({
    HttpVersionPref? httpVersionPref,
    Duration? timeout = _keepDuration,
    Duration? connectTimeout = _keepDuration,
    bool? throwOnStatusCode,
    ProxySettings? proxySettings = _keepProxySettings,
    TlsSettings? tlsSettings = _keepTlsSettings,
  }) {
    return ClientSettings(
      httpVersionPref: httpVersionPref ?? this.httpVersionPref,
      timeout: identical(timeout, _keepDuration) ? this.timeout : timeout,
      connectTimeout: identical(connectTimeout, _keepDuration)
          ? this.connectTimeout
          : connectTimeout,
      throwOnStatusCode: throwOnStatusCode ?? this.throwOnStatusCode,
      proxySettings: identical(proxySettings, _keepProxySettings)
          ? this.proxySettings
          : proxySettings,
      tlsSettings: identical(tlsSettings, _keepTlsSettings)
          ? this.tlsSettings
          : tlsSettings,
    );
  }
}

sealed class ProxySettings {
  const ProxySettings();

  /// Disables any proxy settings including system settings.
  const factory ProxySettings.noProxy() = NoProxy;
}

class NoProxy extends ProxySettings {
  const NoProxy();
}

/// TLS settings for the client.
/// Used to configure HTTPS connections.
class TlsSettings {
  /// Trust the root certificates that are pre-installed on the system.
  final bool trustRootCertificates;

  /// The trusted root certificates in PEM format.
  /// Either specify the root certificate or the full
  /// certificate chain.
  /// The Rust API currently doesn't support trusting a single leaf certificate.
  /// Hint: PEM format starts with `-----BEGIN CERTIFICATE-----`.
  final List<String> trustedRootCertificates;

  /// Verify the server's certificate.
  /// If set to `false`, the client will accept any certificate.
  /// This is insecure and should only be used for testing.
  final bool verifyCertificates;

  /// The client certificate to use.
  /// This is used for client authentication / mutual TLS.
  final ClientCertificate? clientCertificate;

  /// The minimum TLS version to use.
  final rust_client.TlsVersion? minTlsVersion;

  /// The maximum TLS version to use.
  final rust_client.TlsVersion? maxTlsVersion;

  const TlsSettings({
    this.trustRootCertificates = true,
    this.trustedRootCertificates = const [],
    this.verifyCertificates = true,
    this.clientCertificate,
    this.minTlsVersion,
    this.maxTlsVersion,
  });
}

/// A client certificate for client authentication / mutual TLS.
class ClientCertificate {
  /// The certificate in PEM format.
  final String certificate;

  /// The private key in PEM format.
  final String privateKey;

  const ClientCertificate({
    required this.certificate,
    required this.privateKey,
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
      proxySettings: proxySettings?._toRustType(),
      tlsSettings: tlsSettings?._toRustType(),
    );
  }
}

extension on ProxySettings {
  rust_client.ProxySettings _toRustType() {
    return switch (this) {
      NoProxy() => rust_client.ProxySettings.noProxy,
    };
  }
}

extension on TlsSettings {
  rust_client.TlsSettings _toRustType() {
    return rust_client.TlsSettings(
      trustRootCertificates: trustRootCertificates,
      trustedRootCertificates: trustedRootCertificates
          .map((e) => Uint8List.fromList(e.codeUnits))
          .toList(),
      verifyCertificates: verifyCertificates,
      clientCertificate: clientCertificate?._toRustType(),
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

extension on ClientCertificate {
  rust_client.ClientCertificate _toRustType() {
    return rust_client.ClientCertificate(
      certificate: Uint8List.fromList(certificate.codeUnits),
      privateKey: Uint8List.fromList(privateKey.codeUnits),
    );
  }
}
