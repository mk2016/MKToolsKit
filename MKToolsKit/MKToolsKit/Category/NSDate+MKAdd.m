//
//  NSDate+MKAdd.m
//  MKToolsKit
//
//  Created by xmk on 2016/11/11.
//  Copyright © 2016年 mk. All rights reserved.
//

#import "NSDate+MKAdd.h"

@implementation NSDate (MKAdd)

+ (long long)mk_getCurrentTimeStamp{
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
    long long totalMilliseconds = interval*1000;
    return totalMilliseconds;
}

+ (UInt32)mk_getTimeStamp4Second{
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
    UInt32 totalSeconds = interval;
    return totalSeconds;
}

+ (NSDate *)mk_dataWithTimeStamp:(long long)timeStamp{
    if (timeStamp > 10000000000) {
        timeStamp = timeStamp/1000;
    }
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    return date;
}

/** 获取指定日期00:00:00的时间 */
- (NSDate *)mk_dateForZeroTime{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *dateStr = [formatter stringFromDate:self];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    dateStr = [NSString stringWithFormat:@"%@ 00:00:00", dateStr];
    return [formatter dateFromString:dateStr];
}

- (NSString *)mk_dateToStringWithFormat:(NSString *)format{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSString *dateStr = [dateFormatter stringFromDate:self];
    return dateStr;
}

- (NSString *)mk_dateToStringWithFormatFull{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateStr = [dateFormatter stringFromDate:self];
    return dateStr;
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

@end


