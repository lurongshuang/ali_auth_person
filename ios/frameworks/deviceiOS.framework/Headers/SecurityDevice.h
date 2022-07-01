//
//  deviceiOS.h
//  deviceiOS
//
//  Created by nansong.zxc on 2020/3/25.
//  Copyright © 2020 security.net. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SecuritySession.h"

//! Project version number for deviceiOS.
FOUNDATION_EXPORT double deviceiOSVersionNumber;

//! Project version string for deviceiOS.
FOUNDATION_EXPORT const unsigned char deviceiOSVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <deviceiOS/PublicHeader.h>

@interface SecurityDevice : NSObject

/**
 * 设备指纹单例
 */
+ (SecurityDevice *)sharedInstance;

/**
 *  设备指纹初始化函数
 */
- (void)initDevice:(NSString *)userAppKey :(void (^)(int))initCallback;

/**
 * 底层数据传输走IPv6
 */
- (void)initDeviceIPV6:(NSString *)userAppKey :(void (^)(int))initCallback;

/**
 * 获取DeviceToken
 */
- (SecuritySession *) getSession;

/**
 * 用户自定义上报数据
 */
- (void)reportUserData:(int)type :(NSString *)msg;

/**
 * 在某些特殊时机上报，具体上报时机请联系 对接人员咨询
 */
- (void)reportMoment;

/**
 * 读取本次
 */
- (SecuritySessionId *)getSessionId;

/**
 * 设置自定义选项
 */
- (void)setOptions:(NSDictionary *)options;

@end
