import 'dart:convert';
import 'dart:typed_data';

import 'package:rhttp/src/rust/api/http.dart' as rust;
import 'package:rhttp/src/rust/api/http_types.dart';
import 'package:rhttp/src/rust/frb_generated.dart';

export 'package:rhttp/src/rust/api/http.dart' show HttpResponse, HttpVersion;
export 'package:rhttp/src/rust/api/http_types.dart' show HttpHeaderName;

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

sealed class HttpHeaders {
  const HttpHeaders();

  /// A typed header map with a set of predefined keys.
  const factory HttpHeaders.map(Map<HttpHeaderName, String> map) =
      HttpHeaderMap._;

  /// A raw header map where the keys are strings.
  const factory HttpHeaders.rawMap(Map<String, String> map) =
      HttpHeaderRawMap._;
}

/// A typed header map with a set of predefined keys.
class HttpHeaderMap extends HttpHeaders {
  final Map<HttpHeaderName, String> map;

  const HttpHeaderMap._(this.map);
}

/// A raw header map where the keys are strings.
class HttpHeaderRawMap extends HttpHeaders {
  final Map<String, String> map;

  const HttpHeaderRawMap._(this.map);
}

sealed class HttpBody {
  const HttpBody();

  /// A plain text body.
  const factory HttpBody.text(String text) = HttpBodyText._;

  /// A JSON body.
  /// The Content-Type header will be set to `application/json` if not provided.
  const factory HttpBody.json(Map<String, dynamic> json) = HttpBodyJson._;

  /// A body of raw bytes.
  const factory HttpBody.bytes(Uint8List bytes) = HttpBodyBytes._;

  /// A www-form-urlencoded body.
  /// The Content-Type header will be set to `application/x-www-form-urlencoded`
  /// if not provided.
  const factory HttpBody.form(Map<String, String> form) = HttpBodyForm._;
}

/// A plain text body.
class HttpBodyText extends HttpBody {
  final String text;

  const HttpBodyText._(this.text);
}

/// A JSON body.
/// The Content-Type header will be set to `application/json` if not provided.
class HttpBodyJson extends HttpBody {
  final Map<String, dynamic> json;

  const HttpBodyJson._(this.json);
}

/// A body of raw bytes.
class HttpBodyBytes extends HttpBody {
  final Uint8List bytes;

  const HttpBodyBytes._(this.bytes);
}

/// A www-form-urlencoded body.
/// The Content-Type header will be set to `application/x-www-form-urlencoded`
/// if not provided.
class HttpBodyForm extends HttpBody {
  final Map<String, String> form;

  const HttpBodyForm._(this.form);
}

class Rhttp {
  /// Initializes the Rust library.
  static Future<void> init() async {
    await RustLib.init();
  }

  /// Makes an HTTP request.
  static Future<rust.HttpResponse> request({
    HttpVersionPref? httpVersion,
    required HttpMethod method,
    required String url,
    Map<String, String>? query,
    HttpHeaders? headers,
    HttpBody? body,
  }) async {
    if (body is HttpBodyJson) {
      switch (headers) {
        case HttpHeaderMap map:
          if (map.map.containsKey(HttpHeaderName.contentType)) {
            break;
          }
          headers = HttpHeaderMap._({
            ...map.map,
            HttpHeaderName.contentType: 'application/json',
          });
          break;
        case HttpHeaderRawMap rawMap:
          if (rawMap.map.keys.any((e) => e.toLowerCase() == 'content-type')) {
            break;
          }
          headers = HttpHeaderRawMap._({
            ...rawMap.map,
            'Content-Type': 'application/json',
          });
          break;
        default:
          headers = const HttpHeaderMap._({
            HttpHeaderName.contentType: 'application/json',
          });
          break;
      }
    }
    return await rust.makeHttpRequest(
      httpVersion: httpVersion?._toRustType() ?? rust.HttpVersionPref.all,
      method: method._toRustType(),
      url: url,
      query: query?.entries.map((e) => (e.key, e.value)).toList(),
      headers: headers?._toRustType(),
      body: body?._toRustType(),
    );
  }

