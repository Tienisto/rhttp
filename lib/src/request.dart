import 'dart:async';
import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:rhttp/src/interceptor/interceptor.dart';
import 'package:rhttp/src/model/exception.dart';
import 'package:rhttp/src/model/header.dart';
import 'package:rhttp/src/model/request.dart';
import 'package:rhttp/src/model/response.dart';
import 'package:rhttp/src/model/settings.dart';
import 'package:rhttp/src/rust/api/error.dart' as rust_error;
import 'package:rhttp/src/rust/api/http.dart' as rust;

/// Non-Generated helper function that is used by
/// the client and also by the static class.
@internal
Future<HttpResponse> requestInternalGeneric(HttpRequest request) async {
  final interceptors = request.interceptor;

  if (interceptors != null) {
    try {
      final result = await interceptors.beforeRequest(request);
      switch (result) {
        case InterceptorNextResult<HttpRequest>() ||
              InterceptorStopResult<HttpRequest>():
          request = result.value ?? request;
        case InterceptorResolveResult<HttpRequest>():
          return result.response;
      }
    } on RhttpException {
      rethrow;
    } catch (e, st) {
      throw RhttpInterceptorException(request, e, st);
    }
  }

  HttpHeaders? headers = request.headers;
  headers = _digestHeaders(
    headers: headers,
    body: request.body,
  );

  bool exceptionByInterceptor = false;
  try {
    if (request.expectBody == HttpExpectBody.stream) {
      final cancelRefCompleter = Completer<int>();
      final responseCompleter = Completer<rust.HttpResponse>();
      final stream = rust.makeHttpRequestReceiveStream(
        clientAddress: request.client?.ref,
        settings: request.settings?.toRustType(),
        method: request.method._toRustType(),
        url: request.url,
        query: request.query?.entries.map((e) => (e.key, e.value)).toList(),
        headers: headers?._toRustType(),
        body: request.body?._toRustType(),
        onResponse: (r) => responseCompleter.complete(r),
        onCancelToken: (int cancelRef) =>
            cancelRefCompleter.complete(cancelRef),
        cancelable: request.cancelToken != null,
      );

      final cancelToken = request.cancelToken;
      if (cancelToken != null) {
        final cancelRef = await cancelRefCompleter.future;
        cancelToken.setRef(cancelRef);
      }

      final rustResponse = await responseCompleter.future;

      HttpResponse response = parseHttpResponse(
        request,
        rustResponse,
        bodyStream: stream,
      );

      if (interceptors != null) {
        try {
          final result = await interceptors.afterResponse(response);
          switch (result) {
            case InterceptorNextResult<HttpResponse>() ||
                  InterceptorStopResult<HttpResponse>():
              response = result.value ?? response;
            case InterceptorResolveResult<HttpResponse>():
              return result.response;
          }
        } on RhttpException {
          exceptionByInterceptor = true;
          rethrow;
        } catch (e, st) {
          exceptionByInterceptor = true;
          throw RhttpInterceptorException(request, e, st);
        }
      }

      return response;
    } else {
      final cancelRefCompleter = Completer<int>();
      final responseFuture = rust.makeHttpRequest(
        clientAddress: request.client?.ref,
        settings: request.settings?.toRustType(),
        method: request.method._toRustType(),
        url: request.url,
        query: request.query?.entries.map((e) => (e.key, e.value)).toList(),
        headers: headers?._toRustType(),
        body: request.body?._toRustType(),
        expectBody: request.expectBody.toRustType(),
        onCancelToken: (int cancelRef) =>
            cancelRefCompleter.complete(cancelRef),
        cancelable: request.cancelToken != null,
      );

      final cancelToken = request.cancelToken;
      if (cancelToken != null) {
        final cancelRef = await cancelRefCompleter.future;
        cancelToken.setRef(cancelRef);
      }

      final rustResponse = await responseFuture;

      HttpResponse response = parseHttpResponse(
        request,
        rustResponse,
      );

      if (interceptors != null) {
        try {
          final result = await interceptors.afterResponse(response);
          switch (result) {
            case InterceptorNextResult<HttpResponse>() ||
                  InterceptorStopResult<HttpResponse>():
              response = result.value ?? response;
            case InterceptorResolveResult<HttpResponse>():
              return result.response;
          }
        } on RhttpException {
          exceptionByInterceptor = true;
          rethrow;
        } catch (e, st) {
          exceptionByInterceptor = true;
          throw RhttpInterceptorException(request, e, st);
        }
      }

      return response;
    }
  } catch (e) {
    if (exceptionByInterceptor) {
      rethrow;
    }
    if (e is rust_error.RhttpError) {
      RhttpException exception = parseError(request, e);

      if (interceptors != null) {
        try {
          final result = await interceptors.onError(exception);
          switch (result) {
            case InterceptorNextResult<RhttpException>() ||
                  InterceptorStopResult<RhttpException>():
              exception = result.value ?? exception;
            case InterceptorResolveResult<RhttpException>():
              return result.response;
          }
        } on RhttpException {
          rethrow;
        } catch (e, st) {
          throw RhttpInterceptorException(request, e, st);
        }
      }

      throw exception;
    } else {
      rethrow;
    }
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
      HttpHeaderMap map => rust.HttpHeaders.map({
          for (final entry in map.map.entries) entry.key.httpName: entry.value,
        }),
      HttpHeaderRawMap rawMap => rust.HttpHeaders.map(rawMap.map),
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
      HttpBodyMultipart multipart =>
        rust.HttpBody.multipart(rust.MultipartPayload(
          parts: multipart.parts.map((e) {
            final name = e.$1;
            final item = e.$2;
            final rustItem = rust.MultipartItem(
              value: switch (item) {
                MultiPartText() => rust.MultipartValue.text(item.text),
                MultiPartBytes() => rust.MultipartValue.bytes(item.bytes),
                MultiPartFile() => rust.MultipartValue.file(item.file),
              },
              fileName: item.fileName,
              contentType: item.contentType,
            );
            return (name, rustItem);
          }).toList(),
        )),
    };
  }
}
