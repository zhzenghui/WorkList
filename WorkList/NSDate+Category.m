//
//  NSDate+Category.m
//  WorkList
//
//  Created by bejoy on 14-2-19.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//

#import "NSDate+Category.h"


#define Calendar [NSCalendar currentCalendar]
@implementation NSDate (Category)



+ (NSInteger)getWeekDayForWeek:(NSDate *)date
{

    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [gregorian components:NSWeekdayCalendarUnit fromDate:[NSDate date]];
    [comps setTimeZone:[NSTimeZone systemTimeZone]];

    
    int weekday = [comps weekday];
    return weekday;
    
}


+ (NSInteger)getWeekNumberForMonth:(NSDate *)date;
{
    NSInteger week = [[Calendar components: NSWeekCalendarUnit fromDate:date] weekOfMonth];
    return week;
}


/*
 获取 date 的 当年第几周
 */

+ (NSInteger)getWeeksNumberForYear:(NSDate *)date
{
    
    NSInteger week = [[Calendar components: NSWeekCalendarUnit fromDate:date] week];
    
    return week;
}


/*
 获取 date 的当月有几个周
 
 */
+ (NSInteger)getWeekCountsForMonth:(NSDate *)date{

    NSRange weekRange = [[NSCalendar currentCalendar] rangeOfUnit:NSWeekCalendarUnit inUnit:NSMonthCalendarUnit forDate:date];
    
    return weekRange.length;
}


@end