  /// Makes an HTTP GET request.
  static Future<rust.HttpResponse> get(
    String url, {
    HttpVersionPref? httpVersion,
    Map<String, String>? query,
    HttpHeaders? headers,
  }) async {
    return await request(
      method: HttpMethod.get,
      url: url,
      httpVersion: httpVersion,
      query: query,
      headers: headers,
    );
  }

  /// Makes an HTTP POST request.
  static Future<rust.HttpResponse> post(
    String url, {
    HttpVersionPref? httpVersion,
    Map<String, String>? query,
    HttpHeaders? headers,
    HttpBody? body,
  }) async {
    return await request(
      method: HttpMethod.post,
      url: url,
      httpVersion: httpVersion,
      query: query,
      headers: headers,
      body: body,
    );
  }

  /// Makes an HTTP PUT request.
  static Future<rust.HttpResponse> put(
    String url, {
    HttpVersionPref? httpVersion,
    Map<String, String>? query,
    HttpHeaders? headers,
    HttpBody? body,
  }) async {
    return await request(
      method: HttpMethod.put,
      url: url,
      httpVersion: httpVersion,
      query: query,
      headers: headers,
      body: body,
    );
  }

  /// Makes an HTTP DELETE request.
  static Future<rust.HttpResponse> delete(
    String url, {
    HttpVersionPref? httpVersion,
    Map<String, String>? query,
    HttpHeaders? headers,
    HttpBody? body,
  }) async {
    return await request(
      method: HttpMethod.delete,
      url: url,
      httpVersion: httpVersion,
      query: query,
      headers: headers,
      body: body,
    );
  }

  /// Makes an HTTP HEAD request.
  static Future<rust.HttpResponse> head(
    String url, {
    HttpVersionPref? httpVersion,
    Map<String, String>? query,
  }) async {
    return await request(
      method: HttpMethod.head,
      url: url,
      httpVersion: httpVersion,
      query: query,
    );
  }

  /// Makes an HTTP PATCH request.
  static Future<rust.HttpResponse> patch(
    String url, {
    HttpVersionPref? httpVersion,
    Map<String, String>? query,
    HttpHeaders? headers,
    HttpBody? body,
  }) async {
    return await request(
      method: HttpMethod.patch,
      url: url,
      httpVersion: httpVersion,
      query: query,
      headers: headers,
      body: body,
    );
  }

  /// Makes an HTTP OPTIONS request.
  static Future<rust.HttpResponse> options(
    String url, {
    HttpVersionPref? httpVersion,
    Map<String, String>? query,
    HttpHeaders? headers,
    HttpBody? body,
  }) async {
    return await request(
      method: HttpMethod.options,
      url: url,
      httpVersion: httpVersion,
      query: query,
      headers: headers,
      body: body,
    );
  }

  /// Makes an HTTP TRACE request.
  static Future<rust.HttpResponse> trace(
    String url, {
    HttpVersionPref? httpVersion,
    Map<String, String>? query,
    HttpHeaders? headers,
    HttpBody? body,
  }) async {
    return await request(
      method: HttpMethod.trace,
      url: url,
      httpVersion: httpVersion,
      query: query,
      headers: headers,
      body: body,
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

extension on HttpHeaders {
  rust.HttpHeaders _toRustType() {
    return switch (this) {
      HttpHeaderMap map => rust.HttpHeaders.map(map.map),
      HttpHeaderRawMap rawMap => rust.HttpHeaders.rawMap(rawMap.map),
    };
  }
}

extension on HttpBody {
  rust.HttpBody _toRustType() {
    return switch (this) {
      HttpBodyText text => rust.HttpBody.text(text.text),
      HttpBodyJson json => rust.HttpBody.text(jsonEncode(json.json)),
      HttpBodyBytes bytes => rust.HttpBody.bytes(bytes.bytes),
      HttpBodyForm form => rust.HttpBody.form(form.form),
    };
  }
}
