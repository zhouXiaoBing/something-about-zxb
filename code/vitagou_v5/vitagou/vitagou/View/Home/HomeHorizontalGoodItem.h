//
//  HomeHorizontalGoodItem.h
//  vitagou
//
//  Created by Mac on 2018/9/4.
//  Copyright © 2018年 vitagou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "special_pic_item.h"

@interface HomeHorizontalGoodItem : UICollectionViewCell
           
@property(nonatomic,strong) UIImageView *goodsView;

@property(nonatomic,strong) UILabel *goodsName;

@property(nonatomic,strong) UILabel *goodsPrice;

@property(nonatomic,strong) special_pic_item *special;

@end

