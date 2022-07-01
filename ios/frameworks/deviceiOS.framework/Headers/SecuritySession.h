//
//  SecuritySession.h
//  deviceiOS
//
//  Created by nansong.zxc on 2020/3/26.
//  Copyright © 2020 security.net. All rights reserved.
//

#ifndef SecuritySession_h
#define SecuritySession_h

/**
 * 设备指纹deviceToken
 */

@interface SecuritySession : NSObject

/**
 * 获取Session操作的结果
 */
@property(atomic) int code;

/**
 * 包含Session结果的字符串
 */
@property(copy, atomic) NSString *session;

@end

@interface SecuritySessionId : NSObject

/**
 * 获取SessionID操作的结果
 */
@property(atomic) int code;

/**
 * 包含Session结果的字符串
 */
@property(copy, atomic) NSString *sessionId;

@end
#endif /* SecuritySession_h */
