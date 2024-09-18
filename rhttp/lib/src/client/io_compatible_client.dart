import 'dart:async';
import 'dart:io';
import 'package:rhttp/src/client/rhttp_client.dart';
import 'package:rhttp/src/interceptor/interceptor.dart';
import 'package:rhttp/src/model/request.dart';
import 'package:rhttp/src/model/settings.dart';

/// An HTTP client that is compatible with Dart's `HttpClient` but internally uses `RhttpClient`.
/// This allows for more control over HTTP requests while leveraging the `RhttpClient` features.
class IoCompatibleClient implements HttpClient {
  final RhttpClient _rhttpClient;

  IoCompatibleClient._(this._rhttpClient);

  /// Creates an `IoCompatibleClient` instance with optional `ClientSettings`.
  static Future<IoCompatibleClient> create({
    ClientSettings? settings,
    List<Interceptor>? interceptors,
  }) async {
    final rhttpClient = await RhttpClient.create(
      settings: (settings ?? const ClientSettings()),
      interceptors: interceptors,
    );
    return IoCompatibleClient._(rhttpClient);
  }

  /// Use this method for synchronous client creation.
  factory IoCompatibleClient.createSync({
    ClientSettings? settings,
    List<Interceptor>? interceptors,
  }) {
    final rhttpClient = RhttpClient.createSync(
      settings: (settings ?? const ClientSettings()),
      interceptors: interceptors,
    );
    return IoCompatibleClient._(rhttpClient);
  }

  @override
  Future<HttpClientRequest> open(
      String method, String host, int port, String path) {
    // Convert the provided information into an Rhttp request.
    final url =
        Uri(scheme: 'http', host: host, port: port, path: path).toString();
    return _handleRequest(method, url);
  }

  @override
  Future<HttpClientRequest> openUrl(String method, Uri url) {
    return _handleRequest(method, url.toString());
  }

  // this is wrong and dont know how it can be handled
  Future<HttpClientRequest> _handleRequest(String method, String url) async {
    final request = Request(
      method: HttpMethod.values.firstWhere(
          (e) => e.toString().split('.').last == method.toUpperCase()),
      url: url,
    );
    final response = await _rhttpClient.requestStream(
      method: request.method,
      url: request.url,
    );
    return HttpClientRequest(request, response);
  }

  @override
  Future<HttpClientRequest> delete(String host, int port, String path) =>
      open('DELETE', host, port, path);

  @override
  Future<HttpClientRequest> deleteUrl(Uri url) => openUrl('DELETE', url);

  @override
  Future<HttpClientRequest> get(String host, int port, String path) =>
      open('GET', host, port, path);

  @override
  Future<HttpClientRequest> getUrl(Uri url) => openUrl('GET', url);

  @override
  Future<HttpClientRequest> head(String host, int port, String path) =>
      open('HEAD', host, port, path);

  @override
  Future<HttpClientRequest> headUrl(Uri url) => openUrl('HEAD', url);

  @override
  Future<HttpClientRequest> patch(String host, int port, String path) =>
      open('PATCH', host, port, path);

  @override
  Future<HttpClientRequest> patchUrl(Uri url) => openUrl('PATCH', url);

  @override
  Future<HttpClientRequest> post(String host, int port, String path) =>
      open('POST', host, port, path);

  @override
  Future<HttpClientRequest> postUrl(Uri url) => openUrl('POST', url);

  @override
  Future<HttpClientRequest> put(String host, int port, String path) =>
      open('PUT', host, port, path);

  @override
  Future<HttpClientRequest> putUrl(Uri url) => openUrl('PUT', url);

  @override
  void close({bool force = false}) {
    _rhttpClient.dispose(cancelRunningRequests: force);
  }

  // Authentication and other proxy-related settings.
  @override
  void addCredentials(
      Uri url, String realm, HttpClientCredentials credentials) {
    throw UnimplementedError(
        'addCredentials is not supported in IoCompatibleClient.');
  }

  @override
  void addProxyCredentials(
      String host, int port, String realm, HttpClientCredentials credentials) {
    throw UnimplementedError(
        'addProxyCredentials is not supported in IoCompatibleClient.');
  }

  @override
  set authenticate(
      Future<bool> Function(Uri url, String scheme, String? realm)? f) {
    throw UnimplementedError(
        'Authentication is not supported in IoCompatibleClient.');
  }

  @override
  set authenticateProxy(
      Future<bool> Function(
              String host, int port, String scheme, String? realm)?
          f) {
    throw UnimplementedError(
        'Proxy authentication is not supported in IoCompatibleClient.');
  }

  @override
  set badCertificateCallback(
      bool Function(X509Certificate cert, String host, int port)? callback) {
    throw UnimplementedError(
        'badCertificateCallback is not supported in IoCompatibleClient.');
  }

  @override
  set connectionFactory(
      Future<ConnectionTask<Socket>> Function(
              Uri url, String? proxyHost, int? proxyPort)?
          f) {
    throw UnimplementedError(
        'Connection factory is not supported in IoCompatibleClient.');
  }

  @override
  set findProxy(String Function(Uri url)? f) {
    throw UnimplementedError(
        'findProxy is not supported in IoCompatibleClient.');
  }

  @override
  set keyLog(Function(String line)? callback) {
    throw UnimplementedError('keyLog is not supported in IoCompatibleClient.');
  }

  // Connection timeout and properties.
  @override
  bool autoUncompress = true;

  @override
  Duration? connectionTimeout;

  @override
  Duration idleTimeout = const Duration(seconds: 15);

  @override
  int? maxConnectionsPerHost;

  @override
  String? userAgent;

  // Custom extensions for ClientSettings compatibility.
  ClientSettings digestSettings(ClientSettings settings) {
    return settings.copyWith(throwOnStatusCode: false);
  }
}
