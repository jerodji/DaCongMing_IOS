//
//  JJTool.m
//  UnicornTV
//
//  Created by JerodJi on 2017/8/3.
//  Copyright © 2017年 Droi. All rights reserved.
//

#import "JJTimeStamp.h"

@implementation JJTimeStamp

+(NSString*)dateFormatWith:(DateStyle)theStyle {
    switch (theStyle) {
        case DateStyle_Year_Mounth_Date_HH_mm:
            return @"yyyy年MM月dd日 HH:mm";
            break;
        case DateStyle_yyyy_MM_dd_HH_mm:
            return @"yyyy-MM-dd HH:mm";
            break;
        case DateStyle_yyyy_MM_dd_HH_mm_ss:
            return @"yyyy-MM-dd HH:mm:ss";
        case DateStyle_yyyy_MM_dd_HH_mm_ss_SSS:
            return @"yyyy-MM-dd HH:mm:ss.SSS"; /* 2018-01-24 00:00:00.0  .SSS->毫秒 */
            break;
        case DateStyle_MM_dd_HH_mm:
            return @"MM-dd HH:mm";
            break;
        case DateStyle_MM_dd_aa_h_mm:
            return @"MM-dd aa h:mm";
            break;
        case DateStyle_aa_h_mm:
            return @"aa h:mm";
            break;
            
        default:
            return @"yyyy-MM-dd HH:mm";
            break;
    }
    return @"yyyy-MM-dd HH:mm";
}

//时间戳转换 毫秒(13位)->秒(10位)
+ (UInt64)timeStampSecondFromMillisecond:(NSInteger)_msTimeStamp
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_msTimeStamp / 1000];
    UInt64 ts_s = [date timeIntervalSince1970] * 1000;
    return ts_s;
}

//秒时间戳 -> 时间
+(NSString*)timeWithTimeStamp_s:(NSInteger)_timeStamp_s formatter:(NSString *)_format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:_format]; //（@"YYYY-MM-dd hh:mm:ss")---设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];//设置时区
    [formatter setTimeZone:timeZone];
    
    NSDate *tsDate = [NSDate dateWithTimeIntervalSince1970:_timeStamp_s];
    NSString *timeStr = [formatter stringFromDate:tsDate];
    
    return timeStr;
}

//毫秒时间戳 -> 时间
+(NSString*)timeWithTimeStamp_ms:(NSInteger)_timeStamp_ms formatter:(NSString *)_format
{
    UInt64 tss = [JJTimeStamp timeStampSecondFromMillisecond:_timeStamp_ms];
    NSString * string = [JJTimeStamp timeWithTimeStamp_s:tss formatter:_format];
    return string;
}

//获取时间戳 秒
+ (UInt64)getTimeStamp_s
{
    UInt64 recordTime = [[NSDate date] timeIntervalSince1970];
    return recordTime;
}
//获取时间戳 毫秒
+ (UInt64)getTimeStamp_ms
{
    return [JJTimeStamp getTimeStamp_s]*1000;
}

+ (NSString*)dd_HH_MM_SS_timeWithSeconds:(long)time {
    return [self HH_MM_SS_timeWithSeconds:time];
}
/**
 @param time 秒
 @return 时:分:秒
 */
+ (NSString*)HH_MM_SS_timeWithSeconds:(long)time
{
    long days    = time / 86400;
    long hours   = time % 86400 /3600;//time / 3600;
    long minutes = time % 86400 % 3600 / 60; //(time / 60) % 60;
    long seconds = time % 86400 % 3600 % 60; //time % 60
    
    NSString* ss = @"00";
    NSString* mm = @"00";
    NSString* hh = @"00";
    NSString* dd = @"";
    
    if (seconds/10 < 1) {
        ss = [NSString stringWithFormat:@"0%ld",seconds];
    } else {
        ss = [NSString stringWithFormat:@"%ld",seconds];
    }
    
    if (minutes/10 < 1) {
        mm = [NSString stringWithFormat:@"0%ld",minutes];
    } else {
        mm = [NSString stringWithFormat:@"%ld",minutes];
    }
    
    if (hours/10 < 1) {
        hh = [NSString stringWithFormat:@"0%ld",hours];
    } else {
        hh = [NSString stringWithFormat:@"%ld",hours];
    }
    
    if ( days >= 1 ) {
        dd = [NSString stringWithFormat:@"%ld",days];
    } else {
        dd = @"";
    }
    
    
    NSString * tim = @"";
    if (![dd isEqualToString:@""]) {
        tim = [NSString stringWithFormat:@"%@天 %@:%@:%@",dd,hh,mm,ss];
    } else
    if (![hh isEqualToString:@"00"]) {
        tim = [NSString stringWithFormat:@"%@:%@:%@",hh, mm, ss];
    } else if (![mm isEqualToString:@"00"]) {
        tim = [NSString stringWithFormat:@"%@:%@", mm, ss];
    } else if (![ss isEqualToString:@"00"]) {
        tim = [NSString stringWithFormat:@"%@", ss];
    } else {
        tim = @"0";
    }
    return tim;
}

/**
 @param time 毫秒
 @return 时:分:秒:毫秒
 */
