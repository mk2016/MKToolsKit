//
//  MKImagePickerCtrHelper.h
//  MKToolsKit
//
//  Created by xiaomk on 16/5/28.
//  Copyright © 2016年 tianchuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKConst.h"

typedef NS_ENUM(NSInteger, MKImagePickerType) {
    MKImagePickerType_camera = 1,
    MKImagePickerType_photoLibrary,
    
};

@interface MKImagePickerCtrHelper : NSObject

+ (instancetype)sharedInstance;

- (void)showWithSourceType:(MKImagePickerType)sourceType onViewController:(UIViewController *)vc block:(MKBlock)block;

@end
