#import "FlutterWithNativeExamplePlugin.h"
#if __has_include(<flutter_with_native_example/flutter_with_native_example-Swift.h>)
#import <flutter_with_native_example/flutter_with_native_example-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_with_native_example-Swift.h"
#endif

@implementation FlutterWithNativeExamplePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterWithNativeExamplePlugin registerWithRegistrar:registrar];
}
@end
