//
//  zxb_comment.m
//  vitagou
//
//  Created by Mac on 2017/7/13.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import "zxb_comment.h"

@implementation zxb_comment


+ (NSDictionary *)objectClassInArray{//出现关键字冲突
    return @{
             @"data" : [zxb_comment_data class],
             };
}

@end
