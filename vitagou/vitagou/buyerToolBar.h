//
//  buyerToolBar.h
//  vitagou
//
//  Created by Mac on 2017/8/2.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BuyerToolBar;
@class MyProductItem;

@protocol BuyerToolBarDelegate <NSObject>

@optional

- (void)toolBar:(BuyerToolBar *)toolBar didClickButtonAtIndex:(NSUInteger)index;

@end

@interface BuyerToolBar : UIView

@property (nonatomic, weak) id <BuyerToolBarDelegate> delegate;
/**
 *   反映顾客与商品关系的数据模型
 */
@property (nonatomic, strong) MyProductItem *item;


@end
