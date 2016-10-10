//
//  NSString+MKAdd.h
//  MKDevelopSolutions
//
//  Created by xiaomk on 16/9/9.
//  Copyright © 2016年 xiaomk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(MKExtension)

/** 是否包含汉字 */
- (BOOL)isIncludeChinese;
/** 是否全部为汉字 */
- (BOOL)isChineseString;


/** 邮箱格式检查 */
- (BOOL)validateEmail;

/** 简单身份证校验 */
- (BOOL)validateIdentityCard;

- (NSString *)urlEncode:(NSStringEncoding)encoding;
@end
