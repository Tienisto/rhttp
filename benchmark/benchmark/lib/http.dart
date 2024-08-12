import 'dart:io';

import 'package:http/io_client.dart';

Future<int> benchmarkHttp(String url, int count) async {
  print('Downloading benchmark using http package...');

  final client = IOClient(
    HttpClient()..badCertificateCallback = (_, __, ___) => true,
  );

  final stopwatch = Stopwatch()..start();
  final uri = Uri.parse(url);
  for (var i = 0; i < count; i++) {
    final response = await client.get(uri);
    print(response.bodyBytes.length);
  }

  return stopwatch.elapsedMilliseconds;
}
