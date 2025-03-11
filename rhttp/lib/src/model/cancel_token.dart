import 'dart:async';

import 'package:meta/meta.dart';
import 'package:rhttp/src/rust/api/http.dart' as rust;
import 'package:rhttp/src/rust/lib.dart' as rust_lib;
import 'package:rhttp/src/util/simple_lock.dart';

/// A token that can be used to cancel an HTTP request.
/// This token should be passed to the request method.
///
/// If the same token is passed to multiple requests,
/// all of them will be cancelled when [cancel] is called.
///
/// If a cancelled token is passed to a request method,
/// the request is cancelled immediately.
class CancelToken {
  final _refController = StreamController<rust_lib.CancellationToken>();
  final _firstRef = Completer<rust_lib.CancellationToken>();
  final _refs = <rust_lib.CancellationToken>[];

  bool _isCancelled = false;

  /// Whether the cancellation process has started.
  /// This is different from [isCancelled] because otherwise,
  /// we would not receive the stream event.
  SimpleLock _lock = SimpleLock();

  /// Whether the request has been cancelled.
  bool get isCancelled => _isCancelled;

  CancelToken() {
    _refController.stream.listen((ref) async {
      if (_refs.isEmpty) {
        _firstRef.complete(ref);
      }

      await _lock.synchronized(() {
        _refs.add(ref);
      });
    });
  }

  @internal
  void setRef(rust_lib.CancellationToken ref) {
    if (_isCancelled) {
      rust.cancelRequest(token: ref);
      return;
    }
    _refController.add(ref);
  }

  /// Cancels the HTTP request.
  /// If the [CancelToken] is not passed to the request method,
  /// this method never finishes.
  Future<void> cancel() async {
    await _lock.synchronized(() async {
      if (_isCancelled) {
        return;
      }

      if (_refs.isNotEmpty) {
        for (final ref in _refs) {
          await rust.cancelRequest(token: ref);
        }
      } else {
        // We need to wait for the ref to be set.
        final ref = await _firstRef.future;
        await rust.cancelRequest(token: ref);
      }

      _isCancelled = true;
      _refController.close();
      _refs.clear();
    });
  }
}
