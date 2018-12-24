//
//  NSDate+MKAdd.m
//  MKToolsKit
//
//  Created by xmk on 2016/11/11.
//  Copyright © 2016年 mk. All rights reserved.
//

#import "NSDate+MKAdd.h"

@implementation NSDate (MKAdd)

/** 获取当前时间戳 微秒 13位*/
+ (long long)mk_getCurrentTimeStamp{
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
    long long totalMilliseconds = interval*1000;
    return totalMilliseconds;
}

/** NSDate -> 时间戳毫秒 */
- (long long)mk_dateToMillisecond{
    NSTimeInterval interval = [self timeIntervalSince1970];
    long long milliseconds = interval*1000;
    return milliseconds;
}

/** NSDate -> 微妙 */
- (long long)mk_dateToMicrosecond{
    NSTimeInterval interval = [self timeIntervalSince1970];
    long long t = interval*1000*1000;
    return t;
}

/** 获取当前时间戳 秒 10位 */
+ (UInt32)mk_getTimeStamp4Second{
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
    UInt32 totalSeconds = interval;
    return totalSeconds;
}

/** 时间戳-> NSDate */
+ (NSDate *)mk_dataWithTimeStamp:(long long)timeStamp{
    if (timeStamp > 10000000000) {
        timeStamp = timeStamp/1000;
    }
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    return date;
}


/** 获取当前时间 */
+ (NSString *)mk_getNowDateStringWithFormat:(NSString *)format{
    NSDate *data = [NSDate date];
    NSString *dataStr = [data mk_dateToStringWithFormat:format];
    return dataStr;
}

/** 时间戳 -> 全格式String */
+ (NSString *)mk_formatFullWithTimeStamp:(long long)timeStamp{
    NSDate *date = [NSDate mk_dataWithTimeStamp:timeStamp];
    NSString *str = [date mk_dateToStringWithFormatFull];
    return str;
}

/** UTC -> NSDate */
+ (NSDate *)mk_dateWithUTC:(NSString *)utc{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];//2017-01-11T07:42:47.000Z
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    NSDate *date = [dateFormatter dateFromString:utc];
    return date;
}




/** 获取指定日期00:00:00的时间 NSDate*/
- (NSDate *)mk_dateForZeroTime{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *dateStr = [formatter stringFromDate:self];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    dateStr = [NSString stringWithFormat:@"%@ 00:00:00", dateStr];
    return [formatter dateFromString:dateStr];
}

/** NSDate -> 指定 format */
- (NSString *)mk_dateToStringWithFormat:(NSString *)format{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    NSString *dateStr = [dateFormatter stringFromDate:self];
    return dateStr;
}

/** NSDate -> yyyy-MM-dd HH:mm:ss */
- (NSString *)mk_dateToStringWithFormatFull{
    return [self mk_dateToStringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
}

/** NSDate -> yyyy-MM-dd */
- (NSString *)mk_dateToStringWithFormatDate{
    return [self mk_dateToStringWithFormat:@"yyyy-MM-dd"];
}

/** NSDate -> UTC */
- (NSString *)mk_dateToUTCFormat{
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    NSString *dateString = [dateFormatter stringFromDate:self];
    return dateString;
}

@end

@implementation NSString (MKDateAdd)

- (NSDate *)mk_stringToDateWithFormat:(NSString *)format{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSDate *date = [dateFormatter dateFromString:self];
    return date;
}

- (NSDate *)mk_stringToDateWithFormatFull{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:self];
    return date;
}

- (NSString *)mk_UTCFormatToFormatFull{
    NSDate *date = [NSDate mk_dateWithUTC:self];
    return [date mk_dateToStringWithFormat:@"yyyy-MM-dd HH:mm:ss"];

}

- (NSString *)mk_UTCFormatToFormatDate{
    NSDate *date = [NSDate mk_dateWithUTC:self];
    return [date mk_dateToStringWithFormat:@"yyyy-MM-dd"];
}

- (NSString *)mk_UTCFormatToFormat:(NSString *)format{
    NSDate *date = [NSDate mk_dateWithUTC:self];
    return [date mk_dateToStringWithFormat:format];
}

+ (NSString *)mk_stringByTimeStamp:(long long)ts{
    ts = llabs(ts);
    if (ts > 10000000000) {
        ts = ts/1000;
    }
    int day = (int)(ts/(60*60*24));
    ts = ts%(60*60*24);
    int hour = (int)(ts/3600);
    ts = ts%3600;
    int min = (int)(ts/60);
    NSString *str = @"";
    if (day > 0) {
        str = [str stringByAppendingString:[NSString stringWithFormat:@"%d天",day]];
    }
    if (str.length > 0 || hour > 0) {
        str = [str stringByAppendingString:[NSString stringWithFormat:@"%d时",hour]];
    }
    if (str.length > 0 || min > 0) {
        str = [str stringByAppendingString:[NSString stringWithFormat:@"%d分",min]];
    }
    return str;
}
@end


