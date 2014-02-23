//
//  ZHViewController.m
//  WorkList
//
//  Created by bejoy on 14-2-10.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//

#import "ZHViewController.h"
#import "ProductCCell.h"
#import "CalendarView.h"


#import "NSDate+Category.h"


@interface ZHViewController ()

@end

@implementation ZHViewController


- (void)loadView
{
    [super loadView];
    
    
    
    
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    _collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 20, 320 , 480) collectionViewLayout:layout];
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];
    
    _collectionView.backgroundColor = [UIColor clearColor];
    [_collectionView registerClass:[ProductCCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    
    [self.view addSubview:_collectionView];
    
    
}

- (void)loadData
{
    self.dataMArray = [[NSMutableArray alloc] init];
}

- (NSInteger)getWeekForDate:(NSDate *)date
{
    
    NSCalendar *cal = [NSCalendar currentCalendar];

    NSDateComponents *components = [cal components:( NSDayCalendarUnit | NSWeekdayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit) fromDate:date];
    NSInteger   weekDay = [components weekday];
    
    return weekDay;
}




- (void)viewDidLoad
{
    [super viewDidLoad];

    [self loadData];
    
//    2013 ~ 2015
    
   
    
    
    NSDate *_date = [NSDate date];
    

    
    for (int i = 1; i <= 3; i++) {

        [self.dataMArray addObject:@{@"date": _date}];

         NSDateComponents *comps = [[NSCalendar currentCalendar] components:NSDayCalendarUnit|NSMonthCalendarUnit |NSYearCalendarUnit fromDate:_date];
        
        comps.month ++;
        NSDate *date = [[NSCalendar currentCalendar] dateFromComponents:comps];
        
        _date = date;
        
    }
    
    
//    
    int weekCount =   [NSDate getWeekCountsForMonth:[NSDate date]];
//    int weekDay = [NSDate getWeekDayForWeek:[NSDate date]];
//    int weekMonth = [NSDate getWeekNumberForMonth:[NSDate date]];
//    int weekYear = [NSDate getWeeksNumberForYear:[NSDate date]];
//    
    NSLog(@"本月的周数量 %d",weekCount);
//    NSLog(@"今天是星期 %d",weekDay);
//    NSLog(@"本月第 %d 周", weekMonth);
//    NSLog(@"本年第 %d 周",weekYear);
//    
//    
//    for (int i = 0; i< weekCount; i++) {
//        
//    }
    
    

//    cv =  [[CalendarView alloc] init];
//    cv.frame = CGRectMake(0, 40, 320, 400);
//
//    
//    
//    NSDate *date = [self _firstDayOfNextMonthContainingDate:[NSDate date]];
//    
//    [cv setCurrentDate:date];
//    [self.view addSubview:cv];
//    
//    
//    
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [button setTitle:@"<" forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(pre:) forControlEvents:UIControlEventTouchUpInside];
//    button.tag = 10;
//    button.frame = CGRectMake( 10, 400, 320, 40);
//    
//    [self.view addSubview:button];
//    
//    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [button1 setTitle:@">" forState:UIControlStateNormal];
//    [button1 addTarget:self action:@selector(pre:) forControlEvents:UIControlEventTouchUpInside];
//    button1.tag = 11;
//    button1.frame = CGRectMake( 10, 440, 320, 40);
//    
//    [self.view addSubview:button1];
    
    
    
//    UIImageView *iV = [[UIImageView alloc] initWithFrame:self.view.frame];
//    iV.image = [UIImage imageNamed:@"calendar-1136"];
//    [self.view addSubview:iV];
    
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:2 inSection:0] atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
}

- (void)pre:(UIButton *)button
{
    if (button.tag == 10) {
        
        NSDate *d = [self _firstDayOfNextMonthContainingDate:cv.currentDate];
        cv.currentDate = d;
    }
    else {
        NSDate *d = [self _endDayOfNextMonthContainingDate:cv.currentDate];
        cv.currentDate = d;
    }
    
    
    
}

- (NSDate *)_firstDayOfNextMonthContainingDate:(NSDate *)date {
    NSDateComponents *comps = [[NSCalendar currentCalendar] components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:date];
    comps.day = 1;
    comps.month = comps.month + 1;
    return [[NSCalendar currentCalendar]   dateFromComponents:comps];
}

- (NSDate *)_endDayOfNextMonthContainingDate:(NSDate *)date {
    NSDateComponents *comps = [[NSCalendar currentCalendar] components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:date];
    comps.day = 1;
    comps.month = comps.month - 1;
    return [[NSCalendar currentCalendar]   dateFromComponents:comps];
}




- (NSMutableArray *)getDays:(NSString *)month
{
    NSMutableArray *days = [[NSMutableArray alloc] init];

    
    
    NSDate *today = [self dateForNSString:month];
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    
    NSMutableArray *datesThisMonth = [NSMutableArray array];
    NSRange rangeOfDaysThisMonth = [cal rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:today];
    
    NSDateComponents *components = [cal components:( NSYearCalendarUnit | NSEraCalendarUnit) fromDate:today];
    [components setMonth:0];
    [components setDay:0];

    
    for (NSInteger i = rangeOfDaysThisMonth.location; i < NSMaxRange(rangeOfDaysThisMonth); ++i) {
        [components setDay:i+1];
        NSDate *dayInMonth = [cal dateFromComponents:components];
        [datesThisMonth addObject:dayInMonth];
        
        [days addObject:dayInMonth];
    }


    return days;
}


- (void)getMonths:(NSMutableArray *)years
{
    
    NSMutableArray *months = [[NSMutableArray alloc] init];

    
    for (NSString *year in years) {
        
        [months addObject:[self getMoths:year]];
    }
    
}

- (NSMutableArray *)getMoths:(NSString *)year
{
    NSMutableArray *months = [[NSMutableArray alloc] init];
    
    
    for (int i = 1; i <= 12 ; i++) {
        
        NSString *str = [NSString stringWithFormat:@"%@-%d-25", year, i];
        
        NSDate *d = [self dateForNSString:str];
        [months addObject:d];
        
        
        
        NSString *month = [NSString stringWithFormat:@"%@-%d-25", year, i];
        [self getDays:month];
        
    }
    
    return months;
}



- (NSDate *)dateForNSString:(NSString *)string
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];

    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *dateFromString = [[NSDate alloc] init];
    
    dateFromString = [dateFormatter dateFromString:string];
    return dateFromString;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataMArray.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ProductCCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    
    NSDictionary *dict = [self.dataMArray objectAtIndex:indexPath.row];
    cell.dict = dict;
    return cell;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 6;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDate *date = [[self.dataMArray objectAtIndex:indexPath.row] objectForKey:@"date" ];
    
    int weekCount =   [NSDate getWeekCountsForMonth:date];
    int height = (1.5+ weekCount) * 43;
    
    return CGSizeMake(320, height);
}


- (void)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
//    [self openProductDetail:indexPath];
    
}


@end
