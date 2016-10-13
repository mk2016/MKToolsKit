//
//  MKAlertView.m
//  MKDevelopSolutions
//
//  Created by xiaomk on 16/5/16.
//  Copyright © 2016年 xiaomk. All rights reserved.
//

#import "MKAlertView.h"
#import "MKUITools.h"
#import "UIAlertView+MKAdd.h"


#pragma mark - ***** MKAlertView ******

@implementation MKAlertView

+ (void)alertWithTitle:(NSString *)title
               message:(NSString *)message
     cancelButtonTitle:(NSString *)cancelButtonTitle
    confirmButtonTitle:(NSString *)confirmButtonTitle
                 block:(void (^)(NSInteger buttonIndex))block{
    [self alertWithTitle:title message:message cancelButtonTitle:cancelButtonTitle confirmButtonTitle:confirmButtonTitle viewController:nil block:block];
}

+ (void)alertWithTitle:(NSString *)title
               message:(NSString *)message
          buttonTitles:(NSArray *)buttonTitles
                 block:(void (^)(NSInteger buttonIndex))block{
    [self alertWithTitle:title message:message buttonTitles:buttonTitles onViewController:nil block:block];
}




+ (void)alertWithTitle:(NSString *)title message:(NSString *)message onViewController:(UIViewController *)vc block:(void (^)(NSInteger buttonIndex))block buttonTitles:(NSString *)cancelTitle, ... NS_REQUIRES_NIL_TERMINATION{
    
    NSMutableArray* argsArray = [[NSMutableArray alloc] initWithCapacity:2];
    
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

+ (void)alertWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle confirmButtonTitle:(NSString *)confirmButtonTitle viewController:(UIViewController *)vc block:(void (^)(NSInteger buttonIndex))block{
    
    NSMutableArray* argsArray = [[NSMutableArray alloc] initWithCapacity:2];
    if (cancelButtonTitle) {
        [argsArray addObject:cancelButtonTitle];
    }
    if (confirmButtonTitle) {
        [argsArray addObject:confirmButtonTitle];
    }
    [self alertWithTitle:title message:message buttonTitles:argsArray onViewController:vc block:block];
}

+ (void)alertWithTitle:(NSString *)title message:(NSString *)message buttonTitles:(NSArray *)buttonTitles onViewController:(UIViewController *)vc block:(void (^)(NSInteger buttonIndex))block{
    
    if (!buttonTitles || buttonTitles.count == 0) {
        NSAssert(NO, @"MKAlertView: buttonTitles count 必须大于 0");
        return;
    }
    
    NSMutableArray *argsArray = [[NSMutableArray alloc] initWithArray:buttonTitles];

    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        
        UIAlertController* alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        
        for (int i = 0; i < [argsArray count]; i++) {
            UIAlertActionStyle style = (i == 0) ? UIAlertActionStyleCancel : UIAlertActionStyleDefault;
            UIAlertAction *action = [UIAlertAction actionWithTitle:[argsArray objectAtIndex:i] style:style handler:^(UIAlertAction * _Nonnull action) {
                if (block) {
                    block(i);
                }
            }];
            [alertController addAction:action];
        }
        
        UIViewController *curVC;
        if (vc) {
            curVC = vc;
        }else{
            curVC = [MKUITools getCurrentViewController];
        }
        [curVC presentViewController:alertController animated:YES completion:nil];
        return;
    }
    
    //UIAlertView style
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:argsArray.firstObject otherButtonTitles:nil, nil];
    
    [argsArray removeObjectAtIndex:0];
    
    for (NSString *buttonTitle in argsArray) {
        [alertView addButtonWithTitle:buttonTitle];
    }
    [alertView showWithBlock:^(NSInteger buttonIndex) {
        if (block) {
            block(buttonIndex);
        }
    }];
}



@end
