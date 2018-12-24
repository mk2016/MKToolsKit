//
//  MKUITools.h
//  MKToolsKit
//
//  Created by xmk on 16/9/23.
//  Copyright © 2016年 mk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MKUITools : NSObject

/** 检查是否设置的代理 */
+ (BOOL)checkProxySetting;

+ (id)getVCFromStoryboard:(NSString *)storyboard identify:(NSString *)identify;

+ (void)delayTask:(float)time onTimeEnd:(void(^)(void))block;
+ (void)showToast:(NSString *)message;
#pragma mark - ***** top View ******
+ (UIView *)getTopView;

#pragma mark - ***** top window *****
+ (UIWindow *)getCurrentWindow;
+ (UIWindow *)getCurrentWindowByLevel:(CGFloat)windowLevel;

#pragma mark - ***** current ViewController ******
+ (UIViewController *)topViewController;
+ (UIViewController *)topViewControllerByWindowLevel:(CGFloat)level;
+ (UIViewController *)topViewControllerWith:(UIViewController *)base;

/** 拨打电话 */
+ (void)callTelephone:(NSString *)phone;


/**
 *  传入模型数组，根据key字段 获取 字母 首拼音
 *  @param array model array
 *  @return 排序好的 字母数组
 */
+ (NSArray *)getNoRepeatSortLetterArray:(NSArray *)array letterKey:(NSString *)letterKey;

+ (void)exitApplication;
@end
