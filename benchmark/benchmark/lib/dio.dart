import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';

Future<int> benchmarkDio(String url, int count) async {
  print('benchmark using dio package...');

  final dio = Dio();
  dio.httpClientAdapter = IOHttpClientAdapter(
    createHttpClient: () {
      final client = HttpClient();
      client.badCertificateCallback = (cert, host, port) => true;
      return client;
    },
  );

  final stopwatch = Stopwatch()..start();
  final uri = Uri.parse(url);
  for (var i = 0; i < count; i++) {
    final response = await dio.getUri(uri);
    print(response.data.length);
  }

  return stopwatch.elapsedMilliseconds;
}
