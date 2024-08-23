# rhttp

[![pub package](https://img.shields.io/pub/v/rhttp.svg)](https://pub.dev/packages/rhttp)
![ci](https://github.com/Tienisto/rhttp/actions/workflows/ci.yml/badge.svg)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Make HTTP requests using Rust for Flutter developers.

## About

The default HTTP client in Dart is part of `dart:io`, which lacks configurability and performance compared to other HTTP clients.
Furthermore, HTTP/2 and HTTP/3 are either missing or not supported by default.
This package uses FFI with [flutter_rust_bridge](https://pub.dev/packages/flutter_rust_bridge) to call Rust code. This allows you to use a faster and more efficient HTTP client.
On Rust's side, the [reqwest](https://crates.io/crates/reqwest) crate is used to make the requests.

Why shouldn't I use [cronet_http](https://pub.dev/packages/cronet_http) or [cupertino_http](https://pub.dev/packages/cupertino_http)?
These packages for instance only support Android or iOS, while rhttp supports all platforms (except web currently) with a single configuration.

The APK size will increase by 2 MB on arm64 and 6 MB if compiled for all architectures (x64, arm32, arm64).

## Features

- ✅ HTTP/1, HTTP/1.1, HTTP/2, and HTTP/3 support
- ✅ TLS 1.2 and 1.3 support
- ✅ Connection pooling
- ✅ Interceptors
- ✅ Retry (optional)
- ✅ Certificate pinning
- ✅ Strong type safety
- ✅ Optional compatibility layer for the [http](https://pub.dev/packages/http) package

## Benchmark

rhttp is much faster at downloading large files and a bit faster at downloading small files compared to the default HTTP client in Dart.

| Small Files (1 KB)                                                                                   | Large Files (10 MB)                                                                                  |
|------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------|
| ![benchmark-small](https://raw.githubusercontent.com/Tienisto/rhttp/main/benchmark/result-small.png) | ![benchmark-large](https://raw.githubusercontent.com/Tienisto/rhttp/main/benchmark/result-large.png) |

Referred packages: [dio](https://pub.dev/packages/dio) (5.5.0+1), [http](https://pub.dev/packages/http) (1.2.2), [rhttp](https://pub.dev/packages/rhttp) (0.3.0)

Checkout the benchmark code [here](https://github.com/Tienisto/rhttp/tree/main/benchmark).

## Getting Started

### ➤ Installation

1. Install Rust via [rustup](https://rustup.rs/).
   - Rust 1.80.0 or later is required.
2. Add `rhttp` to `pubspec.yaml`:

```yaml
dependencies:
  rhttp: <version>
```

### ➤ Initialization

```dart
import 'package:rhttp/rhttp.dart';

void main() async {
  await Rhttp.init(); // add this
  runApp(MyApp());
}
```

### ➤ Usage

```dart
import 'package:rhttp/rhttp.dart';

void main() async {
  await Rhttp.init();
  
  // Make a GET request
  HttpTextResponse response = await Rhttp.get('https://example.com');
  
  // Read the response
  int statusCode = response.statusCode;
  String body = response.body;
}
```

Alternatively, you can use the `RhttpCompatibleClient` that implements the `Client` of the [http](https://pub.dev/packages/http) package.

For more information, see [Compatibility Layer](#-compatibility-layer).

```dart
import 'package:rhttp/rhttp.dart';
import 'package:http/http.dart' as http;

void main() async {
  await Rhttp.init();
  
  http.Client client = await RhttpCompatibleClient.create();
  http.Response response = await client.get(Uri.parse('https://example.com'));

  print(response.statusCode);
  print(response.body);
}
```

## Features

### ➤ HTTP methods

You can make requests using different HTTP methods:

```dart
// Pass the method as an argument
await Rhttp.requestText(method: HttpMethod.post, url: 'https://example.com');

// Use the helper methods
await Rhttp.post('https://example.com');
```

### ➤ Request query parameters

You can add query parameters to the URL:

```dart
await Rhttp.get('https://example.com', query: {'key': 'value'});
```

### ➤ Request Headers

You can add headers to the request:

```dart
await Rhttp.post(
  'https://example.com',
  headers: const HttpHeaders.map({
    HttpHeaderName.contentType: 'application/json',
  }),
);
```

### ➤ Request Body

You can add a body to the request. There are different types of bodies you can use:

**Text**

Pass a string to the `HttpBody.text` constructor.

```dart
// Raw body
await Rhttp.post(
  'https://example.com',
  body: HttpBody.text('raw body'),
);
```

**JSON**

Pass JSON map to the `HttpBody.json` constructor.

The Content-Type header will be set to `application/json` if not provided.

```dart
await Rhttp.post(
  'https://example.com',
  body: HttpBody.json({'key': 'value'}),
);
```

**Binary**

Pass a `Uint8List` to the `HttpBody.bytes` constructor.

```dart
await Rhttp.post(
  'https://example.com',
  body: HttpBody.bytes(Uint8List.fromList([0, 1, 2])),
);
```

**Stream**

Pass a `Stream<int>` to the `HttpBody.stream` constructor.

It is recommended to also provide a `length` to automatically set the `Content-Length` header.

```dart
await Rhttp.post(
  'https://example.com',
  body: HttpBody.stream(
    Stream.fromIterable([0, 1, 2]),
    length: 3,
  ),
);
```

**Form**

Pass a flat map to the `HttpBody.form` constructor.

The Content-Type header will be set to `application/x-www-form-urlencoded` if not provided.

```dart
await Rhttp.post(
  'https://example.com',
  body: HttpBody.form({'key': 'value'}),
);
```

**Multipart**

Pass a map of `MultipartItem` to the `HttpBody.multipart` constructor.

The Content-Type header will be overridden to `multipart/form-data` with a random boundary.

```dart
await Rhttp.post(
  'https://example.com',
  body: HttpBody.multipart({
    'name': const MultipartItem.text(
      text: 'Tom',
    ),
    'profile_image': MultipartItem.bytes(
      bytes: Uint8List.fromList(bytes),
      fileName: 'image.jpeg',
    ),
  }),
)
```

### ➤ Response Body

To let Rust do most of the work, you must specify the expected response body type before making the request.

Most convenience functions (e.g. `Rhttp.get`, `Rhttp.request`) return a `HttpTextResponse`.

```dart
HttpTextResponse response = await Rhttp.getText('https://example.com');
String body = response.body;

HttpBytesResponse response = await Rhttp.getBytes('https://example.com');
Uint8List body = response.body;

HttpStreamResponse response = await Rhttp.getStream('https://example.com');
Stream<Uint8List> body = response.body;
```

### ➤ Connection Reuse

To improve performance, it is recommended to create a client and reuse it for multiple requests.

This allows you to reuse connections (with same servers).
Furthermore, it avoids the overhead of creating a new client for each request.

```dart
final client = await RhttpClient.create();

await client.get('https://example.com');
```

You can dispose the client when you are done with it:

```dart
client.dispose();
```

To create a client synchronously, use `RhttpClient.createSync`.
This should only be called during app start to avoid blocking the UI thread.

```dart
final client = RhttpClient.createSync();
```

### ➤ Cancel Requests

You can cancel a request by providing a `CancelToken`:

```dart
final cancelToken = CancelToken();
final request = Rhttp.get(
   'https://example.com',
   cancelToken: cancelToken,
);

// Cancel the request
cancelToken.cancel();

// Will throw a `RhttpCancelException`
await request;
```

### ➤ Progress

You can observe the progress of the request, by providing `onSendProgress` and `onReceiveProgress` callbacks.

Please note that request and response bodies must be either `Stream` or `Uint8List`.

The parameter `total` can be `-1` if the total size is unknown.

```dart
final request = Rhttp.post(
  'https://example.com',
  body: HttpBody.bytes(bytes),
  onSendProgress: (sent, total) {
    print('Sent: $sent, Total: $total');
  },
  onReceiveProgress: (received, total) {
    print('Received: $received, Total: $total');
  },
);
```

### ➤ Error Handling

All exceptions are subclasses of `RhttpException`.

The following exceptions can be thrown:

| Exception                          | Description                                           |
|------------------------------------|-------------------------------------------------------|
| `RhttpCancelException`             | Request was canceled.                                 |
| `RhttpTimeoutException`            | Request timed out.                                    |
| `RhttpStatusCodeException`         | Response has 4xx or 5xx status code.                  |
| `RhttpInvalidCertificateException` | Server certificate is invalid.                        |
| `RhttpConnectionException`         | Connection error. (no internet, server not reachable) |
| `RhttpInvalidClientException`      | Request is made with an invalid client.               |
| `RhttpInterceptorException`        | Interceptor threw an exception.                       |
| `RhttpUnknownException`            | Unknown error occurred.                               |

### ➤ Timeout

You can specify the timeout for the request:

```dart
await Rhttp.get(
  'https://example.com',
  settings: const ClientSettings(
    timeout: Duration(seconds: 10),
    connectTimeout: Duration(seconds: 5),
  ),
);
```

### ➤ Throw on Status Code

By default, an exception is thrown if the response has a 4xx or 5xx status code.
You can disable this behavior by setting `throwOnStatusCode` to `false`.

```dart
await Rhttp.get(
  'https://example.com',
  settings: const ClientSettings(
    throwOnStatusCode: false,
  ),
);
```

### ➤ Interceptors

You can add interceptors to the client to modify requests / responses, handle errors, observe requests, etc.

Any exception thrown by an interceptor that is not a subclass of `RhttpException`
will be caught and wrapped in a `RhttpInterceptorException`.

```dart
class TestInterceptor extends Interceptor {
  @override
  Future<InterceptorResult<HttpRequest>> beforeRequest(
    HttpRequest request,
  ) async {
    return Interceptor.next(request.addHeader(
      name: HttpHeaderName.accept,
      value: 'application/json',
    ));
  }

  @override
  Future<InterceptorResult<HttpResponse>> afterResponse(
    HttpResponse response,
  ) async {
    return Interceptor.next();
  }

  @override
  Future<InterceptorResult<RhttpException>> onError(
    RhttpException exception,
  ) async {
    return Interceptor.next();
  }
}
```

There are 4 termination methods:

- `Interceptor.next()`: Continue with the next interceptor.
- `Interceptor.stop()`: Stop the interceptor chain.
- `Interceptor.resolve()`: Resolve the request with the given response.
- `throw RhttpException`: Throw an exception. The stack trace will be preserved.

Instead of implementing the `Interceptor` class, you can use the `SimpleInterceptor` class:

```dart
final client = await RhttpClient.create(
  interceptors: [
    SimpleInterceptor(
      onError: (exception) async {
        if (exception is RhttpStatusCodeException && exception.statusCode == 401) {
          // Log out
        }
        return Interceptor.next();
      },
    ),
  ],
);
```

### ➤ RetryInterceptor

There is a built-in `RetryInterceptor` that retries the request if it fails.

```dart
class RefreshTokenInterceptor extends RetryInterceptor {
  final Ref ref;

  RefreshTokenInterceptor(this.ref);

  @override
  int get maxRetries => 1;

  @override
  bool shouldRetry(HttpResponse? response, RhttpException? exception) {
    return exception is RhttpStatusCodeException &&
        (exception.statusCode == 401 || exception.statusCode == 403);
  }

  @override
  Future<HttpRequest?> beforeRetry(
    int attempt,
    HttpRequest request,
    HttpResponse? response,
    RhttpException? exception,
  ) async {
    ref.read(authProvider.notifier).state = await refresh();
    return null;
  }
}
```

Checkout this [example](https://github.com/Tienisto/rhttp/blob/main/example/lib/interceptor_riverpod.dart)
to see how access tokens can be refreshed using Riverpod.

### ➤ HTTP version

You can specify the HTTP version to use for the request.
HTTP/1, HTTP/1.1, HTTP/2, and HTTP/3 are currently supported.

```dart
await Rhttp.get(
  'https://example.com',
  settings: const ClientSettings(
    httpVersionPref: HttpVersionPref.http3,
  ),
);
```

### ➤ TLS version

You can specify the TLS version to use for the request.
Only TLS 1.2 and 1.3 are currently supported.

```dart
await Rhttp.get(
  'https://example.com',
  settings: const ClientSettings(
    tlsSettings: TlsSettings(
      minTlsVersion: TlsVersion.tls12,
      maxTlsVersion: TlsVersion.tls13,
    ),
  ),
);
```

### ➤ Certificate Pinning

To improve security, you can specify the expected server certificate.

Due to limitations on Rust's side ([Github Issue](https://github.com/seanmonstar/reqwest/issues/298)),
you need to either provide the full certificate chain, or the root certificate.

```dart
await Rhttp.get(
  'https://example.com',
  settings: const ClientSettings(
    tlsSettings: TlsSettings(
      trustedRootCertificates: [
        '''-----BEGIN CERTIFICATE-----
some certificate
-----END CERTIFICATE-----''',
],
    ),
  ),
);
```

### ➤ Disable pre-installed root certificates

By default, the pre-installed root certificates are used.
You can disable this behavior by setting `trustRootCertificates` to `false`.

```dart
await Rhttp.get(
  'https://example.com',
  settings: const ClientSettings(
    tlsSettings: TlsSettings(
      trustRootCertificates: false,
    ),
  ),
);
```

### ➤ Client Authentication / mutual TLS

You can specify the client certificate and key to enable mutual TLS (mTLS).

```dart
await Rhttp.get(
  'https://example.com',
  settings: const ClientSettings(
    tlsSettings: TlsSettings(
      clientCertificate: ClientCertificate(
         certificate: clientCert,
         privateKey: clientKey,
      ),
    ),
  ),
);
```

### ➤ Disable certificate verification

This is very insecure and should only be used for testing purposes.

```dart
await Rhttp.get(
  'https://example.com',
  settings: const ClientSettings(
    tlsSettings: TlsSettings(
      verifyCertificates: false,
    ),
  ),
);
```

### ➤ Proxy

By default, the system proxy is enabled.

Disable system proxy:

```dart
await Rhttp.get(
  'https://example.com',
  settings: const ClientSettings(
    proxySettings: ProxySettings.noProxy(),
  ),
);
```

### ➤ Compatibility Layer

You can use the `RhttpCompatibleClient` that implements the `Client` of the [http](https://pub.dev/packages/http) package,
thereby exposing the same API as the default HTTP client in the Dart ecosystem.

This comes with some downsides, such as:

- inferior type safety due to the flaw that `body` is of type `Object?` instead of a sane supertype.
- body of type `Map` is implicitly interpreted as `x-www-form-urlencoded` that is only documented in StackOverflow (as of writing this).
- no support for cancellation

```dart
import 'package:rhttp/rhttp.dart';
import 'package:http/http.dart' as http;

void main() async {
  await Rhttp.init();
  
  http.Client client = await RhttpCompatibleClient.create();
  http.Response response = await client.get(Uri.parse('https://example.com'));

  print(response.statusCode);
  print(response.body);
}
```

Since this client is compatible with [http](https://pub.dev/packages/http),
you can use [dio_compatibility_layer](https://pub.dev/packages/dio_compatibility_layer)
to use rhttp with the [dio](https://pub.dev/packages/dio) package.

```dart
Future<Dio> createDioClient() async {
  final dio = Dio();
  final compatibleClient = await RhttpCompatibleClient.create(); // or createSync()
  dio.httpClientAdapter = ConversionLayerAdapter(compatibleClient);
  return dio;
}
```

## License

MIT License

Copyright (c) 2024 Tien Do Nam

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
