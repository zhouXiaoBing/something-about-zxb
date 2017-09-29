//
//  goodsCell.h
//  vitagou
//
//  Created by Mac on 2017/7/7.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "zxb_new_goods.h"
#import "zxb_recommend_goods.h"
#import "DiscountPriceView.h"

@interface goodsCell : UICollectionViewCell

@property(nonatomic,strong) UIImageView *goodsView;

@property(nonatomic,strong) UILabel *goodsName;

@property(nonatomic,strong) UILabel *goodsDes;

@property(nonatomic,strong) UIView *lineView;

@property(nonatomic,strong) UIView *lineView_;

@property(nonatomic,strong) DiscountPriceView *goodsPrice;

@property(nonatomic,strong) zxb_new_goods *goodsNew;

@property(nonatomic,strong) zxb_recommend_goods *goodsRecommend;

@property (nonatomic,strong) UIImageView *backImageView;

@property(nonatomic ,strong) NSString *goods_id;

@end
