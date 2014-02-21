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

+ (NSString *)getWeekStringDayForWeek:(NSDate *)date
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [gregorian components:NSWeekdayCalendarUnit fromDate:[NSDate date]];
    [comps setTimeZone:[NSTimeZone systemTimeZone]];
    
    
    int weekday = [comps weekday];
    
    switch (weekday) {
        case 0:
            return @"星期日";
            break;
        case 1:
            return @"星期一";
            break;
        case 2:
            return @"星期二";
            break;
        case 3:
            return @"星期三";
            break;
        case 4:
            return @"星期四";
            break;
        case 5:
            return @"星期五";
            break;
        case 6:
            return @"星期六";
            break;
        default:
            break;
    }
    return @" ";
}

+ (NSInteger)getWeekDayForWeek:(NSDate *)date
{
    
    int weekday = [Calendar components:NSWeekdayCalendarUnit fromDate:date].weekday;
    
    return weekday;
    
}


+ (NSInteger)getWeekNumberForMonth:(NSDate *)date;
{
//    NSInteger week = [[Calendar components: (NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:date] weekdayOrdinal];
    
    
   NSDateComponents * comps = [Calendar components:(NSWeekCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit) fromDate:date];
    NSInteger weekdayOrdinal = [comps weekdayOrdinal];//这个月的第几周
    
    
    return weekdayOrdinal;
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
