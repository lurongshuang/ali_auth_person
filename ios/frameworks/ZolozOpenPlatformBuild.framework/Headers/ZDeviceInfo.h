//
//  ZDeviceInfo.h
//  ZolozOpenPlatformBuild
//
//  Created by richard on 26/02/2018.
//  Copyright © 2018 com.alipay.iphoneclient.zoloz. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface ZDeviceInfo : NSObject

@property(nonatomic, strong)NSString * apdidToken;
@property(nonatomic, strong)NSString * wWORKSPACEID;

+(instancetype)getInstance;

-(NSString*) getTokenContent;

-(void)ActivityToken;

-(void)ActivityTokenWithParam:(NSDictionary*)param;

-(NSString*)ApperceptRiskwith:(NSInteger)action extParams:(NSDictionary *)args;

-(NSString*)ApperceptRiskwith2:(NSNumber*)action extParams:(NSDictionary *)args;

-(NSString*)ApperceptRiskwith33:(NSInteger) actionCode withExtInfo:(NSDictionary *) extInfo;

- (void)addPrivateStaticMonitorLoagWithparam1:(NSObject *)p1 param2:(NSObject *)p2 param3:(NSDictionary *)p3;

//+(void)ForTest:(NSInteger)action extParams:(id)object;

-(BOOL) getSwitch;
-(void) initSwitch;

@end
