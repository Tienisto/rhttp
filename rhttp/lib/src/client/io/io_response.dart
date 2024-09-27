import 'dart:async';
import 'dart:io';

import 'package:meta/meta.dart';
import 'package:rhttp/src/model/response.dart';

@internal
class RhttpIoResponse with Stream<List<int>> implements HttpClientResponse {
  final HttpStreamResponse _response;

  RhttpIoResponse(this._response);

  @override
  int get statusCode => _response.statusCode;

  @override
  int get contentLength =>
      int.tryParse(_response.headerMap['content-length'] ?? '-1') ?? -1;

  @override
  HttpHeaders get headers => throw UnimplementedError();

  @override
  X509Certificate? get certificate => throw UnimplementedError();

  @override
  HttpClientResponseCompressionState get compressionState =>
      throw UnimplementedError();

  @override
  HttpConnectionInfo? get connectionInfo => throw UnimplementedError();

  @override
  List<Cookie> get cookies => throw UnimplementedError();

  @override
  Future<Socket> detachSocket() => throw UnimplementedError();

  @override
  bool get isRedirect => throw UnimplementedError();

  @override
  StreamSubscription<List<int>> listen(
    void Function(List<int> event)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return _response.body.listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }

  @override
  bool get persistentConnection => throw UnimplementedError();

  @override
  String get reasonPhrase => throw UnimplementedError();

  @override
  Future<HttpClientResponse> redirect(
      [String? method, Uri? url, bool? followLoops]) {
    throw UnimplementedError();
  }

  @override
  List<RedirectInfo> get redirects => throw UnimplementedError();
}
