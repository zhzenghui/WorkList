//
//  ZHViewController.m
//  WorkList
//
//  Created by bejoy on 14-2-10.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//

#import "ZHViewController.h"
#import "ProductCCell.h"


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
    
    
    
    NSCalendar *calendar = [[NSCalendar alloc]
                            initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *componentst = [[NSDateComponents alloc] init];
    [componentst setYear:2012];
    [componentst setMonth:11];
    [componentst setDay:4];
    
    NSDate *november4th2012 = [calendar dateFromComponents:componentst];

    NSDate *today =  [NSDate date];

    NSCalendar *cal = [NSCalendar currentCalendar];
    
    NSMutableArray *datesThisMonth = [NSMutableArray array];
    NSRange rangeOfDaysThisMonth = [cal rangeOfUnit:NSMonthCalendarUnit inUnit:NSYearCalendarUnit forDate:today];
    
    NSDateComponents *components = [cal components:( NSYearCalendarUnit | NSEraCalendarUnit) fromDate:today];
    [components setYear:0];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:0];
    
    for (NSInteger i = rangeOfDaysThisMonth.location; i < NSMaxRange(rangeOfDaysThisMonth); ++i) {
        [components setYear:i+1];
        NSDate *dayInMonth = [cal dateFromComponents:components];
        [datesThisMonth addObject:dayInMonth];
        NSLog(@"%@", dayInMonth);
    }
    
     
//    1970 － 2045
    
    NSMutableArray *years = [[NSMutableArray alloc] init];
    
    for (int i = 1970; i < 2050; i++) {
        [years addObject:[NSString stringWithFormat:@"%d", i]];
    }
    
    [self getMonths:years];


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
