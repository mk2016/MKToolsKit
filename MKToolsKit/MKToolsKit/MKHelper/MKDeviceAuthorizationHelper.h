//
//  MKDeviceAuthorizationHelper.h
//  MKDevelopSolutions
//
//  Created by xiaomk on 16/5/15.
//  Copyright © 2016年 xiaomk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <EventKit/EventKit.h>
#import "MKConst.h"

@interface MKDeviceAuthorizationHelper : NSObject

/** 相机授权 */
+ (void)cameraAuthorization:(MKBoolBlock)block;

/** 判断设备是否有摄像头 */
- (BOOL)isCameraAvailable;

/** 前面的摄像头是否可用 */
- (BOOL)isFrontCameraAvailable;

/** 后面的摄像头是否可用 */
- (BOOL)isRearCameraAvailable;

/** 定位授权 */
+ (void)locationAuthorization:(MKBoolBlock)block;

/** 照片库授权 */
+ (void)assetsLibAuthorization:(MKBoolBlock)block;

/** 日历、提醒事项授权 */
+ (void)eventWitType:(EKEntityType)type Authorization:(MKBoolBlock)block;

/** 蓝牙授权 */
+ (void)bluetoothPeripheralAuthorization:(MKBoolBlock)block;

/** 麦克风 */
+ (void)recordAuthorization:(MKBoolBlock)block;

/** 通讯录授权 */
+ (void)addressBookAuthorization:(MKBoolBlock)block;

@end
