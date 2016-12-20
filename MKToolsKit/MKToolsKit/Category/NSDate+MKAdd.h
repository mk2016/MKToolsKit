//
//  NSDate+MKAdd.h
//  MKToolsKit
//
//  Created by xmk on 2016/11/11.
//  Copyright © 2016年 mk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (MKAdd)

/** 获取时间戳 13 位 */
+ (long long)mk_getCurrentTimeStamp;
/** 获取时间出 秒 10位*/
+ (UInt32)mk_getTimeStamp4Second;
/** 时间戳 转 NSDate */
+ (NSDate *)mk_dataWithTimeStamp:(long long)timeStamp;

/** 获取指定日期00:00:00的时间 */
- (NSDate *)mk_dateForZeroTime;
- (NSString *)mk_dateToStringWithFormat:(NSString *)format;
- (NSString *)mk_dateToStringWithFormatFull;
- (NSString *)mk_dateToUTCFormat;
- (NSDate *)mk_dateWithUTC:(NSString *)utc;
@end


@interface NSString (MKDateAdd)

- (NSDate *)mk_stringToDateWithFormat:(NSString *)format;
- (NSDate *)mk_stringToDateWithFormatFull;
- (NSString *)mk_UTCFormatToFormatFull;

@end
