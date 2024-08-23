import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/material.dart';
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async {
              final time = await benchmarkHelper(
                debugLabel: 'http',
                count: _smallResponseIterations,
                url: Uri.parse('https://localhost:3000'),
                createClient: () async {
                  return IOClient(
                    HttpClient()..badCertificateCallback = (_, __, ___) => true,
                  );
                },
                getBytes: (client, url) async {
                  final response = await client.get(url);
                  return response.bodyBytes;
                },
              );
              print('Elapsed time: $time ms');
            },
            child: const Text('Benchmark HTTP (small responses)'),
          ),
          ElevatedButton(
            onPressed: () async {
              final time = await benchmarkHelper(
                debugLabel: 'http',
                count: _largeResponseIterations,
                url: Uri.parse('https://localhost:3000/large'),
                createClient: () async {
                  return IOClient(
                    HttpClient()..badCertificateCallback = (_, __, ___) => true,
                  );
                },
                getBytes: (client, url) async {
                  final response = await client.get(url);
                  return response.bodyBytes;
                },
              );
              print('Elapsed time: $time ms');
            },
            child: const Text('Benchmark HTTP (large responses)'),
          ),
          ElevatedButton(
            onPressed: () async {
              final time = await benchmarkHelper(
                debugLabel: 'dio',
                count: _smallResponseIterations,
                url: Uri.parse('https://localhost:3000'),
                createClient: () async {
                  final dio = Dio();
                  dio.httpClientAdapter = IOHttpClientAdapter(
                    createHttpClient: () {
                      final client = HttpClient();
                      client.badCertificateCallback =
                          (cert, host, port) => true;
                      return client;
                    },
                  );
                  return dio;
                },
                getBytes: (client, url) async {
                  final response = await client.getUri(
                    url,
                    options: Options(responseType: ResponseType.bytes),
                  );
                  return response.data;
                },
              );
              print('Elapsed time: $time ms');
            },
            child: const Text('Benchmark Dio (small responses)'),
          ),
          ElevatedButton(
            onPressed: () async {
              final time = await benchmarkHelper(
                debugLabel: 'dio',
                count: _largeResponseIterations,
                url: Uri.parse('https://localhost:3000/large'),
                createClient: () async {
                  final dio = Dio();
                  dio.httpClientAdapter = IOHttpClientAdapter(
                    createHttpClient: () {
                      final client = HttpClient();
                      client.badCertificateCallback =
                          (cert, host, port) => true;
                      return client;
                    },
                  );
                  return dio;
                },
                getBytes: (client, url) async {
                  final response = await client.getUri(
                    url,
                    options: Options(responseType: ResponseType.bytes),
                  );
                  return response.data;
                },
              );
              print('Elapsed time: $time ms');
            },
            child: const Text('Benchmark Dio (large responses)'),
          ),
          ElevatedButton(
            onPressed: () async {
              final time = await benchmarkHelper(
                debugLabel: 'rhttp',
                count: _smallResponseIterations,
                url: 'https://localhost:3000',
                createClient: () => RhttpClient.create(
                  settings: ClientSettings(
                    tlsSettings: TlsSettings(
                      verifyCertificates: false,
                    ),
                  ),
                ),
                getBytes: (client, url) async {
                  final response = await client.getBytes(url);
                  return response.body;
                },
              );
              print('Elapsed time: $time ms');
            },
            child: const Text('Benchmark Rhttp (small responses)'),
          ),
          ElevatedButton(
            onPressed: () async {
              final time = await benchmarkHelper(
                debugLabel: 'rhttp',
                count: _largeResponseIterations,
                url: 'https://localhost:3000/large',
                createClient: () => RhttpClient.create(
                  settings: ClientSettings(
                    tlsSettings: TlsSettings(
                      verifyCertificates: false,
                    ),
                  ),
                ),
                getBytes: (client, url) async {
                  final response = await client.getBytes(url);
                  return response.body;
                },
              );

              print('Elapsed time: $time ms');
            },
            child: const Text('Benchmark Rhttp (large responses)'),
          ),
        ],
      ),
    );
  }
}

Future<int> benchmarkHelper<T, U>({
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

  return stopwatch.elapsedMilliseconds;
}
