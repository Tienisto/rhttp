import 'dart:async';

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
  }) =>
      requestInternalGeneric(
        ref: null,
        settings: settings,
        method: method,
        url: url,
        expectBody: expectBody,
      );

  /// Alias for [requestText].
  static Future<HttpTextResponse> request({
    ClientSettings? settings,
    required HttpMethod method,
    required String url,
    Map<String, String>? query,
    HttpHeaders? headers,
    HttpBody? body,
  }) =>
      requestText(
        settings: settings,
        method: method,
        url: url,
        query: query,
        headers: headers,
        body: body,
      );

  /// Makes an HTTP request and returns the response as text.
  static Future<HttpTextResponse> requestText({
    ClientSettings? settings,
    required HttpMethod method,
    required String url,
    Map<String, String>? query,
    HttpHeaders? headers,
    HttpBody? body,
  }) async {
    final response = await requestGeneric(
      settings: settings,
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
  static Future<HttpBytesResponse> requestBytes({
    ClientSettings? settings,
    required HttpMethod method,
    required String url,
    Map<String, String>? query,
    HttpHeaders? headers,
    HttpBody? body,
  }) async {
    final response = await requestGeneric(
      settings: settings,
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
  static Future<HttpStreamResponse> requestStream({
    ClientSettings? settings,
    required HttpMethod method,
    required String url,
    Map<String, String>? query,
    HttpHeaders? headers,
    HttpBody? body,
  }) async {
    final response = await requestGeneric(
      settings: settings,
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
  static Future<HttpTextResponse> get(
    String url, {
    ClientSettings? settings,
    Map<String, String>? query,
    HttpHeaders? headers,
  }) =>
      request(
        settings: settings,
        method: HttpMethod.get,
        url: url,
        query: query,
        headers: headers,
      );

  /// Makes an HTTP GET request and returns the response as text.
  static Future<HttpTextResponse> getText(
    String url, {
    ClientSettings? settings,
    Map<String, String>? query,
    HttpHeaders? headers,
  }) =>
      requestText(
        settings: settings,
        method: HttpMethod.get,
        url: url,
        query: query,
        headers: headers,
      );

  /// Makes an HTTP GET request and returns the response as bytes.
  static Future<HttpBytesResponse> getBytes(
    String url, {
    ClientSettings? settings,
    Map<String, String>? query,
    HttpHeaders? headers,
  }) =>
      requestBytes(
        settings: settings,
        method: HttpMethod.get,
        url: url,
        query: query,
        headers: headers,
      );

  /// Makes an HTTP GET request and returns the response as a stream.
  static Future<HttpStreamResponse> getStream(
    String url, {
    ClientSettings? settings,
    Map<String, String>? query,
    HttpHeaders? headers,
  }) =>
      requestStream(
        settings: settings,
        method: HttpMethod.get,
        url: url,
        query: query,
        headers: headers,
      );

  /// Makes an HTTP POST request and returns the response as text.
  /// Use [requestBytes], or [requestStream] for other response types.
  static Future<HttpTextResponse> post(
    String url, {
    ClientSettings? settings,
    Map<String, String>? query,
    HttpHeaders? headers,
    HttpBody? body,
  }) =>
      request(
        settings: settings,
        method: HttpMethod.post,
        url: url,
        query: query,
        headers: headers,
        body: body,
      );

  /// Makes an HTTP PUT request and returns the response as text.
  /// Use [requestBytes], or [requestStream] for other response types.
  static Future<HttpTextResponse> put(
    String url, {
    ClientSettings? settings,
    Map<String, String>? query,
    HttpHeaders? headers,
    HttpBody? body,
  }) =>
      request(
        settings: settings,
        method: HttpMethod.put,
        url: url,
        query: query,
        headers: headers,
        body: body,
      );

  /// Makes an HTTP DELETE request and returns the response as text.
  /// Use [requestBytes], or [requestStream] for other response types.
  static Future<HttpTextResponse> delete(
    String url, {
    ClientSettings? settings,
    Map<String, String>? query,
    HttpHeaders? headers,
    HttpBody? body,
  }) =>
      request(
        settings: settings,
        method: HttpMethod.delete,
        url: url,
        query: query,
        headers: headers,
        body: body,
      );

  /// Makes an HTTP HEAD request and returns the response as text.
  /// Use [requestBytes], or [requestStream] for other response types.
  static Future<HttpTextResponse> head(
    String url, {
    ClientSettings? settings,
    Map<String, String>? query,
    HttpHeaders? headers,
  }) =>
      request(
        settings: settings,
        method: HttpMethod.head,
        url: url,
        query: query,
        headers: headers,
      );

  /// Makes an HTTP PATCH request and returns the response as text.
  /// Use [requestBytes], or [requestStream] for other response types.
  static Future<HttpTextResponse> patch(
    String url, {
    ClientSettings? settings,
    Map<String, String>? query,
    HttpHeaders? headers,
    HttpBody? body,
  }) =>
      request(
        settings: settings,
        method: HttpMethod.patch,
        url: url,
        query: query,
        headers: headers,
        body: body,
      );

  /// Makes an HTTP OPTIONS request and returns the response as text.
  /// Use [requestBytes], or [requestStream] for other response types.
  static Future<HttpTextResponse> options(
    String url, {
    ClientSettings? settings,
    Map<String, String>? query,
    HttpHeaders? headers,
    HttpBody? body,
  }) =>
      request(
        settings: settings,
        method: HttpMethod.options,
        url: url,
        query: query,
        headers: headers,
        body: body,
      );

  /// Makes an HTTP TRACE request and returns the response as text.
  /// Use [requestBytes], or [requestStream] for other response types.
  static Future<HttpTextResponse> trace(
    String url, {
    ClientSettings? settings,
    Map<String, String>? query,
    HttpHeaders? headers,
    HttpBody? body,
  }) =>
      request(
        settings: settings,
        method: HttpMethod.trace,
        url: url,
        query: query,
        headers: headers,
        body: body,
      );
}
