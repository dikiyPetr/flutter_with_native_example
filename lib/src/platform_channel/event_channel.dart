import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';

class MyEventChannel {
  MyEventChannel._();

  static const _channel =
      EventChannel('my_event_channel', StandardMethodCodec());

  static Stream<DateTime> listenNativeTimer(int period) {
    return _channel.receiveBroadcastStream([const Uuid().v4(), period]).map(
      (milliseconds) => DateTime.fromMillisecondsSinceEpoch(milliseconds),
    );
  }
}
