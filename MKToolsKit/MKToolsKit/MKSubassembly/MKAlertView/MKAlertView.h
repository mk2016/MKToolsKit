//
//  MKAlertView.h
//  MKAlertView
//
//  Created by xmk on 2017/4/24.
//  Copyright © 2017年 mk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class MKAlertViewConfig;
@interface MKAlertView : NSObject

#pragma mark - ***** system style *****
+ (void)alertWithTitle:(NSString *)title
               message:(NSString *)message
      onViewController:(UIViewController *)vc
                 block:(void (^)(NSInteger buttonIndex))block
          buttonTitles:(NSString *)cancelTitle, ... NS_REQUIRES_NIL_TERMINATION;

+ (void)alertWithTitle:(NSString *)title
               message:(NSString *)message
           cancelTitle:(NSString *)cancelTitle
          confirmTitle:(NSString *)confirmTitle
      onViewController:(UIViewController *)vc
                 block:(void (^)(NSInteger buttonIndex))block;

+ (void)alertWithTitle:(NSString *)title
               message:(NSString *)message
          buttonTitles:(NSArray *)buttonTitles
      onViewController:(UIViewController *)vc
                 block:(void (^)(NSInteger buttonIndex))block;




#pragma mark - ***** custom style *****
+ (void)alertWithTitle:(NSString *)title
               message:(NSString *)message
                config:(MKAlertViewConfig *)config
      onViewController:(UIViewController *)vc
                 block:(void (^)(NSInteger buttonIndex))block
          buttonTitles:(NSString *)cancelTitle, ... NS_REQUIRES_NIL_TERMINATION;

+ (void)alertWithTitle:(NSString *)title
               message:(NSString *)message
           cancelTitle:(NSString *)cancelTitle
          confirmTitle:(NSString *)confirmTitle
                config:(MKAlertViewConfig *)config
      onViewController:(UIViewController *)vc
                 block:(void (^)(NSInteger buttonIndex))block;

+ (void)alertWithTitle:(NSString *)title
               message:(NSString *)message
          buttonTitles:(NSArray *)buttonTitles
                config:(MKAlertViewConfig *)config
      onViewController:(UIViewController *)vc
                 block:(void (^)(NSInteger buttonIndex))block;
@end


@interface MKAlertViewConfig : NSObject
@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, assign) NSTextAlignment titleAlignment;
@property (nonatomic, strong) UIFont *messageFont;
@property (nonatomic, strong) UIColor *messageColor;
@property (nonatomic, assign) NSTextAlignment messageAlignment;
@property (nonatomic, strong) UIColor *actionColor;
@property (nonatomic, assign) NSInteger cancelIndex;
@property (nonatomic, assign) NSInteger destructiveIndex;
@property (nonatomic, strong) UIColor *destructivelColor;
@end
