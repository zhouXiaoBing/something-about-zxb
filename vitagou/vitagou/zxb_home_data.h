//
//  zxb_home_data.h
//  vitagou
//
//  Created by Mac on 2017/4/19.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
#import "zxb_index_slide.h"
#import "zxb_promotion.h"
#import "zxb_objGroup.h"
#import "zxb_hot_brand.h"
#import "zxb_new_goods.h"
#import "zxb_recommend_goods.h"

@interface zxb_home_data : NSObject

//以下相当于Javabean



@property (nonatomic,copy) NSString *end_time;

@property (nonatomic, strong) NSMutableArray *index_slide;

@property (nonatomic, strong) NSMutableArray *promotion;

@property (nonatomic, strong) NSMutableArray *objGroup;

@property (nonatomic, strong) NSMutableArray *hot_category;

@property (nonatomic, strong) NSMutableArray *hot_brand;

@property (nonatomic, strong) NSMutableArray *newgoods;

@property (nonatomic, strong) NSMutableArray *recommend_goods;





@end
