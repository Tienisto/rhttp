# rhttp

[![pub package](https://img.shields.io/pub/v/rhttp.svg)](https://pub.dev/packages/rhttp)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Make HTTP requests using Rust for Flutter developers.

## About

The default HTTP client in Dart is part of `dart:io`, which lacks configurability and performance compared to other HTTP clients.
This package uses FFI with [flutter_rust_bridge](https://pub.dev/packages/flutter_rust_bridge) to call Rust code. This allows you to use a faster and more efficient HTTP client.
On Rust's side, the [reqwest](https://crates.io/crates/reqwest) crate is used to make the requests.

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

## Features

### ➤ HTTP methods

You can make requests using different HTTP methods:

```dart
// Pass the method as an argument
await Rhttp.request(method: HttpMethod.post, url: 'https://example.com');

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
await Rhttp.request(
  method: HttpMethod.get,
  url: 'https://example.com',
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
await Rhttp.request(
  method: HttpMethod.post,
  url: 'https://example.com',
  body: HttpBody.text('raw body'),
);
```

**JSON**

Pass JSON map to the `HttpBody.json` constructor.

The Content-Type header will be set to `application/json` if not provided.

```dart
// JSON body
await Rhttp.request(
  method: HttpMethod.post,
  url: 'https://example.com',
  body: HttpBody.json({'key': 'value'}),
);
```

**Binary**

Pass a `Uint8List` to the `HttpBody.bytes` constructor.

```dart
// Binary body
await Rhttp.request(
  method: HttpMethod.post,
  url: 'https://example.com',
  body: HttpBody.bytes(Uint8List.fromList([0, 1, 2])),
);
```

**Form**

Pass a flat map to the `HttpBody.form` constructor.

The Content-Type header will be set to `application/x-www-form-urlencoded` if not provided.

```dart
// Form body
await Rhttp.request(
  method: HttpMethod.post,
  url: 'https://example.com',
  body: HttpBody.form({'key': 'value'}),
);
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

### ➤ Error Handling

All exceptions are subclasses of `RhttpException`.

The following exceptions can be thrown:

| Exception                     | Description                             |
|-------------------------------|-----------------------------------------|
| `RhttpCancelException`        | Request was canceled.                   |
| `RhttpTimeoutException`       | Request timed out.                      |
| `RhttpStatusCodeException`    | Response has 4xx or 5xx status code.    |
| `RhttpInvalidClientException` | Request is made with an invalid client. |
| `RhttpUnknownException`       | Unknown error occurred.                 |

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
