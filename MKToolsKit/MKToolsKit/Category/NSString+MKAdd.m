//
//  NSString+MKAdd.m
//  MKDevelopSolutions
//
//  Created by xiaomk on 16/9/9.
//  Copyright © 2016年 xiaomk. All rights reserved.
//

#import "NSString+MKAdd.h"

@implementation NSString(MKExtension)

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


/**
 * 对字符串进行URL编码转换。
 */
- (NSString *)urlEncode:(NSStringEncoding)encoding {
//    NSMutableString *escaped = [NSMutableString string];
//    [escaped setString:[self stringByAddingPercentEscapesUsingEncoding:encoding]];
//    
//    [escaped replaceOccurrencesOfString:@"&" withString:@"%26" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [escaped length])];
//    [escaped replaceOccurrencesOfString:@"+" withString:@"%2B" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [escaped length])];
//    [escaped replaceOccurrencesOfString:@"," withString:@"%2C" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [escaped length])];
//    [escaped replaceOccurrencesOfString:@"/" withString:@"%2F" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [escaped length])];
//    [escaped replaceOccurrencesOfString:@":" withString:@"%3A" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [escaped length])];
//    [escaped replaceOccurrencesOfString:@";" withString:@"%3B" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [escaped length])];
//    [escaped replaceOccurrencesOfString:@"=" withString:@"%3D" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [escaped length])];
//    [escaped replaceOccurrencesOfString:@"?" withString:@"%3F" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [escaped length])];
//    [escaped replaceOccurrencesOfString:@"@" withString:@"%40" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [escaped length])];
//    [escaped replaceOccurrencesOfString:@" " withString:@"+" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [escaped length])];
//    [escaped replaceOccurrencesOfString:@"\t" withString:@"%09" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [escaped length])];
//    [escaped replaceOccurrencesOfString:@"#" withString:@"%23" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [escaped length])];
//    [escaped replaceOccurrencesOfString:@"<" withString:@"%3C" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [escaped length])];
//    [escaped replaceOccurrencesOfString:@">" withString:@"%3E" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [escaped length])];
//    [escaped replaceOccurrencesOfString:@"\"" withString:@"%22" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [escaped length])];
//    [escaped replaceOccurrencesOfString:@"\n" withString:@"%0A" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [escaped length])];
//    
//    return escaped;
    
    
    
    NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                                    (CFStringRef)self,
                                                                                                    NULL,
                                                                                                    (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                                    kCFStringEncodingUTF8));
    
    if (encodedString) {
        return encodedString;
    }
    return @"";
}



@end
