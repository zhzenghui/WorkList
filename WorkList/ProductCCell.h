//
//  productCCell.h
//  OrientParkson
//
//  Created by i-Bejoy on 14-1-3.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarView.h"


@interface ProductCCell : UICollectionViewCell
{
 
    UILabel *ctnameLabel;
    UILabel *pbNameLabel;
    
    
    CalendarView *cv;

    
}

@property(nonatomic, strong) NSDictionary *dict;
@property(nonatomic, strong) UIImageView *imgView1;
@property(nonatomic, strong) UILabel *ctnameLabel;
@property(nonatomic, strong) UILabel *pbNameLabel;

@end
