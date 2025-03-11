// A simple lock implementation slightly adapted from the synchronized package:
// https://pub.dev/packages/synchronized that is licensed as MIT.

import 'dart:async';

/// A simple (non-reentrant) lock.
class SimpleLock {
  /// Stores the last running block
  Future<dynamic>? last;

  bool get locked => last != null;

  Future<T> synchronized<T>(
    FutureOr<T> Function() func, {
    Duration? timeout,
  }) async {
    final prev = last;
    final completer = Completer<void>.sync();
    last = completer.future;
    try {
      // If there is a previous running block, wait for it
      if (prev != null) {
        if (timeout != null) {
          // This could throw a timeout error
          await prev.timeout(timeout);
        } else {
          await prev;
        }
      }

      // Run the function and return the result
      var result = func();
      if (result is Future) {
        return await result;
      } else {
        return result;
      }
    } finally {
      // Cleanup
      // waiting for the previous task to be done in case of timeout
      void complete() {
        // Only mark it unlocked when the last one complete
        if (identical(last, completer.future)) {
          last = null;
        }
        completer.complete();
      }

      // In case of timeout, wait for the previous one to complete too
      // before marking this task as complete
      if (prev != null && timeout != null) {
        // But we still return immediately
        unawaited(prev.then((_) => complete()));
      } else {
        complete();
      }
    }
  }

  @override
  String toString() {
    return 'Lock[${identityHashCode(this)}]';
  }
}
