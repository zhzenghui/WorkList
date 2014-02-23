//
//  productCCell.m
//  OrientParkson
//
//  Created by i-Bejoy on 14-1-3.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//

#import "ProductCCell.h"
#import "ImageView.h"   


CG_INLINE CGRect
RectMake2x(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
{
    CGRect rect;
    //    if (iOS7) {
    //        rect.origin.x = x/2; rect.origin.y = y/2;
    //    }
    //    else {
    rect.origin.x = x/2; rect.origin.y = y/2;
    
    //    }
    rect.size.width = width/2; rect.size.height = height/2;
    return rect;
}

#define KDocumentDirectory [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define KDocumentDirectoryFiles [KDocumentDirectory stringByAppendingPathComponent:@"/files"]
#define KDocumentName(fileName) [NSString stringWithFormat:@"%@/%@",  KDocumentDirectoryFiles ,fileName]



@implementation ProductCCell
 
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        
//        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"normal"]];
        _imgView1 = [[ImageView share] addToView:self
                                               imagePathName:nil rect:RectMake2x(2, 2, 462, 384)];
        
        
        [[ImageView share] addToView:_imgView1 imagePathName:@"productlist_cell_blackbox" rect:RectMake2x(10, 285, 446, 93)];
      
        ctnameLabel = [[UILabel alloc] initWithFrame:RectMake2x(25, 0, 446, 43)];
        ctnameLabel.font = [UIFont systemFontOfSize:13];
        ctnameLabel.textColor = [UIColor blackColor];
        ctnameLabel.tag = 201;
        
        pbNameLabel = [[UILabel alloc] initWithFrame:RectMake2x(25, 0, 446, 43)];
        pbNameLabel.font = [UIFont systemFontOfSize:16];
        pbNameLabel.textColor = [UIColor blackColor];
        pbNameLabel.tag = 2001;
        
        [_imgView1 addSubview:ctnameLabel];
        [_imgView1 addSubview:pbNameLabel];
        
        
        cv =  [[CalendarView alloc] init];
        cv.frame = CGRectMake(0, 25, 320, 400);


        [self addSubview:cv];


        
    }
    return self;
}

- (void)setDict:(NSDictionary *)dict
{
    if (_dict != dict) {
        _dict = dict;
    }
    

    NSString *nameString = [dict objectForKey:@"pic_name"];
    UIImage *img = [[UIImage alloc] initWithContentsOfFile:KDocumentName(nameString)];

    self.imgView1.image = img;

    
    NSDateComponents *comps = [[NSCalendar currentCalendar] components:NSDayCalendarUnit|NSMonthCalendarUnit |NSYearCalendarUnit fromDate:[dict objectForKey:@"date"]];
    ;
    
   NSDate *date = [[NSCalendar currentCalendar] dateFromComponents:comps];
    
    [cv setCurrentDate:date];

    ctnameLabel.text = [NSString stringWithFormat:@"%d月 %d年", comps.month, comps.year];
    pbNameLabel.text = [dict objectForKey:@"pd_name"];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
