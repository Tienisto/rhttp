import 'dart:async';
import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:rhttp/src/model/request.dart';
import 'package:rhttp/src/model/response.dart';
import 'package:rhttp/src/rust/api/client.dart' as rust_client;
import 'package:rhttp/src/rust/api/http.dart' as rust;
import 'package:rhttp/src/util/digest_headers.dart';

class ClientSettings {
  /// The preferred HTTP version to use.
  final HttpVersionPref httpVersionPref;

  /// The timeout for the request including time to establish a connection.
  final Duration? timeout;

  /// The timeout for establishing a connection.
  /// See [timeout] for the total timeout.
  final Duration? connectTimeout;

  const ClientSettings({
    this.httpVersionPref = HttpVersionPref.all,
    this.timeout,
    this.connectTimeout,
  });
}

class RhttpClient {
  /// Settings for the client.
  final ClientSettings settings;

  /// Internal reference to the Rust client.
  final int _ref;

  RhttpClient._(this.settings, this._ref);

  static Future<RhttpClient> create({ClientSettings? settings}) async {
    settings ??= const ClientSettings();
    final ref = await rust.registerClient(
      settings: settings.toRustType(),
    );
    return RhttpClient._(settings, ref);
  }

  /// Disposes the client.
  /// This frees the resources associated with the client.
  /// After calling this method, the client should not be used anymore.
  void dispose() {
    rust.removeClient(address: _ref);
  }

  /// Makes an HTTP request.
  Future<HttpResponse> requestGeneric({
    required HttpMethod method,
    required String url,
    Map<String, String>? query,
    HttpHeaders? headers,
    HttpBody? body,
    required HttpExpectBody expectBody,
  }) async {
    headers = digestHeaders(
      headers: headers,
      body: body,
    );

    if (expectBody == HttpExpectBody.stream) {
      final responseCompleter = Completer<rust.HttpResponse>();
      final stream = rust.makeHttpRequestReceiveStream(
        clientAddress: _ref,
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
        clientAddress: _ref,
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
  Future<HttpTextResponse> request({
    required HttpMethod method,
    required String url,
    Map<String, String>? query,
    HttpHeaders? headers,
    HttpBody? body,
  }) async {
    return await requestText(
      method: method,
      url: url,
      query: query,
      headers: headers,
      body: body,
    );
  }

  Future<HttpTextResponse> requestText({
    required HttpMethod method,
    required String url,
    Map<String, String>? query,
    HttpHeaders? headers,
    HttpBody? body,
  }) async {
    final response = await requestGeneric(
      method: method,
      url: url,
      query: query,
      headers: headers,
      body: body,
      expectBody: HttpExpectBody.text,
    );
    return response as HttpTextResponse;
  }

  Future<HttpBytesResponse> requestBytes({
    required HttpMethod method,
    required String url,
    Map<String, String>? query,
    HttpHeaders? headers,
    HttpBody? body,
  }) async {
    final response = await requestGeneric(
      method: method,
      url: url,
      query: query,
      headers: headers,
      body: body,
      expectBody: HttpExpectBody.bytes,
    );
    return response as HttpBytesResponse;
  }

  Future<HttpStreamResponse> requestStream({
    HttpVersionPref? httpVersion,
    required HttpMethod method,
    required String url,
    Map<String, String>? query,
    HttpHeaders? headers,
    HttpBody? body,
  }) async {
    final response = await requestGeneric(
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
  Future<HttpTextResponse> get(
    String url, {
    HttpVersionPref? httpVersion,
    Map<String, String>? query,
    HttpHeaders? headers,
  }) async {
    return await request(
      method: HttpMethod.get,
      url: url,
      query: query,
      headers: headers,
    );
  }

  /// Makes an HTTP POST request.
  Future<HttpTextResponse> post(
    String url, {
    HttpVersionPref? httpVersion,
    Map<String, String>? query,
    HttpHeaders? headers,
    HttpBody? body,
  }) async {
    return await request(
      method: HttpMethod.post,
      url: url,
      query: query,
      headers: headers,
      body: body,
    );
  }

  /// Makes an HTTP PUT request.
  Future<HttpTextResponse> put(
    String url, {
    HttpVersionPref? httpVersion,
    Map<String, String>? query,
    HttpHeaders? headers,
    HttpBody? body,
  }) async {
    return await request(
      method: HttpMethod.put,
      url: url,
      query: query,
      headers: headers,
      body: body,
    );
  }

  /// Makes an HTTP DELETE request.
  Future<HttpTextResponse> delete(
    String url, {
    HttpVersionPref? httpVersion,
    Map<String, String>? query,
    HttpHeaders? headers,
    HttpBody? body,
  }) async {
    return await request(
      method: HttpMethod.delete,
      url: url,
      query: query,
      headers: headers,
      body: body,
    );
  }

  /// Makes an HTTP HEAD request.
  Future<HttpTextResponse> head(
    String url, {
    HttpVersionPref? httpVersion,
    Map<String, String>? query,
  }) async {
    return await request(
      method: HttpMethod.head,
      url: url,
      query: query,
    );
  }

  /// Makes an HTTP PATCH request.
  Future<HttpTextResponse> patch(
    String url, {
    HttpVersionPref? httpVersion,
    Map<String, String>? query,
    HttpHeaders? headers,
    HttpBody? body,
  }) async {
    return await request(
      method: HttpMethod.patch,
      url: url,
      query: query,
      headers: headers,
      body: body,
    );
  }

  /// Makes an HTTP OPTIONS request.
  Future<HttpTextResponse> options(
    String url, {
    HttpVersionPref? httpVersion,
    Map<String, String>? query,
    HttpHeaders? headers,
    HttpBody? body,
  }) async {
    return await request(
      method: HttpMethod.options,
      url: url,
      query: query,
      headers: headers,
      body: body,
    );
  }

  /// Makes an HTTP TRACE request.
  Future<HttpTextResponse> trace(
    String url, {
    HttpVersionPref? httpVersion,
    Map<String, String>? query,
    HttpHeaders? headers,
    HttpBody? body,
  }) async {
    return await request(
      method: HttpMethod.trace,
      url: url,
      query: query,
      headers: headers,
      body: body,
    );
  }
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
