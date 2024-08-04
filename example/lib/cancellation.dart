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
  HttpBytesResponse? response;

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
                  final cancelToken = CancelToken();
                  final resFuture = Rhttp.requestBytes(
                    method: HttpMethod.get,
                    url: 'https://github.com/localsend/localsend/releases/download/v1.15.3/LocalSend-1.15.3-linux-x86-64.AppImage',
                    cancelToken: cancelToken,
                  );

                  Future.delayed(const Duration(seconds: 1), () {
                    cancelToken.cancel();
                  });

                  final res = await resFuture;

                  setState(() {
                    response = res;
                  });
                },
                child: const Text('Test'),
              ),
              if (response != null) Text(response!.version.toString()),
              if (response != null) Text(response!.statusCode.toString()),
              if (response != null) Text(response!.body.sublist(0, 100).toString()),
              if (response != null) Text(response!.headers.toString()),
            ],
          ),
        ),
      ),
    );
  }
}
