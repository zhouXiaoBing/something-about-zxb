//
//  MyCollectionViewController.h
//  vitagou
//
//  Created by Mac on 2018/7/13.
//  Copyright © 2018年 vitagou. All rights reserved.
//


#import "BaseViewController.h"
#import "ElementsFlowLayout.h"
#import "VerticalFlowLayout.h"
#import "HorizontalFlowLayout.h"

@class MyCollectionViewController;

@protocol MyConllectionViewControllerDataSource<NSObject>

- (UICollectionViewLayout *)collectionViewController:(MyCollectionViewController *)collectionViewController layoutForCollectionView:(UICollectionView *)collectionView;

@end

@interface MyCollectionViewController : BaseViewController <UICollectionViewDelegate,UICollectionViewDataSource,MyConllectionViewControllerDataSource>

@property (weak,nonatomic)  UICollectionView *collectionView;

@end

