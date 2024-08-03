import 'package:flutter/material.dart';
import 'package:rhttp/rhttp.dart';

Future<void> main() async {
  await Rhttp.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  RhttpClient? _client;
  HttpTextResponse? response;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Test Page'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () async {
                  _client ??= await RhttpClient.create();

                  final res = await _client!.get(
                    'https://reqres.in/api/users',
                    query: {'page': '5'},
                  );
                  setState(() {
                    response = res;
                  });
                },
                child: const Text('Test'),
              ),
              if (response != null) Text(response!.version.toString()),
              if (response != null) Text(response!.statusCode.toString()),
              if (response != null) Text(response!.body.substring(0, 100).toString()),
              if (response != null) Text(response!.headers.toString()),
            ],
          ),
        ),
      ),
    );
  }
}
