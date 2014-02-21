//
//  ZHViewController.m
//  WorkList
//
//  Created by bejoy on 14-2-10.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//

#import "ZHViewController.h"
#import "ProductCCell.h"

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
    
    _collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(74, 120, 800 , 600) collectionViewLayout:layout];
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
    NSLog(@"%d", weekDay);
    
    return weekDay;
}




- (void)viewDidLoad
{
    [super viewDidLoad];

//    年
//    all  year ，  current year
//    月
//    all month ， current month
//    周
//
//    天
//    UIImage *image ;
//    CIImage *output = [CIFilter filterWithName:@"CISepiaTone" keysAndValues:
//              kCIInputImageKey, image,
//              @"inputIntensity", @0.8,
//              nil].outputImage;
//    
//    
//    
//    NSCalendar *calendar = [[NSCalendar alloc]
//                            initWithCalendarIdentifier:NSGregorianCalendar];
//    NSDateComponents *componentst = [[NSDateComponents alloc] init];
//    [componentst setYear:2012];
//    [componentst setMonth:11];
//    [componentst setDay:4];
//    
//    NSDate *november4th2012 = [calendar dateFromComponents:componentst];
//
//    NSDate *today =  [NSDate date];
//
//    NSCalendar *cal = [NSCalendar currentCalendar];
//    
//    NSMutableArray *datesThisMonth = [NSMutableArray array];
//    NSRange rangeOfDaysThisMonth = [cal rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:today];
//    
//    NSDateComponents *components = [cal components:( NSWeekdayCalendarUnit | NSWeekOfMonthCalendarUnit ) fromDate:today];
//
//    [cal setMinimumDaysInFirstWeek:4];
//    
//    NSInteger weekdayOrdinal = [componentst weekOfYear];
//    NSLog(@"%d", weekdayOrdinal);
//    
//    
//    
//    NSDate *date = [NSDate date];
//    NSLog(@"week: %i", [[cal components: NSWeekCalendarUnit fromDate:date] week]);
////    NSLog(@"week: %i", [[cal components: NSWeekOfMonthCalendarUnit fromDate:date] weekOfMonth]);
//    
//    
//    
//    NSCalendar *calender = [NSCalendar currentCalendar];
//    NSRange weekRange = [calender rangeOfUnit:NSWeekCalendarUnit inUnit:NSMonthCalendarUnit forDate:date];
//    NSInteger weeksCount=weekRange.length;
//    NSLog(@"week count: %d",weeksCount);
    

    
            /*

    for (NSInteger i = rangeOfDaysThisMonth.location; i < NSMaxRange(rangeOfDaysThisMonth); ++i) {
        [components setDay:i+1];
        NSDate *dayInMonth = [cal dateFromComponents:components];
        [datesThisMonth addObject:dayInMonth];
        NSLog(@"%@", dayInMonth);

    }

    
    
//    日期的  星期几
//    当月第几周
//    本月一共多少周
    
//    NSWeekCalendarUnit
    int currentWeek = 0;
    int currentWeekday = 0;
   
    
//   weekday   header
    for (int i = 0; i < 7; i ++) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake( 20+i*40, 0, 44, 44);
        label.backgroundColor = [ UIColor redColor];
        label.text = [NSString stringWithFormat:@"%d", i+1];
        label.textAlignment = NSTextAlignmentCenter;
        
        [self.view addSubview:label];
    }
    
//   week for month
    
    
    
    
    
    for (int i= 0; i < datesThisMonth.count; i ++) {
        
        NSDate *date = [datesThisMonth objectAtIndex:i];
        
        
        
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake( 10, 10+i*44, 44, 44);
        
        label.text = [NSString stringWithFormat:@"%d", i+1];
        
        [self.view addSubview:label];
        
    }
//    1970 － 2045
    
//    NSMutableArray *years = [[NSMutableArray alloc] init];
//    
//    for (int i = 1970; i < 2050; i++) {
//        [years addObject:[NSString stringWithFormat:@"%d", i]];
//    }
//    
//    [self getMonths:years];


     */

    
    
    
    
    int weekCount =   [NSDate getWeekCountsForMonth:[NSDate date]];
    int weekDay = [NSDate getWeekDayForWeek:[NSDate date]];
    int weekMonth = [NSDate getWeekNumberForMonth:[NSDate date]];
    int weekYear = [NSDate getWeeksNumberForYear:[NSDate date]];
    
    NSLog(@"本月的周数量 %d",weekCount);
    NSLog(@"今天是星期 %d",weekDay);
    NSLog(@"本月第 %d 周", weekMonth);
        NSLog(@"本年第 %d 周",weekYear);
    
    
    for (int i = 0; i< weekCount; i++) {
        
    }
    
    
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
        NSLog(@"%@", dayInMonth);
        
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
        
        NSLog(@"%@", d);
    }
    NSLog(@"------------------------------------------");
    
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
    return CGSizeMake(233, 194);
}


- (void)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
//    [self openProductDetail:indexPath];
    
}


@end
