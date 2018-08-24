//
//  week_new.m
//  vitagou
//
//  Created by Mac on 2018/7/27.
//  Copyright © 2018年 vitagou. All rights reserved.
//

#import "week_new.h"
#import "week_new_item.h"

@implementation  week_new

+ (NSDictionary *)objectClassInArray{//出现关键字冲突
    return @{
             @"item" : [week_new_item class]
             };
}

@end

