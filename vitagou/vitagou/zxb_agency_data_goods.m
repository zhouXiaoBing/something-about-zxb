//
//  zxb_agency_data_goods.m
//  vitagou
//
//  Created by Mac on 2017/9/6.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import "zxb_agency_data_goods.h"

@implementation zxb_agency_data_goods

+ (NSDictionary *)objectClassInArray{
    return @{
             @"goods" :[zxb_cart_goods class]
             
             };
}
@end
