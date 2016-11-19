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

- (NSDictionary *)mk_jsonString2Dictionary{
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
    return [self mk_jsonString2Dictionary];
}

/** 是否包含汉字 */
- (BOOL)isIncludeChinese{
    for(int i = 0; i < [self length]; i++){
        unichar a = [self characterAtIndex:i];
        if ([self isChinese:a]) {
            return YES;
        }
    }
    return NO;
}

/** 全部汉字检查 */
- (BOOL)isChineseString{
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
- (BOOL)validateEmail{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

/** 身份证校验 */
- (BOOL)validateIdentityCard{
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


/** 对字符串进行URLEncode */
- (NSString *)mk_stringByURLEncode{
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)self,
                                                              NULL,
                                                              (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
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

@end
