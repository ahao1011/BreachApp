//
//  NSObject+GetCurrentTime.m
//  祥鹏
//
//  Created by 易思凯 on 15/11/30.
//  Copyright © 2015年 zhh. All rights reserved.
//

#import "NSObject+GetCurrentTime.h"

@implementation NSObject (GetCurrentTime)
- (NSString *)getCurrentWeek
{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *formatterDate = [inputFormatter dateFromString:[self getCurrentDay]];
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
    [outputFormatter setDateFormat:@"EEEE"];
    NSString *newDateString = [outputFormatter stringFromDate:formatterDate];
    return newDateString;
    
}

/**
 *  获取当前的时间的后一天
 */
- (NSString *)getCurrentDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSInteger dis = 1; //前后的天数
    NSDate *nowDate = [NSDate date];
    NSDate *theDate;
    
    if(dis!=0)
    {
        NSTimeInterval oneDay = 24*60*60*1;  //1天的长度
        theDate = [nowDate initWithTimeIntervalSinceNow: +oneDay*dis];
    }
    else
    {
        theDate = nowDate;
    }
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate * date = [formatter dateFromString:[dateFormatter stringFromDate:theDate]];
    
    return [formatter stringFromDate:date];
    
}

//获取传入日期的后一天
- (NSString *)getSelectedDay:(NSString *)selected
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    
    NSInteger dis = 1; //前后的天数
    NSDate *nowDate = [dateFormatter dateFromString:selected];
    NSDate *theDate;
    
    if(dis!=0)
    {
        NSTimeInterval oneDay = 24*60*60*1;  //1天的长度
        theDate = [nowDate initWithTimeInterval:oneDay sinceDate:nowDate];
    }
    else
    {
        theDate = nowDate;
    }
    
    return [dateFormatter stringFromDate:theDate];
}

- (NSString *)getBeforeDay:(NSString *)selected
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    
    NSInteger dis = 1; //前后的天数
    NSDate *nowDate = [dateFormatter dateFromString:selected];
    NSDate *theDate;
    
    if(dis!=0)
    {
        NSTimeInterval oneDay = -24*60*60*1;  //1天的长度
        theDate = [nowDate initWithTimeInterval:oneDay sinceDate:nowDate];
    }
    else
    {
        theDate = nowDate;
    }
    
    return [dateFormatter stringFromDate:theDate];
}

//获取传入日期是周几
- (NSString *)getSelectedWeek:(NSString *)selected
{
    NSDateFormatter * dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *formatterDate = [dateFormatter dateFromString:selected];
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
//    [outputFormatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
    [outputFormatter setDateFormat:@"EEEE"];
    NSString *newDateString = [outputFormatter stringFromDate:formatterDate];
    return newDateString;
}

@end
