import 'package:flutter_test/flutter_test.dart';
import 'package:rhttp/rhttp.dart';
import 'package:rhttp/src/rust/frb_generated.dart';

import '../mocks.dart';

void main() {
  late MockRustLibApi mockApi;

  setUpAll(() async {
    mockApi = MockRustLibApi.createAndRegister();

    RustLib.initMock(api: mockApi);
  });

  test('Should cancel request', () async {
    bool receivedCancelRequest = false;
    mockApi.mockCancelRequest(onAnswer: (cancelRef) {
      receivedCancelRequest = true;
      return true;
    });

    mockApi.mockCustomResponse(
      statusCode: 200,
      body: 'Hello, world!',
      cancelRef: 1,
      cancelDelay: const Duration(milliseconds: 10),
      delay: const Duration(milliseconds: 100),
      onAnswer: (_) {
        if (receivedCancelRequest) {
          throw fakeCancelError();
        }
      },
    );

    final cancelToken = CancelToken();
    HttpResponse? response;
    Object? exception;
    bool cancelResult = false;
    try {
      final responseFuture = Rhttp.get(
        'http://localhost:8080',
        cancelToken: cancelToken,
      );

      cancelResult = await cancelToken.cancel();

      response = await responseFuture;
    } catch (e) {
      exception = e;
    }

    expect(receivedCancelRequest, true);
    expect(cancelResult, true);
    expect(response, isNull);
    expect(exception, isA<RhttpCancelException>());
  });

  test('Should not fail if cancelled multiple times', () async {
    bool receivedCancelRequest = false;
    mockApi.mockCancelRequest(onAnswer: (cancelRef) {
      if (!receivedCancelRequest) {
        receivedCancelRequest = true;
        return true;
      } else {
        return false;
      }
    });

    mockApi.mockCustomResponse(
      statusCode: 200,
      body: 'Hello, world!',
      cancelRef: 1,
      cancelDelay: const Duration(milliseconds: 10),
      delay: const Duration(milliseconds: 100),
      onAnswer: (_) {
        if (receivedCancelRequest) {
          throw fakeCancelError();
        }
      },
    );

    final cancelToken = CancelToken();
    HttpResponse? response;
    Object? exception;
    bool cancelResult = false;
    bool cancelResult2 = false;
    try {
      final responseFuture = Rhttp.get(
        'http://localhost:8080',
        cancelToken: cancelToken,
      );

      cancelResult = await cancelToken.cancel();
      cancelResult2 = await cancelToken.cancel();

      response = await responseFuture;
    } catch (e) {
      exception = e;
    }

    expect(receivedCancelRequest, true);
    expect(cancelResult, true);
    expect(cancelResult2, false);
    expect(response, isNull);
    expect(exception, isA<RhttpCancelException>());
  });
}
