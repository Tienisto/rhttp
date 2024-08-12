import 'package:benchmark/dio.dart';
import 'package:benchmark/http.dart';
import 'package:benchmark/rhttp.dart';
import 'package:flutter/material.dart';
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
              final time = await benchmarkHttp(
                  'https://localhost:3000', _smallResponseIterations);
              print('Elapsed time: $time ms');
            },
            child: const Text('Benchmark HTTP (small responses)'),
          ),
          ElevatedButton(
            onPressed: () async {
              final time = await benchmarkHttp(
                  'https://localhost:3000/large', _largeResponseIterations);
              print('Elapsed time: $time ms');
            },
            child: const Text('Benchmark HTTP (large responses)'),
          ),
          ElevatedButton(
            onPressed: () async {
              final time = await benchmarkDio(
                  'https://localhost:3000', _smallResponseIterations);
              print('Elapsed time: $time ms');
            },
            child: const Text('Benchmark Dio (small responses)'),
          ),
          ElevatedButton(
            onPressed: () async {
              final time = await benchmarkDio(
                  'https://localhost:3000/large', _largeResponseIterations);
              print('Elapsed time: $time ms');
            },
            child: const Text('Benchmark Dio (large responses)'),
          ),
          ElevatedButton(
            onPressed: () async {
              final time = await benchmarkRhttp(
                  'https://localhost:3000', _smallResponseIterations);
              print('Elapsed time: $time ms');
            },
            child: const Text('Benchmark Rhttp (small responses)'),
          ),
          ElevatedButton(
            onPressed: () async {
              final time = await benchmarkRhttp(
                  'https://localhost:3000/large', _largeResponseIterations);
              print('Elapsed time: $time ms');
            },
            child: const Text('Benchmark Rhttp (large responses)'),
          ),
        ],
      ),
    );
  }
}
