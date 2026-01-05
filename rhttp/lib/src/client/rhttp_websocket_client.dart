import 'dart:async';

import 'package:rhttp/rhttp.dart' hide HttpMethod;
import 'package:rhttp/src/rust/api/http.dart' show HttpMethod;
import 'package:rhttp/src/rust/api/websocket.dart' as rust;

class RhttpWebsocketClient {
  rust.WebSocketHandle _handle;

  Stream<rust.RhttpWebSocketEvent> stream;

  RhttpWebsocketClient._internal(rust.WebSocketHandle handle, this.stream)
    : this._handle = handle;

  static Future<RhttpWebsocketClient> connect({
    required String url,
    Map<String, String>? query,
    List<(String, String)>? queryRaw,
    HttpHeaders? headers,
    HttpBody? body,
    required HttpExpectBody expectBody,
  }) async {
    final handle = await rust.websocketConnect(
      method: HttpMethod(method: "GET"),
      url: url,
    );
    final stream = rust.websocketListen(handle: handle);

    return RhttpWebsocketClient._internal(handle, stream);
  }

  Future<void> send(rust.RhttpWebSocketMessage message) async {
    await rust.websocketSend(handle: _handle, msg: message);
  }

  Future<void> sendString(String message) {
    return send(rust.RhttpWebSocketMessage.text(message));
  }

  Future<void> close() {
    return rust.websocketClose(handle: _handle);
  }
}
