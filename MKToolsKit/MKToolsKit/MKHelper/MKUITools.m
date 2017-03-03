//
//  MKUITools.m
//  MKToolsKit
//
//  Created by xmk on 16/9/23.
//  Copyright © 2016年 mk. All rights reserved.
//

#import "MKUITools.h"
#import <MessageUI/MessageUI.h>

@implementation MKUITools

+ (id)getVCFromStoryboard:(NSString *)storyboard identify:(NSString *)identify{
    return [[UIStoryboard storyboardWithName:storyboard bundle:nil] instantiateViewControllerWithIdentifier:identify];
}

#pragma mark - ***** top View ******
+ (UIView *)getTopView{
    return [[[[UIApplication sharedApplication] keyWindow] subviews] lastObject];
}

#pragma mark - ***** current ViewController ******
/** default include presentedViewController */
+ (UIViewController *)getCurrentViewController{
    return [self getCurrentViewControllerWithWindowLevel:UIWindowLevelNormal includePresentedVC:YES];
}

+ (UIViewController *)getCurrentViewControllerIsIncludePresentedVC:(BOOL)isIncludePVC{
    return [self getCurrentViewControllerWithWindowLevel:UIWindowLevelNormal includePresentedVC:isIncludePVC];
}

+ (UIViewController *)getCurrentViewControllerWithWindowLevel:(CGFloat)windowLevel includePresentedVC:(BOOL)isIncludePVC{
    UIViewController *result = nil;
    
    if (isIncludePVC) {
        result = [self getPresentedViewController];
        if (result) {
            return result;
        }
    }
    
    UIWindow *topWindow = [[UIApplication sharedApplication] keyWindow];
    if (topWindow.windowLevel != windowLevel) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for (UIWindow *window in windows) {
            if (window.windowLevel == windowLevel) {
                topWindow = window;
            }
        }
    }
    
    UIView *rootView;
    NSArray *subViews = [topWindow subviews];
    if (subViews.count) {
        rootView = [subViews objectAtIndex:0];
    }else{
        rootView = topWindow;
    }
    
    id nextResponder = [rootView nextResponder];
    //    UIWindow* nextResWindow;
    //    if ([nextResponder isKindOfClass:[UIWindow class]]) {
    //        nextResWindow = (UIWindow*)nextResponder;
    //    }
    
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        result = nextResponder;
        //    }else if (nextResWindow != nil && [nextResponder respondsToSelector:@selector(rootViewController)] && nextResWindow.rootViewController != nil){
        //        result = nextResWindow.rootViewController;
    }else if ([topWindow respondsToSelector:@selector(rootViewController)] && topWindow.rootViewController != nil){
        result = topWindow.rootViewController;
    }else{
        NSAssert(NO, @"MKToolsKit: Could not find a root view controller.");
    }
    if ([result isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabbarVC = (UITabBarController *)result;
        result = tabbarVC.viewControllers[[tabbarVC selectedIndex]];
    }
    if ([result isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)result;
        result = nav.topViewController;
    }
    return result;
}

+ (UIViewController *)getPresentedViewController{
    UIWindow *topWindow = [[UIApplication sharedApplication] keyWindow];
    UIViewController *appRootVC = topWindow.rootViewController;
    UIViewController *topVC = nil;
    if (appRootVC.presentedViewController) {
        if (![appRootVC.presentedViewController isKindOfClass:[UIAlertController class]] &&
            ![appRootVC.presentedViewController isKindOfClass:[UIImagePickerController class]] &&
            ![appRootVC.presentedViewController isKindOfClass:[MFMessageComposeViewController class]]){
            topVC = appRootVC.presentedViewController;
            
            if (topVC && [topVC isKindOfClass:[UINavigationController class]]) {
                UINavigationController *nav = (UINavigationController *)topVC;
                topVC = nav.topViewController;
            }
        }
    }
    return topVC;
}

+ (void)callTelephone:(NSString *)phone showAlert:(BOOL)showAlert{
    NSString *cmd = showAlert ? @"telprompt" : @"tel";
    NSString *str = [NSString stringWithFormat:@"%@://%@", cmd, phone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

/**
 *  传入模型数组，根据key字段 获取 字母 首拼音
 *
 *  @param NSArray model array
 *
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

+ (NSString *)getChineseNameFirstPinyinWithName:(NSString*)name{
    return [[self hanziToPinyinWith:name isChineseName:YES] substringToIndex:1];
}

+ (NSString*)hanziToPinyinWith:(NSString *)hanziStr isChineseName:(BOOL)isChineseName{
    if (hanziStr.length == 0) {
        return hanziStr;
    }
    
    NSMutableString* ms = [[NSMutableString alloc] initWithString:hanziStr];
    CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformMandarinLatin, NO);     //转拼音
    CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformStripDiacritics, NO);   //去声调
    if (isChineseName) {
        if ([[(NSString*)hanziStr substringToIndex:1] compare:@"长"] == NSOrderedSame) {
            [ms replaceCharactersInRange:NSMakeRange(0, 5) withString:@"chang"];
        }
        if ([[(NSString *)hanziStr substringToIndex:1] compare:@"沈"] == NSOrderedSame){
            [ms replaceCharactersInRange:NSMakeRange(0, 4)withString:@"shen"];
        }
        if ([[(NSString *)hanziStr substringToIndex:1] compare:@"厦"] == NSOrderedSame){
            [ms replaceCharactersInRange:NSMakeRange(0, 3)withString:@"xia"];
        }
        if ([[(NSString *)hanziStr substringToIndex:1] compare:@"地"] == NSOrderedSame){
            [ms replaceCharactersInRange:NSMakeRange(0, 2)withString:@"di"];
        }
        if ([[(NSString *)hanziStr substringToIndex:1] compare:@"重"] == NSOrderedSame){
            [ms replaceCharactersInRange:NSMakeRange(0, 5) withString:@"chong"];
        }
    }
    
    return ms;
}

@end
