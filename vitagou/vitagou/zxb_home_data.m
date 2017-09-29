//
//  zxb_home_data.m
//  vitagou
//
//  Created by Mac on 2017/4/19.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import "zxb_home_data.h"

@implementation zxb_home_data

/*
 @property (nonatomic, strong) NSArray *index_slide;
 
 @property (nonatomic, strong) NSArray *promotion;
 
 @property (nonatomic, strong) NSArray *objGroup;
 
 @property (nonatomic, strong) NSArray *hot_category;
 
 @property (nonatomic, strong) NSArray *hot_brand;
 
 @property (nonatomic, strong) NSArray *new_goods;
 
 @property (nonatomic, strong) NSArray *recommend_goods;
 
 
 NSArray *products = nil;
 NSMutableArray *productsArr = [NSMutableArray new];
 if (result) {
 NSArray *dictArr = [data objectForKey:@"productList"];
 for (NSDictionary *dict in dictArr) {
 Product *product = [[Product alloc] initWithDictionary:dict];
 [productsArr addObject:product];
 }
 products = [productsArr mutableCopy];
 }
 success(result, message, products);

 */
+ (NSDictionary *)objectClassInArray{//出现关键字冲突
    return @{
             @"index_slide" : [zxb_index_slide class],
             @"promotion" : [zxb_promotion class],
             @"objGroup" : [zxb_objGroup class],
             @"hot_brand" : [zxb_hot_brand class],
             @"newgoods" : [zxb_new_goods class],
             @"recommend_goods" : [zxb_recommend_goods class]
             };
}






@end
