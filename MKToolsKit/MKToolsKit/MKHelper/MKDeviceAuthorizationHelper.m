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

+ (void)getAppAuthorizationWithType:(MKAppAuthorizationType)type block:(MKBoolBlock)block{
    [self getAppAuthorizationWithType:type showAlert:YES block:block];
}

+ (void)getAppAuthorizationWithType:(MKAppAuthorizationType)type showAlert:(BOOL)show block:(MKBoolBlock)block{
    if ([MKDeviceHelper isSimulator]) {
        if (type == MKAppAuthorizationType_camera
            || type == MKAppAuthorizationType_contacts){
            MKBlockExec(block, NO);
            return;
        }
    }
    if ([MKDeviceHelper isSystemIos8Later]) {
        switch (type) {
            case MKAppAuthorizationType_assetsLib:
                [self assetsLibAuthorizationShowAlert:show block:block];
                break;
            case MKAppAuthorizationType_camera:
                [self cameraAuthorizationShowAlert:show block:block];
                break;
            case MKAppAuthorizationType_contacts:
                [self contactsAuthorizationShowAlert:show block:block];
                break;
            case MKAppAuthorizationType_location:
                [self locationAuthorizationShowAlert:show block:block];
                break;
            default:
                break;
        }
    }
}

+ (void)showAlert:(BOOL)show type:(MKAppAuthorizationType)type{
    if (show) {
        [self openAppAuthorizationSetPageWithType:type];
    }
}

#pragma mark - ***** 相册授权 ******
+ (void)assetsLibAuthorizationShowAlert:(BOOL)show block:(MKBoolBlock)block{
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    switch (status) {
        case PHAuthorizationStatusNotDetermined:{   //未授权 发起授权
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                if (status == PHAuthorizationStatusAuthorized) {
                    MKBlockExec(block, YES);
                }else{
                    MKBlockExec(block, NO);
                    [self showAlert:show type:MKAppAuthorizationType_assetsLib];
                }
            }];
        }
            break;
        case PHAuthorizationStatusAuthorized:       // 已经开启授权，可继续
            MKBlockExec(block, YES);
            break;
        case PHAuthorizationStatusRestricted:       //没有权限访问
        case PHAuthorizationStatusDenied:           //拒绝
            MKBlockExec(block, NO);
            [self showAlert:show type:MKAppAuthorizationType_assetsLib];
            break;
        default:
            break;
    }
}

#pragma mark - ***** 相机授权 ******
+ (void)cameraAuthorizationShowAlert:(BOOL)show block:(MKBoolBlock)block{
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (status) {
        case AVAuthorizationStatusNotDetermined:{
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                MKBlockExec(block, granted);
                if (!granted) {
                    [self showAlert:show type:MKAppAuthorizationType_camera];
                }
            }];
        }
            break;
        case AVAuthorizationStatusAuthorized:
            MKBlockExec(block, YES);
            break;
        case AVAuthorizationStatusRestricted:
        case AVAuthorizationStatusDenied:
            MKBlockExec(block, NO);
            [self showAlert:show type:MKAppAuthorizationType_camera];
            break;
        default:
            break;
    }
}

#pragma mark - ***** 通讯录授权 ******
+ (void)contactsAuthorizationShowAlert:(BOOL)show block:(MKBoolBlock)block{
    if ([MKDeviceHelper isSystemIos9Later]) {
        CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
        switch (status) {
            case CNAuthorizationStatusNotDetermined:{
                [[[CNContactStore alloc] init] requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
                    MKBlockExec(block, granted);
                    if (!granted) {
                        [self showAlert:show type:MKAppAuthorizationType_contacts];
                    }
                }];
            }
                break;
            case CNAuthorizationStatusAuthorized:
                MKBlockExec(block, YES);
                break;
            case CNAuthorizationStatusRestricted:
            case CNAuthorizationStatusDenied:
                MKBlockExec(block, NO);
                [self showAlert:show type:MKAppAuthorizationType_contacts];
                break;
            default:
                break;
        }
    }else{
        ABAuthorizationStatus status = ABAddressBookGetAuthorizationStatus();
        switch (status) {
            case kABAuthorizationStatusNotDetermined:{
                ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL, NULL);
                ABAddressBookRequestAccessWithCompletion(addressBookRef, ^(bool granted, CFErrorRef error) {
                    MKBlockExec(block, granted);
                    if (!granted) {
                        [self showAlert:show type:MKAppAuthorizationType_contacts];
                    }
                    CFRelease(addressBookRef);
                });
            }
                break;
            case kABAuthorizationStatusAuthorized:
                MKBlockExec(block, YES);
                break;
            case kABAuthorizationStatusRestricted:
            case kABAuthorizationStatusDenied:
                MKBlockExec(block, NO);
                [self showAlert:show type:MKAppAuthorizationType_contacts];
                break;
            default:
                break;
        }
    }
}





#pragma mark - ***** 定位授权 ******
+ (void)locationAuthorizationShowAlert:(BOOL)show block:(MKBoolBlock)block{
    if ([CLLocationManager locationServicesEnabled]){   //检测的是整个的iOS系统的定位服务是否开启
        CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
        switch (status) {
            case kCLAuthorizationStatusNotDetermined:{
                CLLocationManager* location = [[CLLocationManager alloc] init];
                if ([location respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
                    [location requestWhenInUseAuthorization];
                }else if ([location respondsToSelector:@selector(requestAlwaysAuthorization)]){
                    [location requestAlwaysAuthorization];
                }
            }
            case kCLAuthorizationStatusAuthorizedAlways:
            case kCLAuthorizationStatusAuthorizedWhenInUse:
                MKBlockExec(block, YES);
                break;
            case kCLAuthorizationStatusRestricted:
            case kCLAuthorizationStatusDenied:
                MKBlockExec(block, NO);
                [self showAlert:show type:MKAppAuthorizationType_location];
                break;
            default:
                break;
        }
    }else{
        MKBlockExec(block, NO);
        [self showAlert:show type:MKAppAuthorizationType_location];
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





#pragma mark - ***** open app authorization set page ******
+ (void)openAppAuthorizationSetPageWithType:(MKAppAuthorizationType)type{
    NSString *appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
    NSString *str = nil;
    
    switch (type) {
        case MKAppAuthorizationType_assetsLib:
            str = @"照片";
            break;
        case MKAppAuthorizationType_camera:
            str = @"相机";
            break;
        case MKAppAuthorizationType_contacts:
            str = @"通讯录";
            break;
        case MKAppAuthorizationType_location:
            str = @"定位服务";
        default:
            break;
    }
    NSString *msg = [NSString stringWithFormat:@"请在”设置-隐私-%@“选项中，允许%@访问你的%@", str,appName, str];
    [self openAppAuthorizationSetPageWith:msg];
}


+ (void)openAppAuthorizationSetPageWith:(NSString *)msg{
    [MKAlertView alertWithTitle:@"提示" message:msg cancelTitle:@"取消" confirmTitle:@"设置" block:^(NSInteger buttonIndex) {
        if (buttonIndex == 1){
            [self openAppAuthorizationSetPage];
        }
    }];
}

+ (void)openAppAuthorizationSetPage{
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    [[UIApplication sharedApplication] openURL:url];
}




#pragma mark - ***** 摄像头 ******
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
@end
