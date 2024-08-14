import 'dart:async';

import 'package:meta/meta.dart';
import 'package:rhttp/src/model/cancel_token.dart';
import 'package:rhttp/src/model/request.dart';
import 'package:rhttp/src/model/response.dart';
import 'package:rhttp/src/model/settings.dart';
import 'package:rhttp/src/request.dart';
import 'package:rhttp/src/rust/api/http.dart' as rust;

/// An HTTP client that is used to make requests.
/// Creating this is an expensive operation, so it is recommended to reuse it.
/// Internally, it holds a connection pool and other resources on the Rust side.
class RhttpClient {
  /// Settings for the client.
  final ClientSettings settings;

  /// Internal reference to the Rust client.
  @internal
  final int ref;

  RhttpClient._(this.settings, this.ref);

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
    rust.removeClient(address: ref);
  }

  /// Makes an HTTP request.
  /// Use [send] if you already have a [BaseRhttpRequest] object.
  Future<HttpResponse> request({
    required HttpMethod method,
    required String url,
    Map<String, String>? query,
    HttpHeaders? headers,
    HttpBody? body,
    required HttpExpectBody expectBody,
    CancelToken? cancelToken,
  }) =>
      requestInternalGeneric(RhttpRequest(
        client: this,
        settings: null,
        method: method,
        url: url,
        query: query,
        headers: headers,
        body: body,
        expectBody: expectBody,
        cancelToken: cancelToken,
      ));

  /// Similar to [request], but uses a [BaseRhttpRequest] object
  /// instead of individual parameters.
  Future<HttpResponse> send(BaseRhttpRequest request) =>
      requestInternalGeneric(RhttpRequest.fromBase(
        request: request,
        client: this,
        settings: settings,
      ));

  /// Makes an HTTP request and returns the response as text.
  Future<HttpTextResponse> requestText({
    required HttpMethod method,
    required String url,
    Map<String, String>? query,
    HttpHeaders? headers,
    HttpBody? body,
    CancelToken? cancelToken,
  }) async {
    final response = await request(
      method: method,
      url: url,
      query: query,
      headers: headers,
      body: body,
      expectBody: HttpExpectBody.text,
      cancelToken: cancelToken,
    );
    return response as HttpTextResponse;
  }

  /// Makes an HTTP request and returns the response as bytes.
  Future<HttpBytesResponse> requestBytes({
    required HttpMethod method,
    required String url,
    Map<String, String>? query,
    HttpHeaders? headers,
    HttpBody? body,
    CancelToken? cancelToken,
  }) async {
    final response = await request(
      method: method,
      url: url,
      query: query,
      headers: headers,
      body: body,
      expectBody: HttpExpectBody.bytes,
      cancelToken: cancelToken,
    );
    return response as HttpBytesResponse;
  }

  /// Makes an HTTP request and returns the response as a stream.
  Future<HttpStreamResponse> requestStream({
    required HttpMethod method,
    required String url,
    Map<String, String>? query,
    HttpHeaders? headers,
    HttpBody? body,
    CancelToken? cancelToken,
  }) async {
    final response = await request(
      method: method,
      url: url,
      query: query,
      headers: headers,
      body: body,
      expectBody: HttpExpectBody.stream,
      cancelToken: cancelToken,
    );
    return response as HttpStreamResponse;
  }

  /// Alias for [getText].
  Future<HttpTextResponse> get(
    String url, {
    Map<String, String>? query,
    HttpHeaders? headers,
    CancelToken? cancelToken,
  }) =>
      requestText(
        method: HttpMethod.get,
        url: url,
        query: query,
        headers: headers,
        cancelToken: cancelToken,
      );

  /// Makes an HTTP GET request and returns the response as text.
  Future<HttpTextResponse> getText(
    String url, {
    Map<String, String>? query,
    HttpHeaders? headers,
    CancelToken? cancelToken,
  }) =>
      requestText(
        method: HttpMethod.get,
        url: url,
        query: query,
        headers: headers,
        cancelToken: cancelToken,
      );

  /// Makes an HTTP GET request and returns the response as bytes.
  Future<HttpBytesResponse> getBytes(
    String url, {
    Map<String, String>? query,
    HttpHeaders? headers,
    CancelToken? cancelToken,
  }) =>
      requestBytes(
        method: HttpMethod.get,
        url: url,
        query: query,
        headers: headers,
        cancelToken: cancelToken,
      );

  /// Makes an HTTP GET request and returns the response as a stream.
  Future<HttpStreamResponse> getStream(
    String url, {
    Map<String, String>? query,
    HttpHeaders? headers,
    CancelToken? cancelToken,
  }) =>
      requestStream(
        method: HttpMethod.get,
        url: url,
        query: query,
        headers: headers,
        cancelToken: cancelToken,
      );

  /// Makes an HTTP POST request and returns the response as text.
  /// Use [requestBytes], or [requestStream] for other response types.
  Future<HttpTextResponse> post(
    String url, {
    Map<String, String>? query,
    HttpHeaders? headers,
    HttpBody? body,
    CancelToken? cancelToken,
  }) =>
      requestText(
        method: HttpMethod.post,
        url: url,
        query: query,
        headers: headers,
        body: body,
        cancelToken: cancelToken,
      );

  /// Makes an HTTP PUT request and returns the response as text.
  /// Use [requestBytes], or [requestStream] for other response types.
  Future<HttpTextResponse> put(
    String url, {
    Map<String, String>? query,
    HttpHeaders? headers,
    HttpBody? body,
    CancelToken? cancelToken,
  }) =>
      requestText(
        method: HttpMethod.put,
        url: url,
        query: query,
        headers: headers,
        body: body,
        cancelToken: cancelToken,
      );

  /// Makes an HTTP DELETE request and returns the response as text.
  /// Use [requestBytes], or [requestStream] for other response types.
  Future<HttpTextResponse> delete(
    String url, {
    Map<String, String>? query,
    HttpHeaders? headers,
    HttpBody? body,
    CancelToken? cancelToken,
  }) =>
      requestText(
        method: HttpMethod.delete,
        url: url,
        query: query,
        headers: headers,
        body: body,
        cancelToken: cancelToken,
      );

  /// Makes an HTTP HEAD request and returns the response as text.
  /// Use [requestBytes], or [requestStream] for other response types.
  Future<HttpTextResponse> head(
    String url, {
    Map<String, String>? query,
    HttpHeaders? headers,
    CancelToken? cancelToken,
  }) =>
      requestText(
        method: HttpMethod.head,
        url: url,
        query: query,
        headers: headers,
        cancelToken: cancelToken,
      );

  /// Makes an HTTP PATCH request and returns the response as text.
  /// Use [requestBytes], or [requestStream] for other response types.
  Future<HttpTextResponse> patch(
    String url, {
    Map<String, String>? query,
    HttpHeaders? headers,
    HttpBody? body,
    CancelToken? cancelToken,
  }) =>
      requestText(
        method: HttpMethod.patch,
        url: url,
        query: query,
        headers: headers,
        body: body,
        cancelToken: cancelToken,
      );

  /// Makes an HTTP OPTIONS request and returns the response as text.
  /// Use [requestBytes], or [requestStream] for other response types.
  Future<HttpTextResponse> options(
    String url, {
    Map<String, String>? query,
    HttpHeaders? headers,
    HttpBody? body,
    CancelToken? cancelToken,
  }) =>
      requestText(
        method: HttpMethod.options,
        url: url,
        query: query,
        headers: headers,
        body: body,
        cancelToken: cancelToken,
      );

  /// Makes an HTTP TRACE request and returns the response as text.
  /// Use [requestBytes], or [requestStream] for other response types.
  Future<HttpTextResponse> trace(
    String url, {
    Map<String, String>? query,
    HttpHeaders? headers,
    HttpBody? body,
    CancelToken? cancelToken,
  }) =>
      requestText(
        method: HttpMethod.trace,
        url: url,
        query: query,
        headers: headers,
        body: body,
        cancelToken: cancelToken,
      );
}
