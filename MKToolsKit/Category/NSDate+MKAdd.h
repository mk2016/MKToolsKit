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
/** NSDate -> 时间戳毫秒 */
- (long long)mk_dateToMillisecond;
/** NSDate -> 微妙 */
- (long long)mk_dateToMicrosecond;

/** 获取当前时间戳 秒 10位 */
+ (UInt32)mk_getTimeStamp4Second;
/** 时间戳-> NSDate */
+ (NSDate *)mk_dataWithTimeStamp:(long long)timeStamp;
/** 格式化当前时间 */
+ (NSString *)mk_getNowDateStringWithFormat:(NSString *)format;
/** 时间戳 -> 全格式String */
+ (NSString *)mk_formatFullWithTimeStamp:(long long)timeStamp;
/** UTC -> NSDate */
+ (NSDate *)mk_dateWithUTC:(NSString *)utc;

/** 获取指定日期NSDate 的00:00:00的时间 */
- (NSDate *)mk_dateForZeroTime;
/** NSDate -> 指定 format */
- (NSString *)mk_dateToStringWithFormat:(NSString *)format;
/** NSDate -> yyyy-MM-dd HH:mm:ss */
- (NSString *)mk_dateToStringWithFormatFull;
/** NSDate -> yyyy-MM-dd */
- (NSString *)mk_dateToStringWithFormatDate;
/** NSDate -> UTC */
- (NSString *)mk_dateToUTCFormat;

@end


@interface NSString (MKDateAdd)

- (NSDate *)mk_stringToDateWithFormat:(NSString *)format;
- (NSDate *)mk_stringToDateWithFormatFull;
- (NSString *)mk_UTCFormatToFormatFull;
- (NSString *)mk_UTCFormatToFormatDate;
- (NSString *)mk_UTCFormatToFormat:(NSString *)format;
@end
