
//
//  HomeScrollView.h
//  vitagou
//
//  Created by Mac on 2018/8/10.
//  Copyright © 2018年 vitagou. All rights reserved.
//
#import <SDCycleScrollView/SDCycleScrollView.h>//轮播图

@interface  HomeScrollView : UICollectionViewCell

@property (strong,nonatomic) SDCycleScrollView *scrollView;

@property (strong,nonatomic) NSArray *imageArray;



@end

