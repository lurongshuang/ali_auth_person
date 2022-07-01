#import "AliAuthPersonPlugin.h"
#if __has_include(<ali_auth_person/ali_auth_person-Swift.h>)
#import <ali_auth_person/ali_auth_person-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "ali_auth_person-Swift.h"
#endif

@implementation AliAuthPersonPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAliAuthPersonPlugin registerWithRegistrar:registrar];
}
@end
