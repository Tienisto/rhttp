import 'package:meta/meta.dart';
import 'package:rhttp/src/rust/api/http.dart' as rust;

/// A token that can be used to cancel an HTTP request.
/// This token must be passed to the request method.
class CancelToken {
  int? _ref;
  int? get ref => _ref;

  bool _isCancelled = false;

  /// Whether the request has been cancelled.
  bool get isCancelled => _isCancelled;

  CancelToken();

  @internal
  void setRef(int ref) {
    assert(_ref == null);
    _ref = ref;
  }

  /// Cancels the HTTP request.
  void cancel() {
    if (_ref != null) {
      rust.cancelRequest(address: _ref!);
      _isCancelled = true;
    }
  }
}
