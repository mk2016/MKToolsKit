//
//  MKAlertView.m
//  MKAlertView
//
//  Created by xmk on 2017/4/24.
//  Copyright © 2017年 mk. All rights reserved.
//

#import "MKAlertView.h"
#import <objc/runtime.h>

@implementation MKAlertView

#pragma mark - ***** system style *****
+ (void)alertWithTitle:(NSString *)title
               message:(NSString *)message
      onViewController:(UIViewController *)vc
                 block:(void (^)(NSInteger buttonIndex))block
          buttonTitles:(NSString *)cancelTitle, ... NS_REQUIRES_NIL_TERMINATION{
    
    NSMutableArray *argsArray = [[NSMutableArray alloc] init];
    if (cancelTitle) {
        [argsArray addObject:cancelTitle];
        va_list argList;
        va_start(argList, cancelTitle);
        NSString *btnTitle;
        while ((btnTitle = va_arg(argList, NSString *))) {
            [argsArray addObject:btnTitle];
        }
        va_end(argList);
    }
    [self alertWithTitle:title message:message buttonTitles:argsArray onViewController:vc block:block];
}

+ (void)alertWithTitle:(NSString *)title
               message:(NSString *)message
           cancelTitle:(NSString *)cancelTitle
          confirmTitle:(NSString *)confirmTitle
      onViewController:(UIViewController *)vc
                 block:(void (^)(NSInteger buttonIndex))block{
    [self alertWithTitle:title message:message cancelTitle:cancelTitle confirmTitle:confirmTitle config:nil onViewController:vc block:block];
}

+ (void)alertWithTitle:(NSString *)title
               message:(NSString *)message
          buttonTitles:(NSArray *)buttonTitles
      onViewController:(UIViewController *)vc
                 block:(void (^)(NSInteger buttonIndex))block{
    [self alertWithTitle:title message:message buttonTitles:buttonTitles config:nil onViewController:vc block:block];
}




#pragma mark - ***** custom style *****
+ (void)alertWithTitle:(NSString *)title
               message:(NSString *)message
                config:(MKAlertViewConfig *)config
      onViewController:(UIViewController *)vc
                 block:(void (^)(NSInteger buttonIndex))block
          buttonTitles:(NSString *)cancelTitle, ... NS_REQUIRES_NIL_TERMINATION{
    
    NSMutableArray *argsArray = [[NSMutableArray alloc] init];
    if (cancelTitle) {
        [argsArray addObject:cancelTitle];
        va_list argList;
        va_start(argList, cancelTitle);
        NSString *btnTitle;
        while ((btnTitle = va_arg(argList, NSString *))) {
            [argsArray addObject:btnTitle];
        }
        va_end(argList);
    }
    
    [self alertWithTitle:title message:message buttonTitles:argsArray config:config onViewController:vc block:block];
}

+ (void)alertWithTitle:(NSString *)title
               message:(NSString *)message
           cancelTitle:(NSString *)cancelTitle
          confirmTitle:(NSString *)confirmTitle
                config:(MKAlertViewConfig *)config
      onViewController:(UIViewController *)vc
                 block:(void (^)(NSInteger buttonIndex))block{
    
    if (!config) {
        config = [[MKAlertViewConfig alloc] init];
    }
    
    NSMutableArray *argsArray = [[NSMutableArray alloc] initWithCapacity:2];
    if (cancelTitle) {
        [argsArray addObject:cancelTitle];
        if (config.cancelIndex < 0) {
            config.cancelIndex = 0;
        }
    }
    if (confirmTitle) {
        [argsArray addObject:confirmTitle];
    }
    [self alertWithTitle:title message:message buttonTitles:argsArray config:config onViewController:vc block:block];
}

