//
//  NSString+MKAdd.m
//  MKToolsKit
//
//  Created by xiaomk on 16/9/9.
//  Copyright © 2016年 xiaomk. All rights reserved.
//

#import "NSString+MKAdd.h"
#import "UIImage+MKAdd.h"

@implementation NSString(MKAdd)

- (id)mk_jsonString2Dictionary{
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if (error) {
        NSLog(@"json解析失败:%@",error);
        return nil;
    }
    return dic;
}

- (NSDictionary *)mk_dictionaryWithJsonString{
    if (self.length == 0) {
        return nil;
    }
    return [self mk_jsonString2Dictionary];
}


#pragma mark - ***** 字符串校验 *****
/** 是否包含汉字 */
- (BOOL)mk_isIncludeChinese{
    for(int i = 0; i < [self length]; i++){
        unichar a = [self characterAtIndex:i];
        if ([self isChinese:a]) {
            return YES;
        }
    }
    return NO;
}

/** 全部汉字检查 */
- (BOOL)mk_isChineseString{
    for (int i = 0; i < [self length]; i++) {
        unichar a = [self characterAtIndex:i];
        if (![self isChinese:a]) {
            return NO;
        }
    }
    return YES;
}

/** 是否是汉字 */
- (BOOL)isChinese:(unichar)word{
    if( word >= 0x4e00 && word <= 0x9fff){
        return YES;
    }
    return NO;
}

/** 邮箱校验 */
- (BOOL)mk_validateEmail{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

/** 身份证校验 */
- (BOOL)mk_validateIdentityCard{
    BOOL flag;
    if (self.length <= 0) {
        flag = NO;
        return flag;
    }
    //    NSString *regex = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSString *regex = @"(\\d{15}$)|(\\d{17}([0-9]|[xX])$)";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [identityCardPredicate evaluateWithObject:self];
}

#pragma mark - ***** 汉字 转 拼音 ******
/** 获取中文名首个拼音字母 */
- (NSString *)mk_getChineseNameFirstLetter{
    NSString *str = [self mk_chineseNameToPinyin];
    if (str && str.length > 0) {
        [str substringToIndex:1];
    }
    return str;
}

/** 中文名转拼音 */
- (NSString *)mk_chineseNameToPinyin{
    return [self mk_hanziToPinyinIsChineseName:YES];
}

/** 汉字转拼音 */
- (NSString *)mk_hanziToPinyinIsChineseName:(BOOL)isName{
    if (self.length == 0) {
        return self;
    }
    NSMutableString *ms = [[NSMutableString alloc] initWithString:self];
    CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformMandarinLatin, NO);     //转拼音
    CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformStripDiacritics, NO);   //去声调
    if (isName) {   //如果是名字，处理姓氏多音字
        if ([[(NSString *)self substringToIndex:1] compare:@"长"] == NSOrderedSame) {
            [ms replaceCharactersInRange:NSMakeRange(0, 5) withString:@"chang"];
        }
        if ([[(NSString *)self substringToIndex:1] compare:@"沈"] == NSOrderedSame){
            [ms replaceCharactersInRange:NSMakeRange(0, 4)withString:@"shen"];
        }
        if ([[(NSString *)self substringToIndex:1] compare:@"厦"] == NSOrderedSame){
            [ms replaceCharactersInRange:NSMakeRange(0, 3)withString:@"xia"];
        }
        if ([[(NSString *)self substringToIndex:1] compare:@"地"] == NSOrderedSame){
            [ms replaceCharactersInRange:NSMakeRange(0, 2)withString:@"di"];
        }
        if ([[(NSString *)self substringToIndex:1] compare:@"重"] == NSOrderedSame){
            [ms replaceCharactersInRange:NSMakeRange(0, 5) withString:@"chong"];
        }
    }
    return ms;
}

#pragma mark - ***** URL Encode Decode *****
/** 对字符串进行URLEncode */
- (NSString *)mk_stringByURLEncode{
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)self,
                                                              NULL,
                                                              (CFStringRef)@"!$&'()*+,-./:;=?@_%#[]",
                                                              kCFStringEncodingUTF8));
    return encodedString;
}

/** 对字符串进行URLDecode */
- (NSString *)mk_stringByURLDecode{
    if ([self respondsToSelector:@selector(stringByRemovingPercentEncoding)]) {
        return [self stringByRemovingPercentEncoding];
    } else {
        NSString *decoded = (__bridge_transfer NSString *)
        CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                (__bridge CFStringRef)self,
                                                                CFSTR(""),
                                                                CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
        return decoded;
    }
}

/** 获取字符串的size */
- (CGSize)mk_getContentSizeWithFont:(UIFont *)font width:(CGFloat)width{
    CGSize size = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                          options:NSStringDrawingUsesLineFragmentOrigin
//  | NSStringDrawingTruncatesLastVisibleLine
//  | NSStringDrawingUsesFontLeading
                                       attributes:@{NSFontAttributeName: font}
                                          context:nil].size;
    return size;
}

@end
