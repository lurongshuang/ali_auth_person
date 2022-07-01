#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint ali_auth_person.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'ali_auth_person'
  s.version          = '0.0.1'
  s.summary          = 'A new Flutter project.'
  s.description      = <<-DESC
A new Flutter project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.platform = :ios, '9.0'

  s.vendored_frameworks = 'frameworks/AliyunIdentityManager.framework','frameworks/AliyunOSSiOS.framework','frameworks/APBToygerFacade.framework','frameworks/APPSecuritySDK.framework','frameworks/BioAuthAPI.framework','frameworks/BioAuthEngine.framework','frameworks/deviceiOS.framework','frameworks/MPRemoteLogging.framework','frameworks/OCRDetectSDKForTech.framework','frameworks/ToygerNative.framework','frameworks/ToygerService.framework','frameworks/ZolozIdentityManager.framework','frameworks/ZolozMobileRPC.framework','frameworks/ZolozOpenPlatformBuild.framework','frameworks/ZolozSensorServices.framework','frameworks/ZolozUtility.framework'

  s.frameworks = 'CoreGraphics','Accelerate','SystemConfiguration','AssetsLibrary','CoreTelephony','QuartzCore','CoreFoundation','CoreLocation','ImageIO','CoreMedia','CoreMotion','AVFoundation','WebKit','AudioToolbox','CFNetwork','MobileCoreServices','AdSupport'

  s.libraries = 'resolv','z','c++.1','c++abi','z.1.2.8'
  
  s.resource_bundles = { 'Resources' => 'frameworks/*.framework/*.bundle' }

  # 解决移动crash
  s.xcconfig = {
    'OTHER_LDFLAGS' => '-ObjC',
    'ENABLE_BITCODE' => 'NO'
  }

  # 加载静态资源
  s.resources = ['Assets/*']

  # Flutter.framework does not contain a i386 slice.
  # s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'

  # s.ios.deployment_target = '9.0'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
  s.pod_target_xcconfig = {'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'   }
  s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
end
