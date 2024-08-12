import 'package:rhttp/rhttp.dart';

Future<int> benchmarkRhttp(String url, int count) async {
  print('Downloading benchmark using rhttp package...');

  final client = await RhttpClient.create(
    settings: ClientSettings(
      tlsSettings: TlsSettings(
        verifyCertificates: false,
      ),
    ),
  );

  final stopwatch = Stopwatch()..start();
  for (var i = 0; i < count; i++) {
    final response = await client.getBytes(url);
    print(response.body.length);
  }

  return stopwatch.elapsedMilliseconds;
}
