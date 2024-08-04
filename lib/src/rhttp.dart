import 'dart:async';

import 'package:rhttp/src/model/cancel_token.dart';
import 'package:rhttp/src/model/request.dart';
import 'package:rhttp/src/model/response.dart';
import 'package:rhttp/src/model/settings.dart';
import 'package:rhttp/src/request.dart';
import 'package:rhttp/src/rust/frb_generated.dart';
export 'package:rhttp/src/rust/api/http_types.dart' show HttpHeaderName;

class Rhttp {
  /// Initializes the Rust library.
  static Future<void> init() async {
    await RustLib.init();
  }

  /// Makes an HTTP request.
  static Future<HttpResponse> requestGeneric({
    ClientSettings? settings,
    required HttpMethod method,
    required String url,
    Map<String, String>? query,
    HttpHeaders? headers,
    HttpBody? body,
    required HttpExpectBody expectBody,
    CancelToken? cancelToken,
  }) =>
      requestInternalGeneric(
        clientRef: null,
        settings: settings,
        method: method,
        url: url,
        query: query,
        headers: headers,
        body: body,
        expectBody: expectBody,
        cancelToken: cancelToken,
      );

  /// Alias for [requestText].
  static Future<HttpTextResponse> request({
    ClientSettings? settings,
    required HttpMethod method,
    required String url,
    Map<String, String>? query,
    HttpHeaders? headers,
    HttpBody? body,
    CancelToken? cancelToken,
  }) =>
      requestText(
        settings: settings,
        method: method,
        url: url,
        query: query,
        headers: headers,
        body: body,
        cancelToken: cancelToken,
      );

