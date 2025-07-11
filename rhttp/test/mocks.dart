import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rhttp/src/model/response.dart';
import 'package:rhttp/src/rust/api/client.dart';
import 'package:rhttp/src/rust/frb_generated.dart';
import 'package:rhttp/src/rust/api/client.dart' as rust_client;
import 'package:rhttp/src/rust/api/error.dart' as rust_error;
import 'package:rhttp/src/rust/api/http.dart' as rust_http;
import 'package:rhttp/src/rust/lib.dart' as rust_lib;

class MockRustLibApi extends Mock implements RustLibApi {
  MockRustLibApi.createAndRegister() {
    registerFallbackValue(rust_http.HttpMethod(method: "GET"));
    registerFallbackValue(rust_http.HttpExpectBody.text);
    registerFallbackValue(const ClientSettings(
      httpVersionPref: rust_http.HttpVersionPref.http11,
      throwOnStatusCode: true,
    ));
    registerFallbackValue(FakeCancellationToken());
  }

  void mockCustomResponse({
    List<(String, String)>? headers,
    HttpVersion? version,
    int? statusCode,
    Object? body,
    rust_lib.CancellationToken? cancelRef,
    Duration? cancelDelay,
    Duration? delay,
    void Function(String)? onAnswer,
  }) {
    when<Future<rust_http.HttpResponse>>(
      () => crateApiHttpMakeHttpRequest(
        method: any(named: 'method'),
        url: any(named: 'url'),
        expectBody: any(named: 'expectBody'),
        onCancelToken: any(named: 'onCancelToken'),
        cancelable: any(named: 'cancelable'),
      ),
    ).thenAnswer((invocation) async {
      final onCancelToken =
          invocation.namedArguments[#onCancelToken] as Function;
      if (cancelDelay != null) {
        Future.delayed(cancelDelay, () {
          onCancelToken(cancelRef ?? FakeCancellationToken());
        });
      }

      if (delay != null) {
        await Future.delayed(delay);
      }
      onAnswer?.call(invocation.namedArguments[#url]);
      return Future.value(rust_http.HttpResponse(
        remoteIp: null,
        headers: headers ?? [],
        version: switch (version ?? HttpVersion.http1_1) {
          HttpVersion.http09 => rust_http.HttpVersion.http09,
          HttpVersion.http1_0 => rust_http.HttpVersion.http10,
          HttpVersion.http1_1 => rust_http.HttpVersion.http11,
          HttpVersion.http2 => rust_http.HttpVersion.http2,
          HttpVersion.http3 => rust_http.HttpVersion.http3,
          HttpVersion.other => rust_http.HttpVersion.other,
        },
        statusCode: statusCode ?? 200,
        body: switch (body) {
          String() => rust_http.HttpResponseBody_Text(body),
          Uint8List() => rust_http.HttpResponseBody_Bytes(body),
          _ => throw 'Invalid body type',
        },
      ));
    });
  }

  void mockDefaultResponse({void Function(String) onAnswer = _noop}) {
    when<Future<rust_http.HttpResponse>>(
      () => crateApiHttpMakeHttpRequest(
        client: any(named: 'client'),
        settings: any(named: 'settings'),
        method: any(named: 'method'),
        url: any(named: 'url'),
        expectBody: any(named: 'expectBody'),
        onCancelToken: any(named: 'onCancelToken'),
        cancelable: any(named: 'cancelable'),
      ),
    ).thenAnswer((invocation) async {
      onAnswer(invocation.namedArguments[#url]);
      return const rust_http.HttpResponse(
        remoteIp: null,
        headers: [],
        version: rust_http.HttpVersion.http11,
        statusCode: 200,
        body: rust_http.HttpResponseBody_Text('Fake body'),
      );
    });
  }

  void mockErrorResponse(
      {void Function(String) onAnswer = _noop, Object? exception}) {
    when<Future<rust_http.HttpResponse>>(
      () => crateApiHttpMakeHttpRequest(
        method: any(named: 'method'),
        url: any(named: 'url'),
        expectBody: any(named: 'expectBody'),
        onCancelToken: any(named: 'onCancelToken'),
        cancelable: any(named: 'cancelable'),
      ),
    ).thenAnswer((invocation) async {
      onAnswer(invocation.namedArguments[#url]);
      throw exception ?? 'Fake error';
    });
  }

  void mockCancelRequest({
    void Function(FakeCancellationToken) onAnswer = _noopCancel,
  }) {
    when<Future<void>>(
      () => crateApiHttpCancelRequest(
        token: any(named: 'token'),
      ),
    ).thenAnswer((invocation) async {
      return onAnswer(invocation.namedArguments[#token]);
    });
  }

  void mockCreateClient() {
    when<Future<rust_client.RequestClient>>(
      () => crateApiHttpRegisterClient(
        settings: any(named: 'settings'),
      ),
    ).thenAnswer((invocation) async {
      return FakeRequestClient();
    });
  }
}

class FakeHttpResponse extends Fake implements HttpTextResponse {
  @override
  final String body;

  FakeHttpResponse(this.body);
}

class FakeRequestClient extends Fake implements rust_client.RequestClient {
  @override
  bool get isDisposed => false;
}

class FakeCancellationToken extends Fake
    implements rust_lib.CancellationToken {}

rust_error.RhttpError fakeRhttpError(String message) {
  return rust_error.RhttpError.rhttpUnknownError(message);
}

rust_error.RhttpError fakeCancelError() {
  return const rust_error.RhttpError.rhttpCancelError();
}

void _noop(String url) {}

bool _noopCancel(FakeCancellationToken i) => true;
