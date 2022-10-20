#import "JwplayerPlugin.h"
#if __has_include(<jwplayer/jwplayer-Swift.h>)
#import <jwplayer/jwplayer-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "jwplayer-Swift.h"
#endif

@implementation JwplayerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftJwplayerPlugin registerWithRegistrar:registrar];
}
@end
