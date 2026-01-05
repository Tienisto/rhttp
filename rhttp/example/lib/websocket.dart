// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:rhttp/rhttp.dart';
import 'package:rhttp/src/rust/api/websocket.dart' as rust;
import 'package:rhttp_example/widgets/response_card.dart';

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
  late final RhttpWebsocketClient _client;
  String _logText = '';
  final _textEditingController = TextEditingController(
    text: 'Test message.',
  );

  Future<void> _initClient() async {
    _client = await RhttpWebsocketClient.connect(
      url: 'wss://echo.websocket.org',
      expectBody: HttpExpectBody.text,
    );

    _client.stream.listen(_handleWebSocketEvent);
  }

  void _handleWebSocketEvent(rust.RhttpWebSocketEvent event) {
    if (event is rust.RhttpWebSocketEvent_Message) {
      final message = event.field0;
      if (message is rust.RhttpWebSocketMessage_Text) {
        print('Message recieved: ${message.field0}');
        setState(() {
          _logText = '$_logText${message.field0}\n';
        });
      } else if (message is rust.RhttpWebSocketMessage_Close) {
        print(
          'Close message recieved with code ${message.code}. '
          'Reason: ${message.reason}',
        );
      }
    } else if (event is rust.RhttpWebSocketEvent_Closed) {
      print(
        'Closed with ${event.code}. '
        'Reason: ${event.reason}',
      );
    }
  }

  Future<void> _sendMessage(RhttpWebsocketClient client) async {
    try {
      await client.send(
        rust.RhttpWebSocketMessage.text(_textEditingController.text),
      );
    } catch (e, st) {
      print(e);
      print(st);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Websocket Page'),
        ),
        body: FutureBuilder(
          future: _initClient(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done ||
                snapshot.connectionState == ConnectionState.active) {
              return Padding(
                padding: EdgeInsetsGeometry.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    TextField(
                      controller: _textEditingController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter message to send.',
                        labelText: 'Message',
                      ),
                      onSubmitted: (value) => _sendMessage(_client),
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () => _sendMessage(_client),
                        child: const Text('Send'),
                      ),
                    ),
                    SizedBox.fromSize(
                      size: Size.fromHeight(6.0),
                    ),
                    Text(
                      'Received Messages:',
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Text(_logText),
                      ),
                    ),
                  ],
                ),
              );
            }

            return Center(child: CircularProgressIndicator.adaptive());
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
  }
}
