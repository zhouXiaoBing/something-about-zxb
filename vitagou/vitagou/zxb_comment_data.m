
//
//  zxb_comment_data.m
//  vitagou
//
//  Created by Mac on 2017/7/13.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import "zxb_comment_data.h"

@implementation zxb_comment_data


+ (NSDictionary *)objectClassInArray{//出现关键字冲突
    return @{
             @"images" : [zxb_comment_images class],
             };
}
@end


