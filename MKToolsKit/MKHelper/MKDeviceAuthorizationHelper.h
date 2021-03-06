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

typedef NS_ENUM(NSInteger, MKAppAuthorizationType) {
    MKAppAuthorizationType_assetsLib    = 1,    /*!< 照片库授权 */
    MKAppAuthorizationType_camera       = 2,    /*!< 相机授权 */
    MKAppAuthorizationType_contacts     = 3,    /*!< 通讯录授权 */
    MKAppAuthorizationType_location     = 4,    /*!< 定位服务 */
    MKAppAuthorizationType_nofity       = 5,    /*!< 通知 */
    MKAppAuthorizationType_cellularData = 6,    /*!< 网络 */
};

@interface MKDeviceAuthorizationHelper : NSObject

+ (void)getAppAuthorizationWithType:(MKAppAuthorizationType)type block:(MKBoolBlock)block;
+ (void)getAppAuthorizationWithType:(MKAppAuthorizationType)type showAlert:(BOOL)show block:(MKBoolBlock)block;

/** 网络是否被限制 */
+ (BOOL)getCellularAuthorization;

+ (BOOL)getNotifycationAuthorization;

/** 日历、提醒事项授权 */
+ (void)eventWitType:(EKEntityType)type Authorization:(MKBoolBlock)block;
/** 蓝牙授权 */
+ (void)bluetoothPeripheralAuthorization:(MKBoolBlock)block;
/** 麦克风 */
+ (void)recordAuthorization:(MKBoolBlock)block;


#pragma mark - ***** open app authorization set page ******
+ (void)openAppAuthorizationSetPageWith:(NSString *)msg;
+ (void)openAppAuthorizationSetPage;

#pragma mark - ***** 摄像头 ******
/** 判断设备是否有摄像头 */
+ (BOOL)isCameraAvailable;
/** 前面的摄像头是否可用 */
+ (BOOL)isFrontCameraAvailable;
/** 后面的摄像头是否可用 */
+ (BOOL)isRearCameraAvailable;
@end
