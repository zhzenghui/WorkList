//
//  CalendarCell.m
//  WorkList
//
//  Created by zeng hui on 14-2-22.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//

#import "CalendarView.h"
#import "NSDate+Category.h"

#define BUTTON_MARGIN 4
#define CALENDAR_MARGIN 5
#define TOP_HEIGHT 44
#define DAYS_HEADER_HEIGHT 22
#define DEFAULT_CELL_WIDTH 43
#define CELL_BORDER_WIDTH 1

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]





@interface DateButton : UIButton

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSCalendar *calendar;

@end

@implementation DateButton

- (void)setDate:(NSDate *)date {
    _date = date;
    if (date) {
        NSDateComponents *comps = [[NSCalendar currentCalendar] components:NSDayCalendarUnit|NSMonthCalendarUnit fromDate:date];
        [self setTitle:[NSString stringWithFormat:@"%d", comps.day] forState:UIControlStateNormal];
    } else {
        [self setTitle:@"" forState:UIControlStateNormal];
    }
}

@end


@interface CalendarView ()

@property(nonatomic, strong) UIView *highlight;
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UIButton *prevButton;
@property(nonatomic, strong) UIButton *nextButton;
@property(nonatomic, strong) UIView *calendarContainer;
@property(nonatomic, strong) NSArray *dayOfWeekLabels;
@property(nonatomic, strong) NSMutableArray *dateButtons;
@property(nonatomic, strong) NSDateFormatter *dateFormatter;

@property (nonatomic, strong) NSDate *monthShowing;
@property (nonatomic, strong) NSDate *selectedDate;
@property (nonatomic, strong) NSCalendar *calendar;
@property(nonatomic, assign) CGFloat cellWidth;

@end


@implementation CalendarView


- (NSDate *)_nextDay:(NSDate *)date {
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:1];
    return [self.calendar dateByAddingComponents:comps toDate:date options:0];
}


- (NSInteger)_numberOfDaysFromDate:(NSDate *)startDate toDate:(NSDate *)endDate {
    NSInteger startDay = [self.calendar ordinalityOfUnit:NSDayCalendarUnit inUnit:NSEraCalendarUnit forDate:startDate];
    NSInteger endDay = [self.calendar ordinalityOfUnit:NSDayCalendarUnit inUnit:NSEraCalendarUnit forDate:endDate];
    return endDay - startDay;
}

- (NSInteger)_placeInWeekForDate:(NSDate *)date {
    NSDateComponents *compsFirstDayInMonth = [self.calendar components:NSWeekdayCalendarUnit fromDate:date];
    return (compsFirstDayInMonth.weekday - 1 - self.calendar.firstWeekday + 8) % 7;
}



- (CGRect)_calculateDayCellFrame:(NSDate *)date {
    NSInteger numberOfDaysSinceBeginningOfThisMonth = [self _numberOfDaysFromDate:self.monthShowing toDate:date];
    NSInteger row = (numberOfDaysSinceBeginningOfThisMonth + [self _placeInWeekForDate:self.monthShowing]) / 7;
	
    NSInteger placeInWeek = [self _placeInWeekForDate:date];
    
    return CGRectMake(placeInWeek * (self.cellWidth + CELL_BORDER_WIDTH), (row * (self.cellWidth + CELL_BORDER_WIDTH))  + CELL_BORDER_WIDTH, self.cellWidth, self.cellWidth);
}



- (NSDate *)_firstDayOfNextMonthContainingDate:(NSDate *)date {
    NSDateComponents *comps = [self.calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:date];
    comps.day = 1;
    comps.month = comps.month + 1;
    return [self.calendar dateFromComponents:comps];
}

- (NSDate *)_firstDayOfMonthContainingDate:(NSDate *)date {
    NSDateComponents *comps = [self.calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:date];
    comps.day = 1;
    return [self.calendar dateFromComponents:comps];
}

- (NSInteger)_numberOfWeeksInMonthContainingDate:(NSDate *)date {
    return [self.calendar rangeOfUnit:NSWeekCalendarUnit inUnit:NSMonthCalendarUnit forDate:date].length;
}

