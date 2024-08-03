import 'dart:async';

import 'package:rhttp/src/model/request.dart';
import 'package:rhttp/src/model/response.dart';
import 'package:rhttp/src/model/settings.dart';
import 'package:rhttp/src/request.dart';
import 'package:rhttp/src/rust/api/http.dart' as rust;

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
  }) =>
      requestInternalGeneric(
        ref: _ref,
        settings: null,
        method: method,
        url: url,
        expectBody: expectBody,
      );

  /// Alias for [requestText].
  Future<HttpTextResponse> request({
    required HttpMethod method,
    required String url,
    Map<String, String>? query,
    HttpHeaders? headers,
    HttpBody? body,
  }) =>
      requestText(
        method: method,
        url: url,
        query: query,
        headers: headers,
        body: body,
      );

  /// Makes an HTTP request and returns the response as text.
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

  /// Makes an HTTP request and returns the response as bytes.
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

  /// Makes an HTTP request and returns the response as a stream.
  Future<HttpStreamResponse> requestStream({
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

  /// Alias for [getText].
  Future<HttpTextResponse> get(
    String url, {
    Map<String, String>? query,
    HttpHeaders? headers,
  }) =>
      request(
        method: HttpMethod.get,
        url: url,
        query: query,
        headers: headers,
      );

  /// Makes an HTTP GET request and returns the response as text.
  Future<HttpTextResponse> getText(
    String url, {
    Map<String, String>? query,
    HttpHeaders? headers,
  }) =>
      requestText(
        method: HttpMethod.get,
        url: url,
        query: query,
        headers: headers,
      );

  /// Makes an HTTP GET request and returns the response as bytes.
  Future<HttpBytesResponse> getBytes(
    String url, {
    Map<String, String>? query,
    HttpHeaders? headers,
  }) =>
      requestBytes(
        method: HttpMethod.get,
        url: url,
        query: query,
        headers: headers,
      );

  /// Makes an HTTP GET request and returns the response as a stream.
  Future<HttpStreamResponse> getStream(
    String url, {
    Map<String, String>? query,
    HttpHeaders? headers,
  }) =>
      requestStream(
        method: HttpMethod.get,
        url: url,
        query: query,
        headers: headers,
      );

  /// Makes an HTTP POST request and returns the response as text.
  /// Use [requestBytes], or [requestStream] for other response types.
  Future<HttpTextResponse> post(
    String url, {
    Map<String, String>? query,
    HttpHeaders? headers,
    HttpBody? body,
  }) =>
      request(
        method: HttpMethod.post,
        url: url,
        query: query,
        headers: headers,
        body: body,
      );

  /// Makes an HTTP PUT request and returns the response as text.
  /// Use [requestBytes], or [requestStream] for other response types.
  Future<HttpTextResponse> put(
    String url, {
    Map<String, String>? query,
    HttpHeaders? headers,
    HttpBody? body,
  }) =>
      request(
        method: HttpMethod.put,
        url: url,
        query: query,
        headers: headers,
        body: body,
      );

  /// Makes an HTTP DELETE request and returns the response as text.
  /// Use [requestBytes], or [requestStream] for other response types.
  Future<HttpTextResponse> delete(
    String url, {
    Map<String, String>? query,
    HttpHeaders? headers,
    HttpBody? body,
  }) =>
      request(
        method: HttpMethod.delete,
        url: url,
        query: query,
        headers: headers,
        body: body,
      );

  /// Makes an HTTP HEAD request and returns the response as text.
  /// Use [requestBytes], or [requestStream] for other response types.
  Future<HttpTextResponse> head(
    String url, {
    Map<String, String>? query,
  }) =>
      request(
        method: HttpMethod.head,
        url: url,
        query: query,
      );

  /// Makes an HTTP PATCH request and returns the response as text.
  /// Use [requestBytes], or [requestStream] for other response types.
  Future<HttpTextResponse> patch(
    String url, {
    Map<String, String>? query,
    HttpHeaders? headers,
    HttpBody? body,
  }) =>
      request(
        method: HttpMethod.patch,
        url: url,
        query: query,
        headers: headers,
        body: body,
      );

  /// Makes an HTTP OPTIONS request and returns the response as text.
  /// Use [requestBytes], or [requestStream] for other response types.
  Future<HttpTextResponse> options(
    String url, {
    Map<String, String>? query,
    HttpHeaders? headers,
    HttpBody? body,
  }) =>
      request(
        method: HttpMethod.options,
        url: url,
        query: query,
        headers: headers,
        body: body,
      );

  /// Makes an HTTP TRACE request and returns the response as text.
  /// Use [requestBytes], or [requestStream] for other response types.
  Future<HttpTextResponse> trace(
    String url, {
    Map<String, String>? query,
    HttpHeaders? headers,
    HttpBody? body,
  }) =>
      request(
        method: HttpMethod.trace,
        url: url,
        query: query,
        headers: headers,
        body: body,
      );
}
