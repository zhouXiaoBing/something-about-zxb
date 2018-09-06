//
//  goods.m
//  vitagou
//
//  Created by Mac on 2018/7/27.
//  Copyright © 2018年 vitagou. All rights reserved.
//

#import "goods.h"
#import "goods_item.h"
@implementation goods

+ (NSDictionary *)objectClassInArray{//出现关键字冲突
    return @{
             @"item" : [goods_item class]
             };
}
@end
