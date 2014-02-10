//
//  ZHViewController.h
//  WorkList
//
//  Created by bejoy on 14-2-10.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_collectionView;
}


@property(nonatomic, strong) NSMutableArray *dataMArray;

@end
