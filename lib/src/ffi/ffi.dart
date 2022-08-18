import 'dart:ffi';
import 'dart:ffi' as ffi;
import 'dart:io';

final _library = Platform.isAndroid
    ? DynamicLibrary.open('libnative_add.so')
    : DynamicLibrary.process();

final incrimentWithFFI = _library.lookupFunction<
    Int32 Function(Int32, Int32),
    int Function(int, int)>('native_add');
