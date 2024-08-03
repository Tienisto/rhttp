import 'dart:typed_data';

import 'package:meta/meta.dart';
import 'package:rhttp/src/rust/api/http.dart' as rust;
import 'package:rhttp/src/rust/api/http_types.dart';

enum HttpExpectBody {
  /// The response body is parsed as text.
  text,

  /// The response body is parsed as bytes.
  bytes,

  /// The response body is a stream of bytes.
  stream,
  ;
}

/// The HTTP method to use.
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
  /// Only use HTTP/1.0.
  http1_0,

  /// Only use HTTP/1.1.
  http1_1,

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

  /// A raw header list.
  /// This allows for multiple headers with the same name.
  const factory HttpHeaders.list(List<(String, String)> list) =
      HttpHeaderList._;
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

/// A raw header list.
/// This allows for multiple headers with the same name.
class HttpHeaderList extends HttpHeaders {
  final List<(String, String)> list;

  const HttpHeaderList._(this.list);
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

@internal
extension HttpExpectBodyExt on HttpExpectBody {
  rust.HttpExpectBody toRustType() {
    return switch (this) {
      HttpExpectBody.text => rust.HttpExpectBody.text,
      HttpExpectBody.bytes => rust.HttpExpectBody.bytes,
      HttpExpectBody.stream => throw UnimplementedError(),
    };
  }
}
