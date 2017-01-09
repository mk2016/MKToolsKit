//
//  MKAlertView.h
//  MKToolsKit
//
//  Created by xiaomk on 16/5/16.
//  Copyright © 2016年 xiaomk. All rights reserved.
//

#import <UIKit/UIKit.h>


#pragma mark - ***** MKAlertView ******
@interface MKAlertView : NSObject

+ (void)alertWithTitle:(NSString *)title
               message:(NSString *)message
     cancelButtonTitle:(NSString *)cancelButtonTitle
    confirmButtonTitle:(NSString *)confirmButtonTitle
                 block:(void (^)(NSInteger buttonIndex))block;

+ (void)alertWithTitle:(NSString *)title
               message:(NSString *)message
          buttonTitles:(NSArray *)buttonTitles
                 block:(void (^)(NSInteger buttonIndex))block;


+ (void)alertWithTitle:(NSString *)title
               message:(NSString *)message
      onViewController:(UIViewController *)vc
                 block:(void (^)(NSInteger buttonIndex))block
          buttonTitles:(NSString *)cancelTitle, ... NS_REQUIRES_NIL_TERMINATION;

+ (void)alertWithTitle:(NSString *)title
               message:(NSString *)message
     cancelButtonTitle:(NSString *)cancelButtonTitle
    confirmButtonTitle:(NSString *)confirmButtonTitle
        viewController:(UIViewController *)vc
                 block:(void (^)(NSInteger buttonIndex))block;

+ (void)alertWithTitle:(NSString *)title
               message:(NSString *)message
          buttonTitles:(NSArray *)buttonTitles
      onViewController:(UIViewController *)vc
                 block:(void (^)(NSInteger buttonIndex))block;

@end
