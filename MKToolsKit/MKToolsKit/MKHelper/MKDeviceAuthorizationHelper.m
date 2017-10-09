//
//  MKDeviceAuthorizationHelper.m
//  MKDevelopSolutions
//
//  Created by xiaomk on 16/5/15.
//  Copyright © 2016年 xiaomk. All rights reserved.
//

#import "MKDeviceAuthorizationHelper.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <CoreLocation/CoreLocation.h>
#import <AddressBook/AddressBook.h>
#import <Contacts/Contacts.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <EventKit/EventKit.h>
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import "MKDeviceHelper.h"
#import "MKAlertView.h"

@implementation MKDeviceAuthorizationHelper

#pragma mark - ***** 相机授权 ******
+ (void)cameraAuthorization:(MKBoolBlock)block{
    if ([MKDeviceHelper isSystemIos8Later]) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        switch (status) {
            case AVAuthorizationStatusNotDetermined:{   //未授权 发起授权
                [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                    MKBlockExec(block, granted);
                }];
                break;
            }
            case AVAuthorizationStatusAuthorized:{   // 已经开启授权，可继续
                MKBlockExec(block, YES);
                break;
            }
            case AVAuthorizationStatusDenied:{       //拒绝
                NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
                NSString *appName = [infoDictionary objectForKey:@"CFBundleDisplayName"];
                NSString *msg = [NSString stringWithFormat:@"该功能需您请前往 “设置->隐私->相机->%@” 开启权限", appName];
                MKBlockExec(block, NO);
                NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if([[UIApplication sharedApplication] canOpenURL:url]) {
                    [MKAlertView alertWithTitle:@"提示" message:msg cancelTitle:@"暂不设置" confirmTitle:@"马上设置" block:^(NSInteger buttonIndex) {
                        if (buttonIndex == 1){
                            [[UIApplication sharedApplication] openURL:url];
                        }
                    }];
                }else{
                    [MKAlertView alertWithTitle:@"提示" message:msg cancelTitle:@"我知道了" confirmTitle:nil block:nil];
                }
            }
                break;
            case AVAuthorizationStatusRestricted:   //没有权限访问
                MKBlockExec(block, NO);
                break;
            default:
                break;
        }
    }else{
        block(YES);
    }
}

/** 判断设备是否有摄像头 */
+ (BOOL)isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

/** 前面的摄像头是否可用 */
+ (BOOL)isFrontCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

/** 后面的摄像头是否可用 */
+ (BOOL)isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

#pragma mark - ***** 定位授权 ******
+ (void)locationAuthorization:(MKBoolBlock)block{
    if ([CLLocationManager locationServicesEnabled]){   //检测的是整个的iOS系统的定位服务是否开启
        CLAuthorizationStatus authStatus = [CLLocationManager authorizationStatus];
        if (authStatus == kCLAuthorizationStatusNotDetermined) {    //未选择
            CLLocationManager* location = [[CLLocationManager alloc] init];
            if ([location respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
                [location requestWhenInUseAuthorization];
            }
        }else if (authStatus == kCLAuthorizationStatusAuthorizedAlways || authStatus == kCLAuthorizationStatusAuthorizedWhenInUse){
            MKBlockExec(block, YES);
        }else{
            MKBlockExec(block, NO);
        }
    }else{
        block(NO);
    }
}

#pragma mark - ***** 照片库授权 ******
+ (void)assetsLibAuthorization:(MKBoolBlock)block{
    if ([MKDeviceHelper isSystemIos8Later]) {
        NSInteger author = [PHPhotoLibrary authorizationStatus];
        if (author == PHAuthorizationStatusNotDetermined) { //未授权 发起授权
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                if (status == PHAuthorizationStatusAuthorized) {
                    MKBlockExec(block, YES);
                }else{
                    MKBlockExec(block, NO);
                }
            }];
        }else if (author == PHAuthorizationStatusAuthorized){   // 已经开启授权，可继续
            MKBlockExec(block, YES);
        }else{  //没有权限访问 //拒绝   PHAuthorizationStatusRestricted PHAuthorizationStatusDenied
            MKBlockExec(block, NO);
        }
    }
}

#pragma mark - ***** 通讯录授权 ******
+ (void)addressBookAuthorization:(MKBoolBlock)block{
    if ([MKDeviceHelper isSystemIos9Later]) {
        CNAuthorizationStatus authStatus = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
        if (authStatus == CNAuthorizationStatusNotDetermined) {     //未选择
            [[[CNContactStore alloc] init] requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
                MKBlockExec(block, granted);
            }];
        }else if (authStatus == CNAuthorizationStatusAuthorized){   //允许
            MKBlockExec(block, YES);
        }else{
            MKBlockExec(block, NO);
        }
    }else{
        if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined) {
            ABAddressBookRef addressBookref = ABAddressBookCreateWithOptions(NULL, NULL);
            ABAddressBookRequestAccessWithCompletion(addressBookref, ^(bool granted, CFErrorRef error) {
                if (granted) {
                    MKBlockExec(block, YES);
                }
            });
        }else if(ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized){
            MKBlockExec(block, YES);
        }else{
            MKBlockExec(block, NO);
        }
    }
}



#pragma mark - ***** 日历、提醒事项授权 ******
+ (void)eventWitType:(EKEntityType)type Authorization:(MKBoolBlock)block{
    EKAuthorizationStatus authStatus = [EKEventStore authorizationStatusForEntityType:type];
    switch (authStatus) {
        case EKAuthorizationStatusNotDetermined:   //未选择
            block(YES);
            break;
        case EKAuthorizationStatusRestricted:      //无权限
            block(NO);
            break;
        case EKAuthorizationStatusDenied:          //拒绝
            block(NO);
            break;
        case EKAuthorizationStatusAuthorized:      //允许
            block(YES);
            break;
        default:
            break;
    }
}


#pragma mark - ***** 蓝牙授权 ******
+ (void)bluetoothPeripheralAuthorization:(MKBoolBlock)block{
    CBPeripheralManagerAuthorizationStatus authStatus = [CBPeripheralManager authorizationStatus];
    switch (authStatus) {
        case CBPeripheralManagerAuthorizationStatusNotDetermined:   //未选择
            break;
        case CBPeripheralManagerAuthorizationStatusRestricted:      //无权限
            block(NO);
            break;
        case CBPeripheralManagerAuthorizationStatusDenied:          //拒绝
            block(NO);
            break;
        case CBPeripheralManagerAuthorizationStatusAuthorized:      //允许
            block(YES);
            break;
        default:
            break;
    }
}

#pragma mark - ***** 麦克风 ******
+ (void)recordAuthorization:(MKBoolBlock)block{
    AVAudioSessionRecordPermission authStatus = [[AVAudioSession sharedInstance] recordPermission];
    switch (authStatus) {
        case AVAudioSessionRecordPermissionUndetermined:   //未选择
            break;
        case AVAudioSessionRecordPermissionDenied:          //拒绝
            block(NO);
            break;
        case AVAudioSessionRecordPermissionGranted:         //允许
            block(YES);
            break;
        default:
            break;
    }
};





@end
