//
//  GradGoodItem.h
//  vitagou
//
//  Created by Mac on 2018/9/6.
//  Copyright © 2018年 vitagou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "goods_item.h"

@interface GradGoodItem : UICollectionViewCell

@property(nonatomic,strong) UIImageView *goodsView;

@property(nonatomic,strong) UILabel *goodsName;

@property(nonatomic,strong) UILabel *goodsPrice;

@property(nonatomic,strong) goods_item *goodsItem;

@end
