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

  CancelToken? _delegated;

  CancelToken();

  @internal
  void setRef(int ref) {
    _ref.complete(ref);
  }

  /// Cancels the HTTP request.
  /// Returns `true` if the request was successfully cancelled.
  /// If the [CancelToken] is not passed to the request method,
  /// this method never finishes.
  Future<bool> cancel() async {
    if (_delegated != null) {
      return await _delegated!.cancel();
    } else {
      // We need to wait for the ref to be set.
      final ref = await _ref.future;

      final cancelResult = rust.cancelRequest(address: ref);
      _isCancelled = true;
      return cancelResult;
    }
  }

  /// When a request is retried, a new [CancelToken] is created.
  /// To ensure that [cancel] is still working on the old token,
  /// a new token is created that gets cancelled
  /// when the old token is cancelled.
  CancelToken createDelegatedToken() {
    final delegated = CancelToken();
    _delegated = delegated;
    return delegated;
  }
}
