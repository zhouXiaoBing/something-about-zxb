//
//  DiscountPriceView.h
//  vitagou
//
//  Created by Mac on 2017/6/8.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "Goods.h"
#import "zxb_promotion.h"
#import "zxb_recommend_goods.h"
#import "zxb_new_goods.h"
#import "zxb_product_data.h"
#import "zxb_list_data.h"
#import "zxb_cart_goods.h"
@interface DiscountPriceView : UIView

//@property (nonatomic,strong) Goods *goods;
@property (nonatomic,strong) zxb_promotion *goods;

@property(nonatomic,strong) zxb_new_goods *goodsNew;

@property(nonatomic,strong) zxb_recommend_goods *goodsRecommend;

@property(nonatomic,strong) zxb_product_data *productData;

@property(nonatomic,strong) zxb_list_data *listData;

@property(nonatomic,strong)zxb_cart_goods *cartGoods;

@end
