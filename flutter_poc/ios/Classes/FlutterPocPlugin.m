#import "FlutterPocPlugin.h"
#if __has_include(<flutter_poc/flutter_poc-Swift.h>)
#import <flutter_poc/flutter_poc-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_poc-Swift.h"
#endif

@implementation FlutterPocPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterPocPlugin registerWithRegistrar:registrar];
}
@end