  /// Makes an HTTP request and returns the response as text.
  static Future<HttpTextResponse> requestText({
    ClientSettings? settings,
    required HttpMethod method,
    required String url,
    Map<String, String>? query,
    HttpHeaders? headers,
    HttpBody? body,
    CancelToken? cancelToken,
  }) async {
    final response = await requestGeneric(
      settings: settings,
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
  static Future<HttpBytesResponse> requestBytes({
    ClientSettings? settings,
    required HttpMethod method,
    required String url,
    Map<String, String>? query,
    HttpHeaders? headers,
    HttpBody? body,
    CancelToken? cancelToken,
  }) async {
    final response = await requestGeneric(
      settings: settings,
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
  static Future<HttpStreamResponse> requestStream({
    ClientSettings? settings,
    required HttpMethod method,
    required String url,
    Map<String, String>? query,
    HttpHeaders? headers,
    HttpBody? body,
    CancelToken? cancelToken,
  }) async {
    final response = await requestGeneric(
      settings: settings,
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
  static Future<HttpTextResponse> get(
    String url, {
    ClientSettings? settings,
    Map<String, String>? query,
    HttpHeaders? headers,
    CancelToken? cancelToken,
  }) =>
      request(
        settings: settings,
        method: HttpMethod.get,
        url: url,
        query: query,
        headers: headers,
        cancelToken: cancelToken,
      );

  /// Makes an HTTP GET request and returns the response as text.
  static Future<HttpTextResponse> getText(
    String url, {
    ClientSettings? settings,
    Map<String, String>? query,
    HttpHeaders? headers,
    CancelToken? cancelToken,
  }) =>
      requestText(
        settings: settings,
        method: HttpMethod.get,
        url: url,
        query: query,
        headers: headers,
        cancelToken: cancelToken,
      );

  /// Makes an HTTP GET request and returns the response as bytes.
  static Future<HttpBytesResponse> getBytes(
    String url, {
    ClientSettings? settings,
    Map<String, String>? query,
    HttpHeaders? headers,
    CancelToken? cancelToken,
  }) =>
      requestBytes(
        settings: settings,
        method: HttpMethod.get,
        url: url,
        query: query,
        headers: headers,
        cancelToken: cancelToken,
      );

  /// Makes an HTTP GET request and returns the response as a stream.
  static Future<HttpStreamResponse> getStream(
    String url, {
    ClientSettings? settings,
    Map<String, String>? query,
    HttpHeaders? headers,
    CancelToken? cancelToken,
  }) =>
      requestStream(
        settings: settings,
        method: HttpMethod.get,
        url: url,
        query: query,
        headers: headers,
        cancelToken: cancelToken,
      );

  /// Makes an HTTP POST request and returns the response as text.
  /// Use [requestBytes], or [requestStream] for other response types.
  static Future<HttpTextResponse> post(
    String url, {
    ClientSettings? settings,
    Map<String, String>? query,
    HttpHeaders? headers,
    HttpBody? body,
    CancelToken? cancelToken,
  }) =>
      request(
        settings: settings,
        method: HttpMethod.post,
        url: url,
        query: query,
        headers: headers,
        body: body,
        cancelToken: cancelToken,
      );

  /// Makes an HTTP PUT request and returns the response as text.
  /// Use [requestBytes], or [requestStream] for other response types.
  static Future<HttpTextResponse> put(
    String url, {
    ClientSettings? settings,
    Map<String, String>? query,
    HttpHeaders? headers,
    HttpBody? body,
    CancelToken? cancelToken,
  }) =>
      request(
        settings: settings,
        method: HttpMethod.put,
        url: url,
        query: query,
        headers: headers,
        body: body,
        cancelToken: cancelToken,
      );

  /// Makes an HTTP DELETE request and returns the response as text.
  /// Use [requestBytes], or [requestStream] for other response types.
  static Future<HttpTextResponse> delete(
    String url, {
    ClientSettings? settings,
    Map<String, String>? query,
    HttpHeaders? headers,
    HttpBody? body,
    CancelToken? cancelToken,
  }) =>
      request(
        settings: settings,
        method: HttpMethod.delete,
        url: url,
        query: query,
        headers: headers,
        body: body,
        cancelToken: cancelToken,
      );

  /// Makes an HTTP HEAD request and returns the response as text.
  /// Use [requestBytes], or [requestStream] for other response types.
  static Future<HttpTextResponse> head(
    String url, {
    ClientSettings? settings,
    Map<String, String>? query,
    HttpHeaders? headers,
    CancelToken? cancelToken,
  }) =>
      request(
        settings: settings,
        method: HttpMethod.head,
        url: url,
        query: query,
        headers: headers,
        cancelToken: cancelToken,
      );

  /// Makes an HTTP PATCH request and returns the response as text.
  /// Use [requestBytes], or [requestStream] for other response types.
  static Future<HttpTextResponse> patch(
    String url, {
    ClientSettings? settings,
    Map<String, String>? query,
    HttpHeaders? headers,
    HttpBody? body,
    CancelToken? cancelToken,
  }) =>
      request(
        settings: settings,
        method: HttpMethod.patch,
        url: url,
        query: query,
        headers: headers,
        body: body,
        cancelToken: cancelToken,
      );

  /// Makes an HTTP OPTIONS request and returns the response as text.
  /// Use [requestBytes], or [requestStream] for other response types.
  static Future<HttpTextResponse> options(
    String url, {
    ClientSettings? settings,
    Map<String, String>? query,
    HttpHeaders? headers,
    HttpBody? body,
    CancelToken? cancelToken,
  }) =>
      request(
        settings: settings,
        method: HttpMethod.options,
        url: url,
        query: query,
        headers: headers,
        body: body,
        cancelToken: cancelToken,
      );

  /// Makes an HTTP TRACE request and returns the response as text.
  /// Use [requestBytes], or [requestStream] for other response types.
  static Future<HttpTextResponse> trace(
    String url, {
    ClientSettings? settings,
    Map<String, String>? query,
    HttpHeaders? headers,
    HttpBody? body,
    CancelToken? cancelToken,
  }) =>
      request(
        settings: settings,
        method: HttpMethod.trace,
        url: url,
        query: query,
        headers: headers,
        body: body,
        cancelToken: cancelToken,
      );
}
