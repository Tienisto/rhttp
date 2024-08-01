import 'package:rhttp/src/rust/api/http.dart' as rust;
import 'package:rhttp/src/rust/frb_generated.dart';

export 'package:rhttp/src/rust/api/http.dart' show HttpResponse, HttpVersion;

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

  /// Only use HTTP/3.
  http3,

  /// Default behavior: Let the server decide.
  all,
  ;
}

class Rhttp {
  /// Initializes the Rust library.
  static Future<void> init() async {
    await RustLib.init();
  }

  /// Makes an HTTP request.
  static Future<rust.HttpResponse> request({
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
  static Future<rust.HttpResponse> get(
    String url, {
    HttpVersionPref? httpVersion,
  }) async {
    return await request(
      method: HttpMethod.get,
      url: url,
      httpVersion: httpVersion,
    );
  }

  /// Makes an HTTP POST request.
  static Future<rust.HttpResponse> post(
    String url, {
    HttpVersionPref? httpVersion,
  }) async {
    return await request(
      method: HttpMethod.post,
      url: url,
      httpVersion: httpVersion,
    );
  }

  /// Makes an HTTP PUT request.
  static Future<rust.HttpResponse> put(
    String url, {
    HttpVersionPref? httpVersion,
  }) async {
    return await request(
      method: HttpMethod.put,
      url: url,
      httpVersion: httpVersion,
    );
  }

  /// Makes an HTTP DELETE request.
  static Future<rust.HttpResponse> delete(
    String url, {
    HttpVersionPref? httpVersion,
  }) async {
    return await request(
      method: HttpMethod.delete,
      url: url,
      httpVersion: httpVersion,
    );
  }

  /// Makes an HTTP HEAD request.
  static Future<rust.HttpResponse> head(
    String url, {
    HttpVersionPref? httpVersion,
  }) async {
    return await request(
      method: HttpMethod.head,
      url: url,
      httpVersion: httpVersion,
    );
  }

  /// Makes an HTTP PATCH request.
  static Future<rust.HttpResponse> patch(
    String url, {
    HttpVersionPref? httpVersion,
  }) async {
    return await request(
      method: HttpMethod.patch,
      url: url,
      httpVersion: httpVersion,
    );
  }

  /// Makes an HTTP OPTIONS request.
  static Future<rust.HttpResponse> options(
    String url, {
    HttpVersionPref? httpVersion,
  }) async {
    return await request(
      method: HttpMethod.options,
      url: url,
      httpVersion: httpVersion,
    );
  }

  /// Makes an HTTP TRACE request.
  static Future<rust.HttpResponse> trace(
    String url, {
    HttpVersionPref? httpVersion,
  }) async {
    return await request(
      method: HttpMethod.trace,
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
      HttpVersionPref.http3 => rust.HttpVersionPref.http3,
      HttpVersionPref.all => rust.HttpVersionPref.all,
    };
  }
}
