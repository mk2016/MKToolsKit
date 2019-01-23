//
//  MKUITools.m
//  MKToolsKit
//
//  Created by xmk on 16/9/23.
//  Copyright © 2016年 mk. All rights reserved.
//

#import "MKUITools.h"
#import <MessageUI/MessageUI.h>
#import "UIView+Toast.h"

@implementation MKUITools

+ (BOOL)checkProxySetting{
    NSDictionary *proxySettings = (__bridge NSDictionary *)(CFNetworkCopySystemProxySettings());
    NSArray *proxies = (__bridge NSArray *)(CFNetworkCopyProxiesForURL((__bridge CFURLRef _Nonnull)([NSURL URLWithString:@"https://www.baidu.com"]), (__bridge CFDictionaryRef _Nonnull)(proxySettings)));
    
    NSDictionary *settings = proxies[0];
    NSLog(@"%@",[settings objectForKey:(NSString *)kCFProxyHostNameKey]);
    NSLog(@"%@",[settings objectForKey:(NSString *)kCFProxyPortNumberKey]);
    NSLog(@"%@",[settings objectForKey:(NSString *)kCFProxyTypeKey]);
    if ([[settings objectForKey:(NSString *)kCFProxyTypeKey] isEqualToString:@"kCFProxyTypeNone"]){
        NSLog(@"没设置代理");
        return NO;
    }else{
        NSLog(@"设置了代理");
        return YES;
    }
}

+ (id)getVCFromStoryboard:(NSString *)storyboard identify:(NSString *)identify{
    return [[UIStoryboard storyboardWithName:storyboard bundle:nil] instantiateViewControllerWithIdentifier:identify];
}


+ (void)delayTask:(float)time onTimeEnd:(void(^)(void))block{
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), block);
}

+ (void)showToast:(NSString *)message{
    if ([message isEqual:[NSNull null]]){
        return;
    }
    if (message == nil || message.length == 0){
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [[self getCurrentWindow] makeToast:message];
    });
}

#pragma mark - ***** top View ******
+ (UIView *)getTopView{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    NSArray *views = [window subviews];
    if (views && views.count > 0) {
        UIView *view = views.lastObject;
        return view;
    }
    return window;
}

#pragma mark - ***** top window *****
+ (UIWindow *)getCurrentWindow{
    return [self getCurrentWindowByLevel:UIWindowLevelNormal];
}

+ (UIWindow *)getCurrentWindowByLevel:(CGFloat)windowLevel{
    UIWindow *topWindow = [[UIApplication sharedApplication] keyWindow];
    if (topWindow.windowLevel != windowLevel) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for (UIWindow *window in windows) {
            if (window.windowLevel == windowLevel) {
                topWindow = window;
            }
        }
    }
    return topWindow;
}

#pragma mark - ***** current ViewController ******
+ (UIViewController *)topViewController{
    return [self topViewControllerWith:nil];
}

+ (UIViewController *)topViewControllerByWindowLevel:(CGFloat)level{
    UIWindow *window = [self getCurrentWindowByLevel:level];
    return [self topViewControllerWith:window.rootViewController];
}

+ (UIViewController *)topViewControllerWith:(UIViewController *)base{
    if (base == nil) {
        base = [UIApplication sharedApplication].keyWindow.rootViewController;
    }
    if ([base isKindOfClass:[UINavigationController class]]) {
        UIViewController *vc = ((UINavigationController *)base).topViewController;
        return [self topViewControllerWith:vc];
    }
    if ([base isKindOfClass:[UITabBarController class]]) {
        UIViewController *vc = ((UITabBarController *)base).selectedViewController;
        return [self topViewControllerWith:vc];
    }
    if (base.presentedViewController) {
        UIViewController *vc = base.presentedViewController;
        if ([vc isKindOfClass:[UIAlertController class]]
            || [vc isKindOfClass:[UIImagePickerController class]]
            || [vc isKindOfClass:[MFMessageComposeViewController class]]
            ) {
            return base;
        }
        return [self topViewControllerWith:vc];
    }
    return base;
}



+ (void)callTelephone:(NSString *)phone{
//    NSMutableString *str= [[NSMutableString alloc] initWithFormat:@"tel:%@",phone];
//    UIWebView *callWebview = [[UIWebView alloc] init];
//    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
//    [self.view addSubview:callWebview];
    NSString *str = [NSString stringWithFormat:@"telprompt://%@", phone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}



/**
 *  传入模型数组，根据key字段 获取 字母 首拼音
 *  @param array model array
 *  @return 排序好的 字母数组
 */
//传入数组，根据 key 字段 获取字母 首拼音， 返回排序好的字母数组
+ (NSArray *)getNoRepeatSortLetterArray:(NSArray *)array letterKey:(NSString *)letterKey{
    // 获取字母数组
    NSArray *tempArray = [array valueForKey:letterKey];

    // 去重 转换为大写
    NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] init];
    for (NSString *letter in tempArray) {
        if (letter && ![letter isEqual:[NSNull null]]) {
            [tempDic setObject:letter.uppercaseString forKey:letter.uppercaseString];
        }
    }
    // 排序
    NSSortDescriptor *desc = [NSSortDescriptor sortDescriptorWithKey:nil ascending:YES];
    NSArray *descArray = [NSArray arrayWithObject:desc];
    NSArray *sortArray = [tempDic.allValues sortedArrayUsingDescriptors:descArray];
    return sortArray;
}

+ (void)exitApplication{
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    [UIView animateWithDuration:1.0f animations:^{
        window.alpha = 0;
        window.frame = CGRectMake(0, window.bounds.size.width, 0, 0);
    } completion:^(BOOL finished) {
        exit(0);
    }];
}

@end