+ (void)alertWithTitle:(NSString *)title
               message:(NSString *)message
          buttonTitles:(NSArray *)buttonTitles
                config:(MKAlertViewConfig *)config
      onViewController:(UIViewController *)vc
                 block:(void (^)(NSInteger buttonIndex))block{

    if (!buttonTitles || buttonTitles.count == 0) {
        NSAssert(NO, @"MKAlertView: buttonTitles count 必须大于 0");
        return;
    }else if (!vc){
        NSAssert(NO, @"MKAlertView: viewController unable with nil");
        return;
    }
    if (!config) {
        config = [[MKAlertViewConfig alloc] init];
    }
    
    NSMutableArray *argsArray = [[NSMutableArray alloc] initWithArray:buttonTitles];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        //iOS 8 之后用 UIAlertController
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        
        unsigned int count = 0;
        //runtime
        //message text
        Ivar *property = class_copyIvarList([UIAlertController class], &count);
        for(int k = 0; k < count; k++){
            Ivar ivar = property[k];
            NSString *ivarName = [NSString stringWithCString:ivar_getName(ivar) encoding:NSUTF8StringEncoding];
            NSString *ivarType = [NSString stringWithCString:ivar_getTypeEncoding(ivar) encoding:NSUTF8StringEncoding];
            
            if ([ivarName isEqualToString:@"_attributedTitle"] && [ivarType isEqualToString:@"@\"NSAttributedString\""]){
                if (title && title.length) {
                    NSRange titleRange = NSMakeRange(0, title.length);
                    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:title attributes:nil];
                    if (config.titleFont) {
                        [attributedString addAttribute:NSFontAttributeName value:config.titleFont range:titleRange];
                    }
                    if (config.titleColor) {
                        [attributedString addAttribute:NSForegroundColorAttributeName value:config.titleColor range:titleRange];
                    }
                    
                    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
                    paragraphStyle.alignment = config.titleAlignment;//设置对齐方式
                    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:titleRange];
                    [alertController setValue:attributedString forKey:@"attributedTitle"];
                }
            }else if ([ivarName isEqualToString:@"_attributedMessage"] && [ivarType isEqualToString:@"@\"NSAttributedString\""]) {
                if (message && message.length) {
                    NSRange messageRange = NSMakeRange(0, message.length);
                    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:message attributes:nil];
                    if (config.messageFont) {
                        [attributedString addAttribute:NSFontAttributeName value:config.messageFont range:messageRange];
                    }
                    if (config.messageColor) {
                        [attributedString addAttribute:NSForegroundColorAttributeName value:config.messageColor range:messageRange];
                    }
                    
                    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
                    paragraphStyle.alignment = config.messageAlignment;//设置对齐方式
                    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:messageRange];
                    [alertController setValue:attributedString forKey:@"attributedMessage"];
                }
            }
        }
        
        //action
        Ivar *ivars = class_copyIvarList([UIAlertAction class], &count);
        for (int i = 0; i < [argsArray count]; i++) {
            UIAlertActionStyle style = UIAlertActionStyleDefault;
            if (i == config.cancelIndex) {
                style = UIAlertActionStyleCancel;
            }else if (i == config.destructiveIndex){
                style = UIAlertActionStyleDestructive;
            }
            UIAlertAction *action = [UIAlertAction actionWithTitle:[argsArray objectAtIndex:i] style:style handler:^(UIAlertAction * _Nonnull action) {
                if (block) {
                    block(i);
                }
            }];
            
            for(int j = 0; j < count; j++){
                Ivar ivar = ivars[j];
                NSString *ivarName = [NSString stringWithCString:ivar_getName(ivar) encoding:NSUTF8StringEncoding];
                if ([ivarName isEqualToString:@"_titleTextColor"]) {
                    if (i == config.destructiveIndex) {
                        if (config.destructivelColor) {
                            [action setValue:config.destructivelColor forKey:@"titleTextColor"];
                        }else{
                            [action setValue:[UIColor redColor] forKey:@"titleTextColor"];
                        }
                    }else{
                        [action setValue:config.actionColor forKey:@"titleTextColor"];
                    }
                }
            }
            [alertController addAction:action];
        }
        [alertController.view setNeedsLayout];
        [alertController.view layoutIfNeeded];
        [vc presentViewController:alertController animated:YES completion:nil];
    }
}

@end


@implementation MKAlertViewConfig
- (id)init{
    if (self = [super init]) {
        _titleFont = [UIFont boldSystemFontOfSize:17];
        _titleColor = [UIColor blackColor];
        _titleAlignment = NSTextAlignmentCenter;
        _messageFont = [UIFont systemFontOfSize:13];
        _messageColor = [UIColor blackColor];
        _messageAlignment = NSTextAlignmentCenter;
        _cancelIndex = -1;
        _destructiveIndex = -1;
    }
    return self;
}
@end
