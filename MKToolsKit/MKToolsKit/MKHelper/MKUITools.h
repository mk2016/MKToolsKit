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

+ (id)getVCFromStoryboard:(NSString *)storyboard identify:(NSString *)identify;

#pragma mark - ***** top View ******
+ (UIView *)getTopView;

#pragma mark - ***** current ViewController ******
+ (UIViewController *)getCurrentViewController;
+ (UIViewController *)getCurrentViewControllerIsIncludePresentedVC:(BOOL)isIncludePVC;
+ (UIViewController *)getCurrentViewControllerWithWindowLevel:(CGFloat)windowLevel includePresentedVC:(BOOL)isIncludePVC;
+ (UIViewController *)getPresentedViewController;

+ (void)callTelephone:(NSString *)phone showAlert:(BOOL)showAlert;


/**
 *  传入模型数组，根据key字段 获取 字母 首拼音
 *
 *  @param array model array
 *
 *  @return 排序好的 字母数组
 */
+ (NSArray *)getNoRepeatSortLetterArray:(NSArray *)array letterKey:(NSString *)letterKey;

+ (NSString *)getChineseNameFirstPinyinWithName:(NSString *)name;
+ (NSString *)hanziToPinyinWith:(NSString *)hanziStr isChineseName:(BOOL)isChineseName;
@end