+ (NSString*)MM_SS_MS_timeWithMilliSeconds:(long)time
{
    long hours   = (time/1000) / 3600;//1小时3600秒
    long minutes = ((time/1000) / 60) % 60; //（ time/60秒 ）% 60分钟
    long seconds = (time/1000) % 60; // time % 60秒
    long step = 10;
    long millisecond = (time % 1000) / step; //(毫秒) 10毫秒为一个单位
    
    NSString* hh = @"00";
    NSString* mm = @"00";
    NSString* ss = @"00";
    NSString* ms = @"00";
    
    if (seconds/10 < 1) {
        ss = [NSString stringWithFormat:@"0%ld",seconds];
    } else {
        ss = [NSString stringWithFormat:@"%ld",seconds];
    }
    
    if (minutes/10 < 1) {
        mm = [NSString stringWithFormat:@"0%ld",minutes];
    } else {
        mm = [NSString stringWithFormat:@"%ld",minutes];
    }
    
    if (hours/10 < 1) {
        hh = [NSString stringWithFormat:@"0%ld",hours];
    } else {
        hh = [NSString stringWithFormat:@"%ld",hours];
    }
    
    if (millisecond/step < 1) {
        ms = [NSString stringWithFormat:@"0%ld",millisecond];
    } else {
        ms = [NSString stringWithFormat:@"%ld",millisecond];
        if (millisecond==100) {
            ms = @"99";
        }
    }
    
    
    NSString * tim = @"";
    if (![hh isEqualToString:@"00"]) {
        tim = [NSString stringWithFormat:@"%@:%@:%@:%@",hh, mm, ss,ms];
    } else if (![mm isEqualToString:@"00"]) {
        tim = [NSString stringWithFormat:@"%@:%@:%@", mm, ss,ms];
    } else if (![ss isEqualToString:@"00"]) {
        tim = [NSString stringWithFormat:@"00:%@:%@", ss,ms];
    } else if (![ms isEqualToString:@"00"]) {
        tim = [NSString stringWithFormat:@"00:00:%@", ms];
    }
    else {
        tim = @"00:00:00";
    }
    
    return tim;
}

/** 通过行数, 返回更新时间 */
+ (NSString *)updateTimeForStampMS:(NSString*)stamp {
    // 获取当前时时间戳 1466386762.345715 十位整数 6位小数
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    // 创建歌曲时间戳(后台返回的时间 一般是13位数字)
    NSTimeInterval createTime = [stamp floatValue]/1000;
    // 时间差
    NSTimeInterval time = currentTime - createTime;
    
    // 秒转小时
    NSInteger hours = time/3600;
    if (hours<24) {
        return [NSString stringWithFormat:@"%ld小时前",hours];
    }
    //秒转天数
    NSInteger days = time/3600/24;
    if (days < 30) {
        return [NSString stringWithFormat:@"%ld天前",days];
    }
    //秒转月
    NSInteger months = time/3600/24/30;
    if (months < 12) {
        return [NSString stringWithFormat:@"%ld月前",months];
    }
    //秒转年
    NSInteger years = time/3600/24/30/12;
    return [NSString stringWithFormat:@"%ld年前",years];
}


// 毫秒时间戳 -> 日期 Time stamp
+ (NSString *)dateWithTimestampMS:(NSString *)timeString style:(DateStyle)theStyle
{
//    NSString* style = @"yyyy年MM月dd日 HH:mm";
    NSString* style = [self dateFormatWith:theStyle];
    
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"beijing"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:style]; //@"yyyy年MM月dd日 HH:mm"
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]/ 1000.0];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}


+ (double)timeStampNow {
    return [[NSDate date] timeIntervalSince1970];
}

+ (double)timeStampWithDateStr:(NSString*)theDate style:(DateStyle)theStyle {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:[JJTimeStamp dateFormatWith:theStyle]];
    NSDate *lastDate = [formatter dateFromString:theDate];
    //以 1970/01/01 GMT为基准，得到lastDate的时间戳
    double firstStamp = [lastDate timeIntervalSince1970];
    return firstStamp;
}

/**
 * 计算当前时间与某个指定时间的时间差
 */
+ (double)intervalSinceNowWith:(NSString *)theDate style:(DateStyle)theStyle
{
     //设置日期时间格式为：yyyy-MM-dd HH:mm:ss
     NSDateFormatter *date=[[NSDateFormatter alloc] init];
     //[date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [date setDateFormat:[JJTimeStamp dateFormatWith:theStyle]];
    
     //把指定的时间字符串转换位NSDate对象
     NSDate *d = [date dateFromString:theDate];
     //转换成当前时区的时间，方法convertDateToLocalTime:位于上面第二点
     NSDate *ds = [self convertDateToLocalTime:d];

     //获得指定时间相对于世间戳的秒数间隔
     NSTimeInterval late=[ds timeIntervalSince1970]*1;

     //创建当前时间
     NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
     NSDate *new = [self convertDateToLocalTime:dat];

     //获得当前时间相对于世间戳的秒数间隔
     NSTimeInterval now = [new timeIntervalSince1970]*1;

     NSTimeInterval cha = now-late;
    
     return cha;
}
//把日期转换成当前时区的日期
+ (NSDate *)convertDateToLocalTime:(NSDate *)forDate
{
     NSTimeZone *nowTimeZone = [NSTimeZone localTimeZone];
     NSInteger timeOffset = [nowTimeZone secondsFromGMTForDate:forDate];
     NSDate *newDate = [forDate dateByAddingTimeInterval:timeOffset];
     return newDate;
}


@end
