//
//  MKUITools.h
//  MKToolsKit
//
//  Created by xmk on 16/9/23.
//  Copyright © 2016年 mk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MKUITools : NSObject

+ (id)getVCFromStoryboard:(NSString *)storyboard identify:(NSString *)identify;

#pragma mark - ***** top View ******
+ (UIView *)getTopView;

#pragma mark - ***** current ViewController ******
+ (UIViewController *)getCurrentViewController;
+ (UIViewController *)getCurrentViewControllerIsIncludePresentedVC:(BOOL)isIncludePVC;
+ (UIViewController *)getCurrentViewControllerWithWindowLevel:(CGFloat)windowLevel includePresentedVC:(BOOL)isIncludePVC;
+ (UIViewController *)getPresentedViewController;

+ (void)callTelephone:(NSString *)phone showAlert:(BOOL)showAlert;
@end
