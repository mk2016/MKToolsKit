//
//  UIAlertController+MKAdd.m
//  MKAlertView
//
//  Created by xmk on 2017/6/16.
//  Copyright © 2017年 mk. All rights reserved.
//

#import "UIAlertController+MKAdd.h"
#import <objc/runtime.h>

@implementation UIAlertController (MKAdd)

#pragma mark - ***** system style *****
+ (instancetype)mk_alertWithTitle:(NSString *)title
                          message:(NSString *)message
                   preferredStyle:(UIAlertControllerStyle)style
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
    return [self mk_alertWithTitle:title message:message buttonTitles:argsArray preferredStyle:style block:block];
}

+ (instancetype)mk_alertWithTitle:(NSString *)title
                          message:(NSString *)message
                      cancelTitle:(NSString *)cancelTitle
                     confirmTitle:(NSString *)confirmTitle
                   preferredStyle:(UIAlertControllerStyle)style
                            block:(void (^)(NSInteger buttonIndex))block{
    return [self mk_alertWithTitle:title message:message cancelTitle:cancelTitle confirmTitle:confirmTitle preferredStyle:style config:nil block:block];
}

+ (instancetype)mk_alertWithTitle:(NSString *)title
                          message:(NSString *)message
                     buttonTitles:(NSArray *)buttonTitles
                   preferredStyle:(UIAlertControllerStyle)style
                            block:(void (^)(NSInteger buttonIndex))block{
    return [self mk_alertWithTitle:title message:message buttonTitles:buttonTitles preferredStyle:style config:nil block:block];
    
}

#pragma mark - ***** custom style *****
+ (instancetype)mk_alertWithTitle:(NSString *)title
                          message:(NSString *)message
                   preferredStyle:(UIAlertControllerStyle)style
                           config:(MKAlertCtrlConfig *)config
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
    return [self mk_alertWithTitle:title message:message buttonTitles:argsArray preferredStyle:style config:config block:block];
}


+ (instancetype)mk_alertWithTitle:(NSString *)title
                          message:(NSString *)message
                      cancelTitle:(NSString *)cancelTitle
                     confirmTitle:(NSString *)confirmTitle
                   preferredStyle:(UIAlertControllerStyle)style
                           config:(MKAlertCtrlConfig *)config
                            block:(void (^)(NSInteger buttonIndex))block{
    
    if (config == nil) {
        config = [[MKAlertCtrlConfig alloc] init];
    }
    NSMutableArray *buttons = @[].mutableCopy;
    if (cancelTitle && cancelTitle.length > 0) {
        [buttons addObject:cancelTitle];
        if (config.cancelIndex < 0) {
            config.cancelIndex = 0;
        }
    }
    
    if (confirmTitle && confirmTitle.length > 0) {
        [buttons addObject:confirmTitle];
    }
    return [self mk_alertWithTitle:title message:message buttonTitles:buttons preferredStyle:style config:config block:block];
}

+ (instancetype)mk_alertWithTitle:(NSString *)title
                          message:(NSString *)message
                     buttonTitles:(NSArray *)buttonTitles
                   preferredStyle:(UIAlertControllerStyle)style
                           config:(MKAlertCtrlConfig *)config
                            block:(void (^)(NSInteger buttonIndex))block{
    
    if (!buttonTitles || buttonTitles.count == 0) {
        NSAssert(NO, @"MKAlertView: buttonTitles count 必须大于 0");
        return  nil;
    }else if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0){
        NSAssert(NO, @"UIDevice system version must more than 8.0");
        return nil;
    }
    UIAlertController *alertController = [self alertControllerWithTitle:title message:message preferredStyle:style];
    alertController.title = title;
    alertController.message = message;
    if (!config) {
        config = [[MKAlertCtrlConfig alloc] init];
    }
    
    [alertController mk_setupUIWith:buttonTitles config:config block:block];
    [alertController.view setNeedsLayout];
    [alertController.view layoutIfNeeded];
    return alertController;

}



