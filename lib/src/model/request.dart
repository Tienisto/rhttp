import 'package:meta/meta.dart';
import 'package:rhttp/src/rust/api/http.dart' as rust;

enum HttpExpectBody {
  /// The response body is parsed as text.
  text,

  /// The response body is parsed as bytes.
  bytes,

  /// The response body is a stream of bytes.
  stream,
  ;
}

@internal
extension HttpExpectBodyExt on HttpExpectBody {
  rust.HttpExpectBody toRustType() {
    return switch (this) {
      HttpExpectBody.text => rust.HttpExpectBody.text,
      HttpExpectBody.bytes => rust.HttpExpectBody.bytes,
      HttpExpectBody.stream => rust.HttpExpectBody.stream,
    };
  }
}
