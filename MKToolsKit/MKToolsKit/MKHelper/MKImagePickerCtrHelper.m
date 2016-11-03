//
//  MKImagePickerCtrHelper.m
//  MKToolsKit
//
//  Created by xiaomk on 16/5/28.
//  Copyright © 2016年 tianchuang. All rights reserved.
//

#import "MKImagePickerCtrHelper.h"

@interface MKImagePickerCtrHelper()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, weak) UIViewController *vc;
@property (nonatomic, assign) MKImagePickerType sourceType;
@property (nonatomic, copy) MKBlock block;
@property (nonatomic, strong) UIImagePickerController *ipc;
@end

@implementation MKImagePickerCtrHelper

MKImpl_sharedInstance(MKImagePickerCtrHelper);

- (UIImagePickerController *)ipc{
    if (!(_ipc)) {
        _ipc = [[UIImagePickerController alloc] init];
        _ipc.delegate = self;
        _ipc.allowsEditing = YES;
        _ipc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    }
    return _ipc;
}

- (void)showWithSourceType:(MKImagePickerType)sourceType onViewController:(UIViewController *)vc block:(MKBlock)block{
    if (vc && sourceType && block) {
        self.vc = vc;
        self.sourceType = sourceType;
        self.block = block;
    }
        
    if (self.sourceType == MKImagePickerType_camera) {
        self.ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else if (self.sourceType == MKImagePickerType_photoLibrary ){
        self.ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    }
    
    double delayInSeconds = 0.1;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [vc presentViewController:self.ipc animated:YES completion:nil];
    });
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [self.vc dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    if (self.block) {
        self.block(image);
    }
}




@end
