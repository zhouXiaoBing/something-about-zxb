//
//  special_pic.m
//  vitagou
//
//  Created by Mac on 2018/7/27.
//  Copyright © 2018年 vitagou. All rights reserved.
//

#import "special_pic.h"
#import "special_pic_item.h"

@implementation  special_pic

+ (NSDictionary *)objectClassInArray{//出现关键字冲突
    return @{
             @"item" : [special_pic_item class]
             };
}

@end

