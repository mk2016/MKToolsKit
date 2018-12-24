//
//  MKImagePickerCtrHelper.m
//  MKToolsKit
//
//  Created by xiaomk on 16/5/28.
//  Copyright © 2016年 tianchuang. All rights reserved.
//

#import "MKImagePickerCtrHelper.h"
#import "MKDeviceAuthorizationHelper.h"
#import "MKUITools.h"

@interface MKImagePickerCtrHelper()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, weak) UIViewController *vc;
@property (nonatomic, assign) MKImagePickerType sourceType;
@property (nonatomic, copy) MKBlock block;
@property (nonatomic, strong) UIImagePickerController *ipc;
@end

@implementation MKImagePickerCtrHelper

MK_IMPL_SHAREDINSTANCE(MKImagePickerCtrHelper);

- (void)showWithSourceType:(MKImagePickerType)sourceType onViewController:(UIViewController *)vc block:(MKBlock)block{
    self.vc = vc;
    self.sourceType = sourceType;
    self.block = block;
    
    if (self.vc == nil) {
        self.vc = [MKUITools topViewController];
    }
    
    if (self.sourceType == MKImagePickerType_none) {
        self.sourceType = MKImagePickerType_camera;
    }
    
    MKAppAuthorizationType authType = MKAppAuthorizationType_camera;
    if (self.sourceType == MKImagePickerType_camera) {
        self.ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
        authType = MKAppAuthorizationType_camera;
    }else if (self.sourceType == MKImagePickerType_photoLibrary ){
        self.ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        authType = MKAppAuthorizationType_assetsLib;
    }
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    }
    
    MK_WEAK_SELF
    [MKDeviceAuthorizationHelper getAppAuthorizationWithType:authType block:^(BOOL bRet) {
        if (bRet) {
            double delayInSeconds = 0.1;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [vc presentViewController:weakSelf.ipc animated:YES completion:nil];
            });
        }else{
            MK_BLOCK_EXEC(block, nil);
        }
    }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [self.vc dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    MK_BLOCK_EXEC(self.block, image);
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self.vc dismissViewControllerAnimated:YES completion:nil];
    MK_BLOCK_EXEC(self.block, nil);
}

#pragma mark - ***** lazy ******
- (UIImagePickerController *)ipc{
    if (!_ipc) {
        _ipc = [[UIImagePickerController alloc] init];
        _ipc.delegate = self;
        _ipc.allowsEditing = YES;
        _ipc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        _ipc.navigationBar.translucent = NO;
    }
    return _ipc;
}

@end

