import 'dart:async';
import 'dart:convert';

import 'package:rhttp/src/model/request.dart';
import 'package:rhttp/src/model/response.dart';
import 'package:rhttp/src/rust/api/http.dart' as rust;
import 'package:rhttp/src/rust/api/http_types.dart';
import 'package:rhttp/src/rust/frb_generated.dart';

export 'package:rhttp/src/rust/api/http_types.dart' show HttpHeaderName;

class Rhttp {
  /// Initializes the Rust library.
  static Future<void> init() async {
    await RustLib.init();
  }

  /// Makes an HTTP request.
  static Future<HttpResponse> requestGeneric({
    HttpVersionPref? httpVersion,
    required HttpMethod method,
    required String url,
    Map<String, String>? query,
    HttpHeaders? headers,
    HttpBody? body,
    required HttpExpectBody expectBody,
  }) async {
    if (body is HttpBodyJson) {
      switch (headers) {
        case HttpHeaderMap map:
          if (map.map.containsKey(HttpHeaderName.contentType)) {
            break;
          }
          headers = HttpHeaders.map({
            ...map.map,
            HttpHeaderName.contentType: 'application/json',
          });
          break;
        case HttpHeaderRawMap rawMap:
          if (rawMap.map.keys.any((e) => e.toLowerCase() == 'content-type')) {
            break;
          }
          headers = HttpHeaders.rawMap({
            ...rawMap.map,
            'Content-Type': 'application/json',
          });
          break;
        default:
          headers = const HttpHeaders.map({
            HttpHeaderName.contentType: 'application/json',
          });
          break;
      }
    }

    if (expectBody == HttpExpectBody.stream) {
      final responseCompleter = Completer<rust.HttpResponse>();
      final stream = rust.makeHttpRequestReceiveStream(
        httpVersion: httpVersion?._toRustType() ?? rust.HttpVersionPref.all,
        method: method._toRustType(),
        url: url,
        query: query?.entries.map((e) => (e.key, e.value)).toList(),
        headers: headers?._toRustType(),
        body: body?._toRustType(),
        onResponse: (r) => responseCompleter.complete(r),
      );

      final response = await responseCompleter.future;

      return parseHttpResponse(
        response,
        bodyStream: stream,
      );
    } else {
      final response = await rust.makeHttpRequest(
        httpVersion: httpVersion?._toRustType() ?? rust.HttpVersionPref.all,
        method: method._toRustType(),
        url: url,
        query: query?.entries.map((e) => (e.key, e.value)).toList(),
        headers: headers?._toRustType(),
        body: body?._toRustType(),
        expectBody: expectBody.toRustType(),
      );

      return parseHttpResponse(response);
    }
  }

  /// Alias for [requestText].
  static Future<HttpTextResponse> request({
    HttpVersionPref? httpVersion,
    required HttpMethod method,
    required String url,
    Map<String, String>? query,
    HttpHeaders? headers,
    HttpBody? body,
  }) async {
    return await requestText(
      httpVersion: httpVersion,
      method: method,
      url: url,
      query: query,
      headers: headers,
      body: body,
    );
  }

  static Future<HttpTextResponse> requestText({
    HttpVersionPref? httpVersion,
    required HttpMethod method,
    required String url,
    Map<String, String>? query,
    HttpHeaders? headers,
    HttpBody? body,
  }) async {
    final response = await requestGeneric(
      httpVersion: httpVersion,
      method: method,
      url: url,
      query: query,
      headers: headers,
      body: body,
      expectBody: HttpExpectBody.text,
    );
    return response as HttpTextResponse;
  }

  static Future<HttpBytesResponse> requestBytes({
    HttpVersionPref? httpVersion,
    required HttpMethod method,
    required String url,
    Map<String, String>? query,
    HttpHeaders? headers,
    HttpBody? body,
  }) async {
    final response = await requestGeneric(
      httpVersion: httpVersion,
      method: method,
      url: url,
      query: query,
      headers: headers,
      body: body,
      expectBody: HttpExpectBody.bytes,
    );
    return response as HttpBytesResponse;
  }

  static Future<HttpStreamResponse> requestStream({
    HttpVersionPref? httpVersion,
    required HttpMethod method,
    required String url,
    Map<String, String>? query,
    HttpHeaders? headers,
    HttpBody? body,
  }) async {
    final response = await requestGeneric(
      httpVersion: httpVersion,
      method: method,
      url: url,
      query: query,
      headers: headers,
      body: body,
      expectBody: HttpExpectBody.stream,
    );
    return response as HttpStreamResponse;
  }

  /// Makes an HTTP GET request.
  static Future<HttpTextResponse> get(
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
  static Future<HttpTextResponse> post(
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
  static Future<HttpTextResponse> put(
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
  static Future<HttpTextResponse> delete(
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
  static Future<HttpTextResponse> head(
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
  static Future<HttpTextResponse> patch(
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
  static Future<HttpTextResponse> options(
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
  static Future<HttpTextResponse> trace(
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
      HttpHeaderList list => rust.HttpHeaders.list(list.list),
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
