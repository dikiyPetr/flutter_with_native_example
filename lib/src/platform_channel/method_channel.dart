import 'package:flutter/services.dart';

class MyMethodChannel {
  MyMethodChannel._();

  static const _channel =
      MethodChannel('my_method_channel', StandardMethodCodec());

  static Future<int> add(int a, int b) async {
    final result = await _channel.invokeMethod('add', [a, b]);
    return result as int;
  }
}
