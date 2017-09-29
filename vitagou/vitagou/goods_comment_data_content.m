//
//  goods_comment_data_content.m
//  vitagou
//
//  Created by Mac on 2017/9/25.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import "goods_comment_data_content.h"
#import "goods_comment_data_content_img.h"

@implementation goods_comment_data_content

+(NSDictionary *)objectClassInarray{
    return @{
             @"images":[goods_comment_data_content_img class],
             };
}

@end
