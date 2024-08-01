# rhttp

[![pub package](https://img.shields.io/pub/v/rhttp.svg)](https://pub.dev/packages/rhttp)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Make HTTP requests using Rust from Flutter.

## About

The default HTTP client in Dart is part of `dart:io`, which lacks configurability and performance compared to other HTTP clients.
This package uses FFI with [flutter_rust_bridge](https://pub.dev/packages/flutter_rust_bridge) to call Rust code. This allows you to use a faster and more efficient HTTP client.
On Rust's side, the [reqwest](https://crates.io/crates/reqwest) crate is used to make the requests.

## Getting Started

### ➤ Installation

1. Install Rust via [rustup](https://rustup.rs/).
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
  HttpResponse response = await Rhttp.get('https://example.com');
  
  // Read the response
  int statusCode = response.statusCode;
  String body = response.body;
}
```

## Configuration

### ➤ Custom HTTP version

You can specify the HTTP version to use for the request:

```dart
await Rhttp.get('https://example.com', httpVersion: HttpVersionPref.http3);
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
