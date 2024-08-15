import 'package:flutter_test/flutter_test.dart';
import 'package:rhttp/rhttp.dart';
import 'package:rhttp/src/rust/frb_generated.dart';

import '../mocks.dart';

void main() {
  late MockRustLibApi mockApi;

  setUpAll(() async {
    mockApi = MockRustLibApi.createAndRegister();

    // ignore: invalid_use_of_protected_member
    RustLib.instance.initMockImpl(api: mockApi);
  });

  group('beforeSend', () {
    test('Should call beforeSend before sending', () async {
      bool called = false;
      bool receivedAfterCalled = false;
      mockApi.mockDefaultResponse(onAnswer: () {
        if (called) {
          receivedAfterCalled = true;
        }
      });

      await Rhttp.get(
        'https://example.com',
        interceptors: [
          SimpleInterceptor(
            beforeSend: (request) async {
              called = true;
              return Interceptor.next();
            },
          )
        ],
      );

      // exception is thrown but beforeSend should be called
      expect(called, true);
      expect(receivedAfterCalled, true);
    });

    test('Should resolve response', () async {
      mockApi.mockErrorResponse();

      final response = await Rhttp.get(
        'https://example.com',
        interceptors: [
          SimpleInterceptor(
            beforeSend: (request) async {
              return Interceptor.resolve(FakeHttpResponse());
            },
          )
        ],
      );

      expect(response, isA<FakeHttpResponse>());
    });

    test('Should wrap exception', () async {
      mockApi.mockErrorResponse();

      Object? exception;
      try {
        await Rhttp.get(
          'https://some-url-123',
          interceptors: [
            SimpleInterceptor(
              beforeSend: (request) async {
                throw 'Test 123';
              },
            )
          ],
        );
      } catch (e) {
        exception = e;
      }

      expect(
          exception,
          isA<RhttpInterceptorException>().having(
            (e) => e.error,
            'error',
            'Test 123',
          ));
      expect(
          exception,
          isA<RhttpInterceptorException>().having(
            (e) => e.stackTrace.toString(),
            'stackTrace',
            contains('interceptor_test.dart'),
          ));
      expect(
          exception,
          isA<RhttpInterceptorException>().having(
            (e) => e.request.url,
            'request.url',
            'https://some-url-123',
          ));
    });
  });

  test('Should call beforeReturn after receiving', () async {
    bool received = false;
    mockApi.mockDefaultResponse(onAnswer: () => received = true);

    bool calledAfterReceived = false;
    final response = await Rhttp.get(
      'https://example.com',
      interceptors: [
        SimpleInterceptor(
          beforeReturn: (request) async {
            if (received) {
              calledAfterReceived = true;
            }
            return Interceptor.next();
          },
        )
      ],
    );

    expect(calledAfterReceived, true);
    expect(response, isA<HttpTextResponse>());
  });
}

class FakeHttpResponse extends Fake implements HttpTextResponse {}
