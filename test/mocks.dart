import 'package:mocktail/mocktail.dart';
import 'package:rhttp/src/rust/frb_generated.dart';
import 'package:rhttp/src/rust/api/http.dart' as rust_http;

class MockRustLibApi extends Mock implements RustLibApi {
  MockRustLibApi.createAndRegister() {
    registerFallbackValue(rust_http.HttpMethod.get_);
    registerFallbackValue(rust_http.HttpExpectBody.text);
  }

  void mockCustomResponse(Answer<Future<rust_http.HttpResponse>> answer) {
    when<Future<rust_http.HttpResponse>>(
      () => crateApiHttpMakeHttpRequest(
        method: any(named: 'method'),
        url: any(named: 'url'),
        expectBody: any(named: 'expectBody'),
        onCancelToken: any(named: 'onCancelToken'),
        cancelable: any(named: 'cancelable'),
      ),
    ).thenAnswer(answer);
  }

  void mockDefaultResponse({void Function() onAnswer = _noop}) {
    when<Future<rust_http.HttpResponse>>(
      () => crateApiHttpMakeHttpRequest(
        method: any(named: 'method'),
        url: any(named: 'url'),
        expectBody: any(named: 'expectBody'),
        onCancelToken: any(named: 'onCancelToken'),
        cancelable: any(named: 'cancelable'),
      ),
    ).thenAnswer((_) async {
      onAnswer();
      return const rust_http.HttpResponse(
        headers: [],
        version: rust_http.HttpVersion.http11,
        statusCode: 200,
        body: rust_http.HttpResponseBody_Text('Fake body'),
      );
    });
  }

  void mockErrorResponse({void Function() onAnswer = _noop}) {
    when<Future<rust_http.HttpResponse>>(
      () => crateApiHttpMakeHttpRequest(
        method: any(named: 'method'),
        url: any(named: 'url'),
        expectBody: any(named: 'expectBody'),
        onCancelToken: any(named: 'onCancelToken'),
        cancelable: any(named: 'cancelable'),
      ),
    ).thenAnswer((_) async {
      onAnswer();
      throw 'Fake error';
    });
  }
}

void _noop() {}