- (void)mk_setupUIWith:(NSArray *)buttons config:(MKAlertCtrlConfig *)config block:(void (^)(NSInteger buttonIndex))block{
    if (buttons && buttons.count > 0 ) {
        for (int i = 0; i < buttons.count; i++) {
            UIAlertActionStyle style = UIAlertActionStyleDefault;
            if (i == config.cancelIndex) {
                style = UIAlertActionStyleCancel;
            }else if (i == config.destructiveIndex){
                style = UIAlertActionStyleDestructive;
            }
            UIAlertAction *action = [UIAlertAction actionWithTitle:buttons[i] style:style handler:^(UIAlertAction * _Nonnull action) {
                if (block) {
                    block(i);
                }
            }];
            [self addAction:action];
        }
    }
    [self mk_setCustomStyleWith:config];
}

- (void)mk_setCustomStyleWith:(MKAlertCtrlConfig *)config{
    
    unsigned int count = 0;
    //runtime
    //message text
    Ivar *property = class_copyIvarList([UIAlertController class], &count);
    for(int k = 0; k < count; k++){
        Ivar ivar = property[k];
        NSString *ivarName = [NSString stringWithCString:ivar_getName(ivar) encoding:NSUTF8StringEncoding];
        NSString *ivarType = [NSString stringWithCString:ivar_getTypeEncoding(ivar) encoding:NSUTF8StringEncoding];
        
        if ([ivarName isEqualToString:@"_attributedTitle"] && [ivarType isEqualToString:@"@\"NSAttributedString\""]){
            if (self.title && self.title.length) {
                NSRange titleRange = NSMakeRange(0, self.title.length);
                NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.title attributes:nil];
                if (config.titleFont) {
                    [attributedString addAttribute:NSFontAttributeName value:config.titleFont range:titleRange];
                }
                if (config.titleColor) {
                    [attributedString addAttribute:NSForegroundColorAttributeName value:config.titleColor range:titleRange];
                }
                
                NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
                paragraphStyle.alignment = config.titleAlignment;//设置对齐方式
                [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:titleRange];
                [self setValue:attributedString forKey:@"attributedTitle"];
            }
        }else if ([ivarName isEqualToString:@"_attributedMessage"] && [ivarType isEqualToString:@"@\"NSAttributedString\""]) {
            if (self.message && self.message.length) {
                NSRange messageRange = NSMakeRange(0, self.message.length);
                NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.message attributes:nil];
                if (config.messageFont) {
                    [attributedString addAttribute:NSFontAttributeName value:config.messageFont range:messageRange];
                }
                if (config.messageColor) {
                    [attributedString addAttribute:NSForegroundColorAttributeName value:config.messageColor range:messageRange];
                }
                
                NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
                paragraphStyle.alignment = config.messageAlignment;//设置对齐方式
                [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:messageRange];
                [self setValue:attributedString forKey:@"attributedMessage"];
            }
        }
    }
    
    //action
    Ivar *ivars = class_copyIvarList([UIAlertAction class], &count);
    for (int i = 0; i < self.actions.count; i++) {
        UIAlertAction *action = self.actions[i];
        for(int j = 0; j < count; j++){
            Ivar ivar = ivars[j];
            NSString *ivarName = [NSString stringWithCString:ivar_getName(ivar) encoding:NSUTF8StringEncoding];
            if ([ivarName isEqualToString:@"_titleTextColor"]) {
                if (i == config.destructiveIndex || action.style == UIAlertActionStyleDestructive) {
                    if (config.destructiveColor) {
                        [action setValue:config.destructiveColor forKey:@"titleTextColor"];
                    }else{
                        [action setValue:[UIColor redColor] forKey:@"titleTextColor"];
                    }
                }else{
                    [action setValue:config.actionColor forKey:@"titleTextColor"];
                }
            }
        }
    }
}

@end





@implementation MKAlertCtrlConfig
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
