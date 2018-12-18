//
//  MKAlertView.h
//  MKAlertView
//
//  Created by xmk on 2017/4/24.
//  Copyright © 2017年 mk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class MKAlertCtrlConfig;
@interface MKAlertView : NSObject

#pragma mark - ***** system style *****

+ (void)alertWithTitle:(NSString *)title
               message:(NSString *)message
           cancelTitle:(NSString *)cancelTitle
          confirmTitle:(NSString *)confirmTitle
                 block:(void (^)(NSInteger buttonIndex))block;

+ (void)alertWithTitle:(NSString *)title
               message:(NSString *)message
           cancelTitle:(NSString *)cancelTitle
          confirmTitle:(NSString *)confirmTitle
      onViewController:(UIViewController *)vc
                 block:(void (^)(NSInteger buttonIndex))block;

+ (void)alertWithTitle:(NSString *)title
               message:(NSString *)message
           cancelTitle:(NSString *)cancelTitle
          confirmTitle:(NSString *)confirmTitle
      onViewController:(UIViewController *)vc
                config:(MKAlertCtrlConfig *)config
                 block:(void (^)(NSInteger buttonIndex))block;


+ (void)alertWithTitle:(NSString *)title
               message:(NSString *)message
          buttonTitles:(NSArray *)buttonTitles
                 block:(void (^)(NSInteger buttonIndex))block;

+ (void)alertWithTitle:(NSString *)title
               message:(NSString *)message
          buttonTitles:(NSArray *)buttonTitles
      onViewController:(UIViewController *)vc
                 block:(void (^)(NSInteger buttonIndex))block;

+ (void)alertWithTitle:(NSString *)title
               message:(NSString *)message
          buttonTitles:(NSArray *)buttonTitles
      onViewController:(UIViewController *)vc
                config:(MKAlertCtrlConfig *)config
                 block:(void (^)(NSInteger buttonIndex))block;

@end

