//
//  NSString+MKAdd.h
//  MKToolsKit
//
//  Created by xiaomk on 16/9/9.
//  Copyright © 2016年 xiaomk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString(MKAdd)

#pragma mark - ***** 字符串校验 *****
/** 是否包含汉字 */
- (BOOL)mk_isIncludeChinese;
/** 是否全部为汉字 */
- (BOOL)mk_isChineseString;

/** 邮箱格式检查 */
- (BOOL)mk_validateEmail;

/** 简单身份证校验 */
- (BOOL)mk_validateIdentityCard;

#pragma mark - ***** 汉字 转 拼音 ******
/** 获取中文名首个拼音字母 */
- (NSString *)mk_getChineseNameFirstLetter;

/** 中文名转拼音 */
- (NSString *)mk_chineseNameToPinyin;

/** 汉字转拼音 */
- (NSString *)mk_hanziToPinyinIsChineseName:(BOOL)isName;
    
#pragma mark - ***** URL Encode Decode *****
/** 对字符串进行URLEncode */
- (NSString *)mk_stringByURLEncode;

/** 对字符串进行URLDecode */
- (NSString *)mk_stringByURLDecode;

/** 获取字符串的 Size */
- (CGSize)mk_getContentSizeWithFont:(UIFont *)font width:(CGFloat)width;

@end

