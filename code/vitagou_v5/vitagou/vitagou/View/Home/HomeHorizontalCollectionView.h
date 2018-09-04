//
//  HomeHorizontalCollectionView.h
//  vitagou
//
//  Created by Mac on 2018/8/28.
//  Copyright © 2018年 vitagou. All rights reserved.
//

#import "special_pic.h"
@class HomeHorizontalCollectionView;

@protocol HomeHorizontalDataSource <NSObject>

@required
// 需要返回的布局
- (UICollectionViewLayout *)collectionViewController:(HomeHorizontalCollectionView *)collectionViewController layoutForColletionView:(UICollectionView                                                                                                *)collectionView;


@end

@interface HomeHorizontalCollectionView : UICollectionViewCell

@property (strong,nonatomic) special_pic *special;

@end

