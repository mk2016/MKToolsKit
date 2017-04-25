//
//  MKAlertView+MKAdd.m
//  MKToolsKit
//
//  Created by xmk on 2017/4/25.
//  Copyright © 2017年 mk. All rights reserved.
//

#import "MKAlertView+MKAdd.h"
#import "MKUITools.h"

@implementation MKAlertView (MKAdd)

#pragma mark - ***** system style *****


+ (void)alertWithTitle:(NSString *)title
               message:(NSString *)message
           cancelTitle:(NSString *)cancelTitle
          confirmTitle:(NSString *)confirmTitle
                 block:(void (^)(NSInteger buttonIndex))block{
    [self alertWithTitle:title message:message cancelTitle:cancelTitle confirmTitle:confirmTitle config:nil block:block];
}

+ (void)alertWithTitle:(NSString *)title
               message:(NSString *)message
          buttonTitles:(NSArray *)buttonTitles
      onViewController:(UIViewController *)vc
                 block:(void (^)(NSInteger buttonIndex))block{
    [self alertWithTitle:title message:message buttonTitles:buttonTitles config:nil block:block];
}




#pragma mark - ***** custom style *****
+ (void)alertWithTitle:(NSString *)title
               message:(NSString *)message
           cancelTitle:(NSString *)cancelTitle
          confirmTitle:(NSString *)confirmTitle
                config:(MKAlertViewConfig *)config
                 block:(void (^)(NSInteger buttonIndex))block{
    UIViewController *vc = [MKUITools getCurrentViewController];
    [MKAlertView alertWithTitle:title message:message cancelTitle:cancelTitle confirmTitle:confirmTitle config:nil onViewController:vc block:block];
}

+ (void)alertWithTitle:(NSString *)title
               message:(NSString *)message
          buttonTitles:(NSArray *)buttonTitles
                config:(MKAlertViewConfig *)config
                 block:(void (^)(NSInteger buttonIndex))block{
    UIViewController *vc = [MKUITools getCurrentViewController];
    [MKAlertView alertWithTitle:title message:message buttonTitles:buttonTitles config:config onViewController:vc block:block];
}

@end
