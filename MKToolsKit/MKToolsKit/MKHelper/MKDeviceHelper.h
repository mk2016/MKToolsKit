//
//  MKDeviceHelper.h
//  MKToolsKit
//
//  Created by xiaomk on 16/5/15.
//  Copyright © 2016年 xiaomk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MKDeviceHelper : NSObject


#define MK_Device_is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#pragma mark - ***** app 信息 ******
+ (NSString *)getUUID;

/** 发布版本号 */
+ (NSString *)appBundleShortVersion;

/** 打包版本号 */
+ (NSString *)appBundleVersion;

/** 发布版本号转int */
+ (int)appIntVersion;

#pragma mark - ***** 系统信息 ******
/** 获取设备系统版本 */
+ (float)systemVersion;

/** 获取设备系统版本字符串 保留2位小数*/
+ (NSString *)systemVersionString;

+ (BOOL)isSystemIos7Later;
+ (BOOL)isSystemIos8Later;
+ (BOOL)isSystemIos9Later;
+ (BOOL)isSystemIos10Later;
+ (BOOL)isSystemIos11Later;
/** 设备信息对应名称 */
+ (NSString *)deviceType;

/** 获取设备信息 */
+ (NSString *)devicePlatform;

+ (BOOL)isSimulator;
#pragma mark - ***** 手机信息 ******
/** get the phone name */
+ (NSString *)phoneName;
/** get the phone model: iPhone, iPad, iPod ... */
+ (NSString *)phoneModel;


/** Get the Screen Brightness */
+ (float)screenBrightness;
/** get the battery level */
+ (float)batteryLevel;
/** 是否在充电 */
+ (BOOL)charging;
@end
