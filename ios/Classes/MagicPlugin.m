#import "MagicPlugin.h"
#if __has_include(<magic/magic-Swift.h>)
#import <magic/magic-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "magic-Swift.h"
#endif

@implementation MagicPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftMagicPlugin registerWithRegistrar:registrar];
}
@end
