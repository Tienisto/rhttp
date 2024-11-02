import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:rhttp/rhttp.dart';

const _smallResponseIterations = 10000;
const _largeResponseIterations = 100;

void main() async {
  await Rhttp.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage();

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Download'),
              ElevatedButton(
                onPressed: () async {
                  await benchmarkDownload(
                    debugLabel: 'http',
                    count: _smallResponseIterations,
                    url: Uri.parse('https://localhost:3000'),
                    createClient: _createHttpClient,
                    getBytes: (client, url) async {
                      final response = await client.get(url);
                      return response.bodyBytes;
                    },
                  );
                },
                child: const Text('Benchmark HTTP (small responses)'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await benchmarkDownload(
                    debugLabel: 'http',
                    count: _largeResponseIterations,
                    url: Uri.parse('https://localhost:3000/large'),
                    createClient: _createHttpClient,
                    getBytes: (client, url) async {
                      final response = await client.get(url);
                      return response.bodyBytes;
                    },
                  );
                },
                child: const Text('Benchmark HTTP (large responses)'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await benchmarkDownloadStream(
                    debugLabel: 'http',
                    count: _largeResponseIterations,
                    url: Uri.parse('https://localhost:3000/large'),
                    createClient: _createHttpClient,
                    getStream: (client, url) async {
                      final response = await client.send(Request('GET', url));
                      return response.stream;
                    },
                  );
                },
                child: const Text('Benchmark HTTP (stream)'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await benchmarkDownload(
                    debugLabel: 'dio',
                    count: _smallResponseIterations,
                    url: Uri.parse('https://localhost:3000'),
                    createClient: _createDioClient,
                    getBytes: (client, url) async {
                      final response = await client.getUri(
                        url,
                        options: Options(responseType: ResponseType.bytes),
                      );
                      return response.data;
                    },
                  );
                },
                child: const Text('Benchmark Dio (small responses)'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await benchmarkDownload(
                    debugLabel: 'dio',
                    count: _largeResponseIterations,
                    url: Uri.parse('https://localhost:3000/large'),
                    createClient: _createDioClient,
                    getBytes: (client, url) async {
                      final response = await client.getUri(
                        url,
                        options: Options(responseType: ResponseType.bytes),
                      );
                      return response.data;
                    },
                  );
                },
                child: const Text('Benchmark Dio (large responses)'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await benchmarkDownload(
                    debugLabel: 'rhttp',
                    count: _smallResponseIterations,
                    url: 'https://localhost:3000',
                    createClient: _createRhttpClient,
                    getBytes: (client, url) async {
                      final response = await client.getBytes(url);
                      return response.body;
                    },
                  );
                },
                child: const Text('Benchmark Rhttp (small responses)'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await benchmarkDownload(
                    debugLabel: 'rhttp',
                    count: _largeResponseIterations,
                    url: 'https://localhost:3000/large',
                    createClient: _createRhttpClient,
                    getBytes: (client, url) async {
                      final response = await client.getBytes(
                        url,
                        onReceiveProgress: (curr, total) {},
                      );
                      return response.body;
                    },
                  );
                },
                child: const Text('Benchmark Rhttp (large responses)'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await benchmarkDownloadStream(
                    debugLabel: 'rhttp',
                    count: _largeResponseIterations,
                    url: 'https://localhost:3000/large',
                    createClient: _createRhttpClient,
                    getStream: (client, url) async {
                      final response = await client.getStream(
                        url,
                        onReceiveProgress: (curr, total) {},
                      );
                      return response.body;
                    },
                  );
                },
                child: const Text('Benchmark Rhttp (stream)'),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Upload'),
              ElevatedButton(
                onPressed: () async {
                  await benchmarkUpload(
                    debugLabel: 'http',
                    count: _largeResponseIterations,
                    url: Uri.parse('https://localhost:3000'),
                    createClient: _createHttpClient,
                    upload: (client, url) async {
                      final response = await client.post(url, body: _tenMb);
                      return response.body;
                    },
                  );
                },
                child: const Text('Benchmark HTTP (bytes)'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await benchmarkUpload(
                    debugLabel: 'http',
                    count: _largeResponseIterations,
                    url: Uri.parse('https://localhost:3000'),
                    createClient: _createHttpClient,
                    upload: (client, url) async {
                      final request = StreamedRequest('POST', url);
                      request.contentLength = _tenMb.length;
                      _generateStream().listen(
                        request.sink.add,
                        onDone: request.sink.close,
                      );
                      final response = await client.send(request);
                      return response.stream.bytesToString();
                    },
                  );
                },
                child: const Text('Benchmark HTTP (stream)'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await benchmarkUpload(
                    debugLabel: 'dio',
                    count: _largeResponseIterations,
                    url: Uri.parse('https://localhost:3000'),
                    createClient: _createDioClient,
                    upload: (client, url) async {
                      final response = await client.postUri(
                        url,
                        options: Options(
                          contentType: 'application/octet-stream',
                        ),
                        data: _tenMb,
                      );
                      return response.data;
                    },
                  );
                },
                child: const Text('Benchmark Dio (bytes)'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await benchmarkUpload(
                    debugLabel: 'dio',
                    count: _largeResponseIterations,
                    url: Uri.parse('https://localhost:3000'),
                    createClient: _createDioClient,
                    upload: (client, url) async {
                      final response = await client.postUri(
                        url,
                        options: Options(
                          contentType: 'application/octet-stream',
                        ),
                        data: _generateStream(),
                      );
                      return response.data;
                    },
                  );
                },
                child: const Text('Benchmark Dio (stream)'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await benchmarkUpload(
                    debugLabel: 'rhttp',
                    count: _largeResponseIterations,
                    url: 'https://localhost:3000',
                    createClient: _createRhttpClient,
                    upload: (client, url) async {
                      final response = await client.post(
                        url,
                        body: HttpBody.bytes(_tenMb),
                        onSendProgress: (curr, total) {},
                      );
                      return response.body;
                    },
                  );
                },
                child: const Text('Benchmark Rhttp (bytes)'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await benchmarkUpload(
                    debugLabel: 'rhttp',
                    count: _largeResponseIterations,
                    url: 'https://localhost:3000',
                    createClient: _createRhttpClient,
                    upload: (client, url) async {
                      final response = await client.post(
                        url,
                        body: HttpBody.stream(_generateStream()),
                        onSendProgress: (curr, total) {},
                      );
                      return response.body;
                    },
                  );
                },
                child: const Text('Benchmark Rhttp (stream)'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Future<IOClient> _createHttpClient() async {
  return IOClient(
    HttpClient()..badCertificateCallback = (_, __, ___) => true,
  );
}

Future<Dio> _createDioClient() async {
  final dio = Dio();
  dio.httpClientAdapter = IOHttpClientAdapter(
    createHttpClient: () {
      final client = HttpClient();
      client.badCertificateCallback = (cert, host, port) => true;
      return client;
    },
  );
  return dio;
}

Future<RhttpClient> _createRhttpClient() async {
  return await RhttpClient.create(
    settings: ClientSettings(
      tlsSettings: TlsSettings(
        verifyCertificates: false,
      ),
    ),
  );
}

Future<int> benchmarkDownload<T, U>({
  required String debugLabel,
  required int count,
  required U url,
  required Future<T> Function() createClient,
  required Future<Uint8List> Function(T client, U url) getBytes,
}) async {
  print('Downloading benchmark using $debugLabel package...');

  final client = await createClient();
  final padLeft = count.toString().length;

  final stopwatch = Stopwatch()..start();
  for (var i = 0; i < count; i++) {
    final response = await getBytes(client, url);
    print('[${'${i + 1}'.padLeft(padLeft)}] ${response.length}');
  }

  final time = stopwatch.elapsedMilliseconds;
  print('Elapsed time: $time ms');
  return stopwatch.elapsedMilliseconds;
}

Future<int> benchmarkDownloadStream<T, U>({
  required String debugLabel,
  required int count,
  required U url,
  required Future<T> Function() createClient,
  required Future<Stream<List<int>>> Function(T client, U url) getStream,
}) async {
  print('Downloading benchmark using $debugLabel package (stream variant)...');

  final client = await createClient();
  final padLeft = count.toString().length;

  final stopwatch = Stopwatch()..start();
  for (var i = 0; i < count; i++) {
    final response = await getStream(client, url);
    int bytes = 0;
    await for (final event in response) {
      bytes += event.length;
    }
    print('[${'${i + 1}'.padLeft(padLeft)}] $bytes');
  }

  final time = stopwatch.elapsedMilliseconds;
  print('Elapsed time: $time ms');
  return stopwatch.elapsedMilliseconds;
}

final _oneKb = Uint8List(1024);

final _tenMb = Uint8List(1024 * 1024 * 10);

Future<int> benchmarkUpload<T, U>({
  required String debugLabel,
  required int count,
  required U url,
  required Future<T> Function() createClient,
  required Future<String> Function(T client, U url) upload,
}) async {
  print('Uploading benchmark using $debugLabel package...');

  final client = await createClient();
  final padLeft = count.toString().length;

  final stopwatch = Stopwatch()..start();
  for (var i = 0; i < count; i++) {
    final status = await upload(client, url);
    print('[${'${i + 1}'.padLeft(padLeft)}] $status');
  }

  final time = stopwatch.elapsedMilliseconds;
  print('Elapsed time: $time ms');
  return stopwatch.elapsedMilliseconds;
}

Stream<List<int>> _generateStream() async* {
  for (var i = 0; i < _tenMb.length; i += _oneKb.length) {
    yield _oneKb;
  }
}
