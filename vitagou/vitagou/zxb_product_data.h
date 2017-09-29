//
//  zxb_product_data.h
//  vitagou
//
//  Created by Mac on 2017/7/12.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import "zxb_agency.h"
#import "zxb_comment.h"

@interface zxb_product_data : NSObject

@property (nonatomic, strong) NSString *id;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *goods_no;

@property (nonatomic, strong) NSString *model_id;

@property (nonatomic, strong) NSString *sell_price;

@property (nonatomic, strong) NSString *market_price;

@property (nonatomic, strong) NSString *promote_price;

@property (nonatomic, strong) NSString *wechat_price;

@property (nonatomic, strong) NSString *cost_price;

@property (nonatomic, strong) NSString *up_time;

@property (nonatomic, strong) NSString *down_time;

@property (nonatomic, strong) NSString *create_time;

@property (nonatomic, strong) NSString *store_nums;

@property (nonatomic, strong) NSString *img;

@property (nonatomic, strong) NSString *special_img;

@property (nonatomic, strong) NSString *ad_img;

@property (nonatomic, strong) NSString *is_del;

@property (nonatomic, strong) NSString *is_new;

@property (nonatomic, assign) NSString *is_hot;

@property (nonatomic, strong) NSString *is_sale;

@property (nonatomic, strong) NSString *is_recommend;

@property (nonatomic, strong) NSString *is_special;

@property (nonatomic, strong) NSString *keywords;

//@property (nonatomic, strong) NSString *description;

@property (nonatomic, strong) NSString *search_words;

@property (nonatomic, strong) NSString *weight;

@property (nonatomic, strong) NSString *point;

@property (nonatomic, strong) NSString *unit;

@property (nonatomic, strong) NSString *brand_id;

@property (nonatomic, strong) NSString *visit;

@property (nonatomic, strong) NSString *favorite;

@property (nonatomic, strong) NSString *sort;

@property (nonatomic, strong) NSString *spec_array;

@property (nonatomic, strong) NSString *exp;

@property (nonatomic, strong) NSString *comments;

@property (nonatomic, strong) NSString *sale;

@property (nonatomic, strong) NSString *goods_label;

@property (nonatomic, strong) NSString *grade;

@property (nonatomic, strong) NSString *seller_id;

@property (nonatomic, strong) NSString *is_share;

@property (nonatomic, strong) NSString *comName;

@property (nonatomic, strong) NSString *productdate;

@property (nonatomic, strong) NSString *goods_coupon_label;

@property (nonatomic, strong) NSString *kgs;

@property (nonatomic, strong) NSString *goodsBracode;

@property (nonatomic, strong) NSString *ingredient;

@property (nonatomic, strong) NSString *QtyUnit;

@property (nonatomic, strong) NSString *AssemCountry;

@property (nonatomic, strong) NSString *spec;

@property (nonatomic, strong) NSString *max_score;

@property (nonatomic, strong) NSString *brokerage;

@property (nonatomic, strong) NSString *coupon_support;

@property (nonatomic, strong) NSString *sell_type;

@property (nonatomic, strong) NSString *whether_sale;

@property (nonatomic, strong) NSString *purchase;

@property (nonatomic, strong) NSString *CustomsListNO;

@property (nonatomic, strong) NSString *CIQGoodsNO;

@property (nonatomic, strong) NSString *goods_hsCode;

@property (nonatomic, strong) NSString *customs_goods_no;

@property (nonatomic, strong) NSString *agency_id;

@property (nonatomic, strong) NSString *limit_useticket;

@property (nonatomic, strong) NSString *promotion;

@property (nonatomic, assign) NSString *is_promotion;

@property (nonatomic, assign) NSString *favorite_id;

@property (nonatomic, strong) NSMutableArray *photo;//做关联

@property (nonatomic, strong) zxb_agency *agency;

@property (nonatomic, strong) zxb_comment *comment;

@end
