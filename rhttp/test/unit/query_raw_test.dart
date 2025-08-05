import 'package:flutter_test/flutter_test.dart';
import 'package:rhttp/rhttp.dart';

void main() {
  group('QueryRaw Tests', () {
    test('BaseHttpRequest should accept queryRaw parameter', () {
      final request = BaseHttpRequest(
        url: 'https://example.com',
        queryRaw: [('key1', 'value1'), ('key2', 'value2')],
      );

      expect(request.queryRaw, [('key1', 'value1'), ('key2', 'value2')]);
      expect(request.query, isNull);
    });

    test(
      'BaseHttpRequest should accept query parameter (existing behavior)',
      () {
        final request = BaseHttpRequest(
          url: 'https://example.com',
          query: {'key1': 'value1', 'key2': 'value2'},
        );

        expect(request.query, {'key1': 'value1', 'key2': 'value2'});
        expect(request.queryRaw, isNull);
      },
    );

    test('BaseHttpRequest should allow duplicate keys in queryRaw', () {
      final request = BaseHttpRequest(
        url: 'https://example.com',
        queryRaw: [
          ('filter', 'category1'),
          ('filter', 'category2'),
          ('filter', 'category3'),
          ('sort', 'name'),
        ],
      );

      expect(request.queryRaw, [
        ('filter', 'category1'),
        ('filter', 'category2'),
        ('filter', 'category3'),
        ('sort', 'name'),
      ]);
    });

    test(
      'BaseHttpRequest should throw error when both query and queryRaw are provided',
      () {
        expect(
          () => BaseHttpRequest(
            url: 'https://example.com',
            query: {'key': 'value'},
            queryRaw: [('key', 'value')],
          ),
          throwsA(
            isA<ArgumentError>().having(
              (e) => e.message,
              'message',
              contains('Cannot specify both query and queryRaw parameters'),
            ),
          ),
        );
      },
    );

    test('HttpRequest should accept queryRaw parameter', () {
      final request = HttpRequest(
        url: 'https://example.com',
        queryRaw: [('key1', 'value1'), ('key2', 'value2')],
      );

      expect(request.queryRaw, [('key1', 'value1'), ('key2', 'value2')]);
      expect(request.query, isNull);
    });

    test(
      'HttpRequest should throw error when both query and queryRaw are provided',
      () {
        expect(
          () => HttpRequest(
            url: 'https://example.com',
            query: {'key': 'value'},
            queryRaw: [('key', 'value')],
          ),
          throwsA(
            isA<ArgumentError>().having(
              (e) => e.message,
              'message',
              contains('Cannot specify both query and queryRaw parameters'),
            ),
          ),
        );
      },
    );

    test('HttpRequest.copyWith should handle queryRaw parameter', () {
      final originalRequest = HttpRequest(
        url: 'https://example.com',
        query: {'original': 'value'},
      );

      final copiedRequest = originalRequest.copyWith(
        queryRaw: [('new', 'value1'), ('new', 'value2')],
        query: null, // Clear the original query
      );

      expect(copiedRequest.queryRaw, [('new', 'value1'), ('new', 'value2')]);
      expect(copiedRequest.query, isNull);
    });

    test(
      'HttpRequest.copyWith should preserve queryRaw when not specified',
      () {
        final originalRequest = HttpRequest(
          url: 'https://example.com',
          queryRaw: [('original', 'value1'), ('original', 'value2')],
        );

        final copiedRequest = originalRequest.copyWith(method: HttpMethod.post);

        expect(copiedRequest.queryRaw, [
          ('original', 'value1'),
          ('original', 'value2'),
        ]);
        expect(copiedRequest.method, HttpMethod.post);
      },
    );

    test('HttpRequest.from should copy queryRaw parameter', () {
      final baseRequest = BaseHttpRequest(
        url: 'https://example.com',
        queryRaw: [('key1', 'value1'), ('key2', 'value2')],
      );

      final httpRequest = HttpRequest.from(request: baseRequest);

      expect(httpRequest.queryRaw, [('key1', 'value1'), ('key2', 'value2')]);
      expect(httpRequest.query, isNull);
    });

    group('API Method Signature Tests', () {
      // Note: These tests only verify that the method signatures accept queryRaw
      // They don't actually make HTTP requests to avoid Rust initialization

      test('BaseHttpRequest can be created with queryRaw for API methods', () {
        // Test that we can create requests with queryRaw that would be used by API methods
        final baseRequest = BaseHttpRequest(
          url: 'https://example.com',
          method: HttpMethod.get,
          queryRaw: [('key1', 'value1'), ('key2', 'value2')],
        );

        expect(baseRequest.queryRaw, [('key1', 'value1'), ('key2', 'value2')]);
        expect(baseRequest.method, HttpMethod.get);
        expect(baseRequest.url, 'https://example.com');
      });

      test('HttpRequest can be created with queryRaw for client methods', () {
        final httpRequest = HttpRequest(
          url: 'https://example.com',
          method: HttpMethod.post,
          queryRaw: [('filter', 'value1'), ('filter', 'value2')],
          expectBody: HttpExpectBody.text,
        );

        expect(
            httpRequest.queryRaw, [('filter', 'value1'), ('filter', 'value2')]);
        expect(httpRequest.method, HttpMethod.post);
        expect(httpRequest.expectBody, HttpExpectBody.text);
      });
    });

    group('Edge Cases', () {
      test('queryRaw can be empty list', () {
        final request = BaseHttpRequest(
          url: 'https://example.com',
          queryRaw: [],
        );

        expect(request.queryRaw, isEmpty);
      });

      test('queryRaw can contain empty strings', () {
        final request = BaseHttpRequest(
          url: 'https://example.com',
          queryRaw: [('', ''), ('key', ''), ('', 'value')],
        );

        expect(request.queryRaw, [('', ''), ('key', ''), ('', 'value')]);
      });

      test('queryRaw can contain special characters', () {
        final request = BaseHttpRequest(
          url: 'https://example.com',
          queryRaw: [
            ('key with spaces', 'value with spaces'),
            ('key=with&special', 'value=with&special'),
            ('unicode🎉', '测试值'),
          ],
        );

        expect(request.queryRaw, [
          ('key with spaces', 'value with spaces'),
          ('key=with&special', 'value=with&special'),
          ('unicode🎉', '测试值'),
        ]);
      });
    });
  });
}
