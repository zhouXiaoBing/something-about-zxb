//
//  zxb_promotion.h
//  vitagou
//
//  Created by Mac on 2017/4/20.
//  Copyright © 2017年 Vitagou. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "MJExtension.h"


@interface zxb_promotion : NSObject

@property (nonatomic, assign) NSString *id;

@property (nonatomic, assign) NSString *p_id;

@property (nonatomic, assign) NSString *goods_id;

@property (nonatomic, assign) NSString *promote_price;

@property (nonatomic, assign) NSString *total_num;

@property (nonatomic, assign) NSString *remain_num;

@property (nonatomic, strong) NSString *name;

//@property (nonatomic, assign) NSString *description;

@property (nonatomic, assign) NSString *special_img;

@property (nonatomic, strong) NSString *img;//assign改为strong以后避免了EXC_。。。的问题

@property (nonatomic, assign) NSString *sell_price;

@property (nonatomic, assign) NSString *market_price;

@property (nonatomic, assign) NSString *start_time;

@property (nonatomic, assign) NSString *end_time;

@property (nonatomic, assign) NSString *agency_id;

@property (nonatomic, assign) NSString *agency_name;

@property (nonatomic, assign) NSString *agency_desc;

@property (nonatomic, assign) NSString *unit_pound;

@property (nonatomic, assign) NSString *disable;

@property (nonatomic, assign) NSString *flag;



@end
