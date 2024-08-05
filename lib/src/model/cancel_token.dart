import 'dart:async';

import 'package:meta/meta.dart';
import 'package:rhttp/src/rust/api/http.dart' as rust;

/// A token that can be used to cancel an HTTP request.
/// This token must be passed to the request method.
class CancelToken {
  final _ref = Completer<int>();

  bool _isCancelled = false;

  /// Whether the request has been cancelled.
  bool get isCancelled => _isCancelled;

  CancelToken();

  @internal
  void setRef(int ref) {
    _ref.complete(ref);
  }

  /// Cancels the HTTP request.
  Future<void> cancel() async {
    // We need to wait for the ref to be set.
    final ref = await _ref.future;

    rust.cancelRequest(address: ref);
    _isCancelled = true;
  }
}