- (BOOL)_dateIsToday:(NSDate *)date {
    return [self date:[NSDate date] isSameDayAsDate:date];
}

- (BOOL)date:(NSDate *)date1 isSameDayAsDate:(NSDate *)date2 {
    // Both dates must be defined, or they're not the same
    if (date1 == nil || date2 == nil) {
        return NO;
    }
    
    NSDateComponents *day = [self.calendar components:NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date1];
    NSDateComponents *day2 = [self.calendar components:NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date2];
    return ([day2 day] == [day day] &&
            [day2 month] == [day month] &&
            [day2 year] == [day year] &&
            [day2 era] == [day era]);
}


- (BOOL)_dateToWeekSun:(NSDate *)date {
    
    NSInteger weekNum = [NSDate getWeekDayForWeek:date];
    if (weekNum == 7 || weekNum == 1) {
        return YES;
    }
    return NO;
}

#pragma mark -

- (void)clear
{
    for (UIButton *b in self.dateButtons) {
        [b setTitle:@"" forState:UIControlStateNormal];
        b.alpha = 0;
    }
}

- (void)setCurrentDate:(NSDate *)currentDate
{
    if (_currentDate != currentDate) {

        [self clear];
        
        _currentDate = currentDate;
        _monthShowing = [self _firstDayOfMonthContainingDate:_currentDate];
        
        NSDate *date = [self _firstDayOfMonthContainingDate:self.monthShowing];
        NSDate *endDate = [self _firstDayOfNextMonthContainingDate:self.monthShowing];
        
        NSUInteger dateButtonPosition = 0;
        
        while ([date laterDate:endDate] != date) {
            DateButton *dateButton = [self.dateButtons objectAtIndex:dateButtonPosition];
            dateButton.alpha = 1;
            [dateButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            dateButton.date = date;
            
            if ([self _dateIsToday:dateButton.date]) {
                [dateButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            }
            if ([self _dateToWeekSun:date]) {
                [dateButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

                dateButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"sun_overtime"]];
            }
            else {
                
                dateButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"normal"]];
            }
            
            
            
            dateButton.frame = [self _calculateDayCellFrame:date];
            [self.calendarContainer addSubview:dateButton];
            
            date = [self _nextDay:date];
            dateButtonPosition++;
        }

        
        
        
        CGFloat containerWidth = 320 - (CALENDAR_MARGIN * 2);
        
        NSInteger numberOfWeeksToShow = 6;
        numberOfWeeksToShow = [self _numberOfWeeksInMonthContainingDate:self.monthShowing];
        CGFloat containerHeight = (numberOfWeeksToShow * (self.cellWidth + CELL_BORDER_WIDTH) + DAYS_HEADER_HEIGHT);
        
        self.calendarContainer.frame = CGRectMake(CALENDAR_MARGIN, CGRectGetMaxY(self.titleLabel.frame), containerWidth, containerHeight);
        
    }
}
- (void)_init {
    
    
    self.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    [self.calendar setLocale:[NSLocale currentLocale]];

    self.cellWidth = DEFAULT_CELL_WIDTH;

    
    
    _monthShowing = [self _firstDayOfMonthContainingDate:[NSDate date]];

    
    
    // THE CALENDAR ITSELF
    UIView *calendarContainer = [[UIView alloc] initWithFrame:CGRectZero];
//    calendarContainer.layer.borderWidth = 1.0f;
//    calendarContainer.layer.cornerRadius = 4.0f;
    
    

    
    [self addSubview:calendarContainer];

    
    
    self.calendarContainer = calendarContainer;
    
    
    

    
    
    
    NSMutableArray *dateButtons = [NSMutableArray array];
    for (NSInteger i = 1; i <= 42; i++) {
        DateButton  *dateButton = [DateButton buttonWithType:UIButtonTypeCustom];
        [dateButton addTarget:self action:@selector(_dateButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [dateButtons addObject:dateButton];
    }
    self.dateButtons = dateButtons;

    


    
}





- (id)init
{
    self = [super init];
    if (self) {

        [self _init];
    }
    return self;
}



@end



