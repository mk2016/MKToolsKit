//
//  MKAlertView+MKAdd.h
//  MKToolsKit
//
//  Created by xmk on 2017/4/25.
//  Copyright © 2017年 mk. All rights reserved.
//

#import "MKAlertView.h"

@interface MKAlertView (MKAdd)

#pragma mark - ***** system style *****
+ (void)alertWithTitle:(NSString *)title
               message:(NSString *)message
           cancelTitle:(NSString *)cancelTitle
          confirmTitle:(NSString *)confirmTitle
                 block:(void (^)(NSInteger buttonIndex))block;

+ (void)alertWithTitle:(NSString *)title
               message:(NSString *)message
          buttonTitles:(NSArray *)buttonTitles
                 block:(void (^)(NSInteger buttonIndex))block;


#pragma mark - ***** custom style *****
+ (void)alertWithTitle:(NSString *)title
               message:(NSString *)message
           cancelTitle:(NSString *)cancelTitle
          confirmTitle:(NSString *)confirmTitle
                config:(MKAlertViewConfig *)config
                 block:(void (^)(NSInteger buttonIndex))block;

+ (void)alertWithTitle:(NSString *)title
               message:(NSString *)message
          buttonTitles:(NSArray *)buttonTitles
                config:(MKAlertViewConfig *)config
                 block:(void (^)(NSInteger buttonIndex))block;
@end
