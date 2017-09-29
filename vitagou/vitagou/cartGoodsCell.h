//
//  cartGoodsCell.h
//  vitagou
//
//  Created by Mac on 2017/9/8.
//  Copyright © 2017年 Vitagou. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "zxb_cart_goods.h"

@class cartGoodsCell;
@protocol CellButtonEventViewDelegate <NSObject>

@optional
- (void)deleteCell:(cartGoodsCell *)cell;
- (void)closeOtherCellLeftSwipe;
@end

@interface cartGoodsCell : UICollectionViewCell

//静态构造方法
//+ (instancetype)cellWithTableView:(UITableView *)tableview;
- (void)closeSwipe;
@property (nonatomic, assign)BOOL isSwipeMode;//是否滑动
//代理属性
@property (nonatomic,weak)id<CellButtonEventViewDelegate> delegate;

@property (nonatomic, strong) zxb_cart_goods *goods;

@property(nonatomic ,strong) NSString *goods_id;

@property(nonatomic ,strong) NSString *agency_id;

@property(nonatomic ,strong) NSString *seller_id;

@property(nonatomic ,strong) NSString *goods_num;

@end
