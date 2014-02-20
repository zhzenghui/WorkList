//
//  NSDate+Category.h
//  WorkList
//
//  Created by bejoy on 14-2-19.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Category)


/*
 获取 date 的星期几
 
 */

+ (NSInteger)getWeekDayForWeek:(NSDate *)date;

/*
 获取 date 的 当月第几周
*/
+ (NSInteger)getWeekNumberForMonth:(NSDate *)date;


/*
 获取 date 的 当年第几周
 */

+ (NSInteger)getWeeksNumberForYear:(NSDate *)date;


/*
 获取 date 的当月有几个周
 
*/
+ (NSInteger)getWeekCountsForMonth:(NSDate *)date;





@end
