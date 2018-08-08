//
//  adv_list.m
//  vitagou
//
//  Created by Mac on 2018/7/27.
//  Copyright © 2018年 vitagou. All rights reserved.



#import "adv_list.h"

@implementation  adv_list

+ (NSDictionary *)objectClassInArray{//出现关键字冲突
    return @{
             @"item" : [adv_list_item class]
             };
}

@end

