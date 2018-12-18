//
//  MKAlertView.m
//  MKAlertView
//
//  Created by xmk on 2017/4/24.
//  Copyright © 2017年 mk. All rights reserved.
//

#import "MKAlertView.h"
#import <objc/runtime.h>
#import "MKUITools.h"
#import "UIAlertController+MKAdd.h"

@implementation MKAlertView

#pragma mark - ***** system style *****


+ (void)alertWithTitle:(NSString *)title
               message:(NSString *)message
           cancelTitle:(NSString *)cancelTitle
          confirmTitle:(NSString *)confirmTitle
                 block:(void (^)(NSInteger buttonIndex))block{
    [self alertWithTitle:title message:message cancelTitle:cancelTitle confirmTitle:confirmTitle onViewController:nil block:block];
}

+ (void)alertWithTitle:(NSString *)title
               message:(NSString *)message
           cancelTitle:(NSString *)cancelTitle
          confirmTitle:(NSString *)confirmTitle
      onViewController:(UIViewController *)vc
                 block:(void (^)(NSInteger buttonIndex))block{
    [self alertWithTitle:title message:message cancelTitle:cancelTitle confirmTitle:confirmTitle onViewController:vc config:nil block:block];
}

+ (void)alertWithTitle:(NSString *)title
               message:(NSString *)message
           cancelTitle:(NSString *)cancelTitle
          confirmTitle:(NSString *)confirmTitle
      onViewController:(UIViewController *)vc
                config:(MKAlertCtrlConfig *)config
                 block:(void (^)(NSInteger buttonIndex))block{
    if (vc == nil) {
        vc = [MKUITools topViewController];
    }
    UIAlertController *alert = [UIAlertController mk_alertWithTitle:title message:message cancelTitle:cancelTitle confirmTitle:confirmTitle preferredStyle:UIAlertControllerStyleAlert config:config block:block];
    [vc presentViewController:alert animated:YES completion:nil];

}



+ (void)alertWithTitle:(NSString *)title
               message:(NSString *)message
          buttonTitles:(NSArray *)buttonTitles
                 block:(void (^)(NSInteger buttonIndex))block{
    [self alertWithTitle:title message:message buttonTitles:buttonTitles onViewController:nil block:block];
}



+ (void)alertWithTitle:(NSString *)title
               message:(NSString *)message
          buttonTitles:(NSArray *)buttonTitles
      onViewController:(UIViewController *)vc
                 block:(void (^)(NSInteger buttonIndex))block{
    [self alertWithTitle:title message:message buttonTitles:buttonTitles onViewController:vc config:nil block:block];
}


+ (void)alertWithTitle:(NSString *)title
               message:(NSString *)message
          buttonTitles:(NSArray *)buttonTitles
      onViewController:(UIViewController *)vc
                config:(MKAlertCtrlConfig *)config
                 block:(void (^)(NSInteger buttonIndex))block{
    if (vc == nil) {
        vc = [MKUITools topViewController];
    }
    UIAlertController *alert = [UIAlertController mk_alertWithTitle:title message:message buttonTitles:buttonTitles preferredStyle:UIAlertControllerStyleAlert config:config block:block];
    [vc presentViewController:alert animated:YES completion:nil];
    
}





@end


