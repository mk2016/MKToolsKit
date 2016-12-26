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

/** jsonString 转 dictionary 或者 NSArray */
- (id)mk_jsonString2Dictionary;
- (NSDictionary *)mk_dictionaryWithJsonString;

#pragma mark - ***** 字符串校验 *****
/** 是否包含汉字 */
- (BOOL)isIncludeChinese;
/** 是否全部为汉字 */
- (BOOL)isChineseString;


/** 邮箱格式检查 */
- (BOOL)validateEmail;

/** 简单身份证校验 */
- (BOOL)validateIdentityCard;

#pragma mark - ***** URL Encode Decode *****
/** 对字符串进行URLEncode */
- (NSString *)mk_stringByURLEncode;

/** 对字符串进行URLDecode */
- (NSString *)mk_stringByURLDecode;

/** 获取字符串的 Size */
- (CGSize)mk_getContentSizeWithFont:(UIFont *)font width:(CGFloat)width;

@end

