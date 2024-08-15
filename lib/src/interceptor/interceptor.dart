import 'package:meta/meta.dart';
import 'package:rhttp/src/interceptor/queued_interceptor.dart';
import 'package:rhttp/src/model/exception.dart';
import 'package:rhttp/src/model/request.dart';
import 'package:rhttp/src/model/response.dart';

class Interceptor {
  /// Called before the request is sent.
  Future<InterceptorResult<RhttpRequest>> beforeSend(
    RhttpRequest request,
  ) async {
    return next(request);
  }

  /// Called before the response is returned.
  Future<InterceptorResult<HttpResponse>> beforeReturn(
    HttpResponse response,
  ) async {
    return next(response);
  }

  /// Called when an exception is thrown.
  Future<InterceptorResult<RhttpException>> onError(
    RhttpException exception,
  ) async {
    return next(exception);
  }

  /// Continues to the next interceptor.
  /// If no value is provided, the current value is returned (no changes).
  static InterceptorResult<T> next<T>([T? value]) =>
      InterceptorNextResult(value);

  /// Stops the interceptor chain.
  /// If no value is provided, the current value is returned (no changes).
  static InterceptorResult<T> stop<T>([T? value]) =>
      InterceptorStopResult(value);

  /// Stops the interceptor chain and resolve the request with a response.
  static InterceptorResult<T> resolve<T>(HttpResponse response) =>
      InterceptorResolveResult(response);
}

/// An interceptor where you can specify the behavior
/// in the constructor without creating a new class.
class SimpleInterceptor extends Interceptor {
  final Future<InterceptorResult<RhttpRequest>> Function(RhttpRequest request)?
      _beforeSend;
  final Future<InterceptorResult<HttpResponse>> Function(HttpResponse response)?
      _beforeReturn;
  final Future<InterceptorResult<RhttpException>> Function(
    RhttpException exception,
  )? _onError;

  SimpleInterceptor({
    Future<InterceptorResult<RhttpRequest>> Function(RhttpRequest request)?
        beforeSend,
    Future<InterceptorResult<HttpResponse>> Function(HttpResponse response)?
        beforeReturn,
    Future<InterceptorResult<RhttpException>> Function(
            RhttpException exception)?
        onError,
  })  : _beforeSend = beforeSend,
        _beforeReturn = beforeReturn,
        _onError = onError;

  @override
  Future<InterceptorResult<RhttpRequest>> beforeSend(
      RhttpRequest request) async {
    return await _beforeSend?.call(request) ?? Interceptor.next(request);
  }

  @override
  Future<InterceptorResult<HttpResponse>> beforeReturn(
      HttpResponse response) async {
    return await _beforeReturn?.call(response) ?? Interceptor.next(response);
  }

  @override
  Future<InterceptorResult<RhttpException>> onError(
      RhttpException exception) async {
    return await _onError?.call(exception) ?? Interceptor.next(exception);
  }
}

/// Creates a new [Interceptor] from a list of interceptors.
/// Returns null if the list is empty.
/// Returns the interceptor if the list has only one element.
@internal
Interceptor? parseInterceptorList(List<Interceptor>? interceptors) {
  return switch (interceptors) {
    null => null,
    [] => null,
    _ when interceptors.length == 1 => interceptors[0],
    _ => QueuedInterceptor(interceptors: interceptors),
  };
}

sealed class InterceptorResult<T> {
  /// The actual return value of an interceptor step.
  /// If null, no changes are made.
  final T? value;

  const InterceptorResult(this.value);
}

/// Continues to the next interceptor.
/// If no value is provided, the current value is returned (no changes).
class InterceptorNextResult<T> extends InterceptorResult<T> {
  InterceptorNextResult(super.value);
}

/// Stops the interceptor chain.
/// If no value is provided, the current value is returned (no changes).
class InterceptorStopResult<T> extends InterceptorResult<T> {
  InterceptorStopResult(super.value);
}

/// Stops the interceptor chain and resolve the request with a response.
class InterceptorResolveResult<T> extends InterceptorResult<T> {
  final HttpResponse response;

  InterceptorResolveResult(this.response) : super(null);
}
