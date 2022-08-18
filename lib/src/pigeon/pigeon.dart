import 'package:pigeon/pigeon.dart';

class Model {
  final int id;
  final String title;

  Model(this.id, this.title);
}

@HostApi()
abstract class ModelApi {
  Model? getModel(int id);
}
/**
flutter pub run pigeon \
--input lib/pigeon/pigeon.dart \
--dart_out lib/pigeon/pigeon_impl.dart \
--experimental_swift_out ios/Classes/Pigeon.swift \
--java_out ./android/src/main/kotlin/com/example/flutter_with_native_example/Pigeon.java \
--java_package "com.example.flutter_with_native_example"
 **/
