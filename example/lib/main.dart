import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_with_native_example/flutter_with_native_example.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StreamSubscription? _sub;

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Builder(builder: (context) {
          return ListView(
            children: [
              TextButton(
                child: const Text("method channel"),
                onPressed: () async {
                  final result = await MyMethodChannel.add(1, 2);
                  showMessage(context, result);
                },
              ),
              TextButton(
                child: const Text("listen event channel"),
                onPressed: () {
                  _sub?.cancel();
                  _sub = MyEventChannel.listenNativeTimer(6000).listen((event) {
                    showMessage(context, event);
                  });
                },
              ),
              TextButton(
                child: const Text("cancel event channel"),
                onPressed: () {
                  _sub?.cancel();
                  _sub = null;
                },
              ),
              TextButton(
                child: const Text("incriment with ffi"),
                onPressed: () {
                  final result = incrimentWithFFI(1, 1);
                  showMessage(context, result);
                },
              ),
              TextButton(
                child: const Text("pigeon example"),
                onPressed: () async {
                  final pigeonModelApi = ModelApi();
                  final model = await pigeonModelApi.getModel(1);
                  showMessage(context, model?.title);
                },
              ),
              const SizedBox(
                height: 100,
                child: NativeButton(
                  text: "Native button",
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  void showMessage(BuildContext context, Object? message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message.toString())));
  }
}
