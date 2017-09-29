//
//  cartCollectionViewGoodsCell.h
//  vitagou
//
//  Created by Mac on 2017/9/7.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "zxb_agency_data_goods.h"
//#import "zxb_cart_goods.h"

@class cartCollectionViewGoodsCell;
@protocol CellButtonEventViewDelegate <NSObject>

@optional
- (void)deleteCell:(cartCollectionViewGoodsCell *)cell;
- (void)closeOtherCellLeftSwipe;
@end

@interface cartCollectionViewGoodsCell : UICollectionViewCell

@property (nonatomic, strong) zxb_agency_data_goods *agencyDataGoods;

//+ (instancetype)cellWithTableView:(UICollectionView *)coleetionView;
- (void)closeSwipe;
@property (nonatomic, assign)BOOL isSwipeMode;//是否滑动
//代理属性
@property (nonatomic,weak)id<CellButtonEventViewDelegate> delegate;

@property (nonatomic, strong) zxb_cart_goods *goods;

@end

