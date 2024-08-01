import 'package:rhttp/src/rust/api/http.dart' as rust;
import 'package:rhttp/src/rust/frb_generated.dart';

export 'package:rhttp/src/rust/api/http.dart' show HttpResult, HttpVersion;

enum HttpMethod {
  options,
  get,
  post,
  put,
  delete,
  head,
  trace,
  connect,
  patch,
  ;
}

enum HttpVersionPref {
  /// Only use HTTP/1.
  http1,

  /// Only use HTTP/2.
  http2,

  /// Default behavior: Use the latest HTTP version supported by the server.
  all,
  ;
}

class Rhttp {
  /// Initializes the Rust library.
  static Future<void> init() async {
    await RustLib.init();
  }

  /// Makes an HTTP request.
  static Future<rust.HttpResult> request({
    required HttpMethod method,
    required String url,
    HttpVersionPref? httpVersion,
  }) async {
    return await rust.makeHttpRequest(
      method: method._toRustType(),
      url: url,
      httpVersion: httpVersion?._toRustType() ?? rust.HttpVersionPref.all,
    );
  }

  /// Makes an HTTP GET request.
  static Future<rust.HttpResult> get(String url, {HttpVersionPref? httpVersion}) async {
    return await request(
      method: HttpMethod.get,
      url: url,
      httpVersion: httpVersion,
    );
  }
}

extension on HttpMethod {
  rust.HttpMethod _toRustType() {
    return switch (this) {
      HttpMethod.options => rust.HttpMethod.options,
      HttpMethod.get => rust.HttpMethod.get_,
      HttpMethod.post => rust.HttpMethod.post,
      HttpMethod.put => rust.HttpMethod.put,
      HttpMethod.delete => rust.HttpMethod.delete,
      HttpMethod.head => rust.HttpMethod.head,
      HttpMethod.trace => rust.HttpMethod.trace,
      HttpMethod.connect => rust.HttpMethod.connect,
      HttpMethod.patch => rust.HttpMethod.patch,
    };
  }
}

extension on HttpVersionPref {
  rust.HttpVersionPref _toRustType() {
    return switch (this) {
      HttpVersionPref.http1 => rust.HttpVersionPref.http1,
      HttpVersionPref.http2 => rust.HttpVersionPref.http2,
      HttpVersionPref.all => rust.HttpVersionPref.all,
    };
  }
}
