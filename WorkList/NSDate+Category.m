//
//  NSDate+Category.m
//  WorkList
//
//  Created by bejoy on 14-2-19.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//

#import "NSDate+Category.h"

@implementation NSDate (Category)



+ (NSInteger)getWeekDayForCalendar:(NSDate *)date
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [cal components:( NSDayCalendarUnit | NSWeekdayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit) fromDate:date];
    NSInteger   weekDay = [components weekday];
    NSLog(@"%d", weekDay);
    
    return weekDay;
}


+ (NSInteger)getWeekNumberFor:(NSDate *)date;
{
    NSInteger week = [[[NSCalendar currentCalendar] components: NSWeekCalendarUnit fromDate:date] week];
    
    return week;
}


/*
 获取 date 的 当年第几周
 */

+ (NSInteger)getWeeksNumberForYear:(NSDate *)date
{
    
    NSInteger week = [[[NSCalendar currentCalendar] components: NSWeekCalendarUnit fromDate:date] week];
    
    return week;
}


/*
 获取 date 的当月有几个周
 
 */
+ (NSInteger)getWeekCountsForMonth:(NSDate *)date{

    NSCalendar *calender = [NSCalendar currentCalendar];
    NSRange weekRange = [calender rangeOfUnit:NSWeekCalendarUnit inUnit:NSMonthCalendarUnit forDate:date];
    NSInteger weeksCount=weekRange.length;
    NSLog(@"week count: %d",weeksCount);
    
    return weeksCount;
}


@end
