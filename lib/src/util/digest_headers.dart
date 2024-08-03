import 'package:rhttp/src/model/request.dart';
import 'package:rhttp/src/rhttp.dart';

HttpHeaders? digestHeaders({
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
