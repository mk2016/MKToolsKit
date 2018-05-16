//
//  NSDate+MKAdd.h
//  MKToolsKit
//
//  Created by xmk on 2016/11/11.
//  Copyright © 2016年 mk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (MKAdd)

/** 获取当前时间戳 微秒 13位*/
+ (long long)mk_getCurrentTimeStamp;
- (long long)mk_dateToMillisecond;
- (long long)mk_dateToMicrosecond;

/** 获取当前时间戳 秒 10位 */
+ (UInt32)mk_getTimeStamp4Second;
/** 获取指定日期00:00:00的时间 NSDate*/
- (NSDate *)mk_dateForZeroTime;
/** 时间戳-> NSDate */
+ (NSDate *)mk_dataWithTimeStamp:(long long)timeStamp;
/** 获取当前时间 */
+ (NSString *)mk_getNowDateWithFormat:(NSString *)format;
/** 时间戳 -> 全格式String */
+ (NSString *)mk_FormatFullWithTimeStamp:(long long)timeStamp;
/** NSDate -> 指定 format */
- (NSString *)mk_dateToStringWithFormat:(NSString *)format;
/** NSDate -> 全格式String */
- (NSString *)mk_dateToStringWithFormatFull;
/** NSDate -> UTC */
- (NSString *)mk_dateToUTCFormat;
/** UTC -> NSDate */
- (NSDate *)mk_dateWithUTC:(NSString *)utc;
@end


@interface NSString (MKDateAdd)

- (NSDate *)mk_stringToDateWithFormat:(NSString *)format;
- (NSDate *)mk_stringToDateWithFormatFull;
- (NSString *)mk_UTCFormatToFormatFull;
- (NSString *)mk_UTCFormatToFormatDate;
- (NSString *)mk_UTCFormatToFormat:(NSString *)format;
@end
