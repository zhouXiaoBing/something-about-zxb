//
//  zxb_product_data.m
//  vitagou
//
//  Created by Mac on 2017/7/12.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import "zxb_product_data.h"
#import "zxb_photo.h"


@implementation zxb_product_data

+ (NSDictionary *)objectClassInArray{
    return @{
             @"photo" : [zxb_photo class],
             };
}

@end
