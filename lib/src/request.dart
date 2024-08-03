import 'dart:async';
import 'dart:convert';

import 'package:rhttp/src/model/request.dart';
import 'package:rhttp/src/model/response.dart';
import 'package:rhttp/src/model/settings.dart';
import 'package:rhttp/src/rust/api/http_types.dart';
import 'package:rhttp/src/rust/api/http.dart' as rust;

/// Non-Generated helper function that is used by
/// the client and also by the static class.
Future<HttpResponse> requestInternalGeneric({
  required int? ref,
  required ClientSettings? settings,
  required HttpMethod method,
  required String url,
  Map<String, String>? query,
  HttpHeaders? headers,
  HttpBody? body,
  required HttpExpectBody expectBody,
}) async {
  headers = _digestHeaders(
    headers: headers,
    body: body,
  );

  if (expectBody == HttpExpectBody.stream) {
    final responseCompleter = Completer<rust.HttpResponse>();
    final stream = rust.makeHttpRequestReceiveStream(
      clientAddress: ref,
      settings: settings?.toRustType(),
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
      clientAddress: ref,
      settings: settings?.toRustType(),
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

HttpHeaders? _digestHeaders({
  required HttpHeaders? headers,
  required HttpBody? body,
}) {
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

  return headers;
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
