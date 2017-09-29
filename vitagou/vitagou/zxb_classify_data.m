//
//  zxb_classify_data.m
//  vitagou
//
//  Created by Mac on 2017/8/7.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "zxb_classify_data.h"

@implementation zxb_classify_data

+ (NSDictionary *)objectClassInArray{//出现关键字冲突
    return @{
            @"CategoryNo1" : [zxb_category class]
             };
}

@end
