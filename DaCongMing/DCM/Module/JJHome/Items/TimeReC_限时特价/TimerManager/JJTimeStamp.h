//
//  JJTool.h
//  UnicornTV
//
//  Created by JerodJi on 2017/8/3.
//  Copyright © 2017年 Droi. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 G:      公元时代，例如AD公元
 yy:     年的后2位
 yyyy:   完整年
 MM:     月，显示为1-12,带前置0
 MMM:    月，显示为英文月份简写,如 Jan
 MMMM:   月，显示为英文月份全称，如 Janualy
 dd:     日，2位数表示，如02
 d:      日，1-2位显示，如2，无前置0
 EEE:    简写星期几，如Sun
 EEEE:   全写星期几，如Sunday
 aa:     上下午，AM/PM
 H:      时，24小时制，0-23
 HH:     时，24小时制，带前置0
 h:      时，12小时制，无前置0
 hh:     时，12小时制，带前置0
 m:      分，1-2位
 mm:     分，2位，带前置0
 s:      秒，1-2位
 ss:     秒，2位，带前置0
 S:      毫秒
 Z：     GMT（时区）
 */
//#define DateStyle1  @"yyyy-MM-dd HH:mm"
//#define DateStyle5  @"yyyy-MM-dd HH:mm:ss"
//#define DateStyle0  @"yyyy年MM月dd日 HH:mm"
//#define DateStyle2  @"MM-dd HH:mm"
//#define DateStyle3  @"MM-dd aa h:mm"
//#define DateStyle4  @"aa h:mm"

typedef NS_ENUM(NSInteger,DateStyle) {
    DateStyle_Year_Mounth_Date_HH_mm = 0, /* yyyy年MM月dd日 HH:mm */
    DateStyle_yyyy_MM_dd_HH_mm   ,        /* yyyy-MM-dd HH:mm */
    DateStyle_yyyy_MM_dd_HH_mm_ss,        /* yyyy-MM-dd HH:mm:ss      2018-05-01 00:00:00   */
    DateStyle_yyyy_MM_dd_HH_mm_ss_SSS,    /* yyyy-MM-dd HH:mm:ss.SSS  2018-05-01 00:00:00.0 */
    DateStyle_MM_dd_HH_mm,                /* MM-dd HH:mm */
    DateStyle_MM_dd_aa_h_mm,              /* MM-dd aa h:mm */
    DateStyle_aa_h_mm                     /* aa h:mm */
};

@interface JJTimeStamp : NSObject

/**
 * 根据DateStyle获取格式
 */
+(NSString*)dateFormatWith:(DateStyle)theStyle;

/******************************  时 间 戳  ******************************/

// 时间戳转换 毫秒(13位) -> 秒(10位)
+ (UInt64)timeStampSecondFromMillisecond:(NSInteger)_msTimeStamp;
/**
 秒时间戳
 @param _timeStamp_s 时间戳
 @param _format @"YYYY-MM-dd hh:mm:ss")---设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
 @return 时间string
 */
+ (NSString*)timeWithTimeStamp_s:(NSInteger)_timeStamp_s formatter:(NSString *)_format;
+ (NSString*)timeWithTimeStamp_ms:(NSInteger)_timeStamp_ms formatter:(NSString *)_format;

+ (UInt64)getTimeStamp_s; /* 获取秒时间戳 */
+ (UInt64)getTimeStamp_ms; /* 获取毫秒时间戳 */

/************************  ************************/
/**
 @param time 秒
 @return 天 时:分:秒
 */
+ (NSString*)dd_HH_MM_SS_timeWithSeconds:(long)time;
+ (NSString*)HH_MM_SS_timeWithSeconds:(long)time;

/**
 @param time 毫秒
 @return 时:分:秒:毫秒
 */
+ (NSString*)MM_SS_MS_timeWithMilliSeconds:(long)time;

// 毫秒时间戳 -> 日期 Time stamp
+ (NSString *)dateWithTimestampMS:(NSString *)timeString style:(DateStyle)theStyle;

+ (NSString*)updateTimeForStampMS:(NSString*)stamp;

/******************  ******************/
/**
 * 计算当前时间与某个指定时间的时间差,秒
 */
+ (double)intervalSinceNowWith:(NSString *)theDate style:(DateStyle)theStyle;
//
+ (double)timeStampNow;
//
+ (double)timeStampWithDateStr:(NSString*)theDate style:(DateStyle)theStyle;
//把日期转换成当前时区的日期
+ (NSDate *)convertDateToLocalTime:(NSDate *)forDate;


@end
