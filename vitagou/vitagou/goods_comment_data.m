
//
//  goods_comment_data.m
//  vitagou
//
//  Created by Mac on 2017/9/25.
//  Copyright © 2017年 Vitagou. All rights reserved.
//


#import "goods_comment_data.h"

@implementation goods_comment_data

+(NSDictionary *)objectClassInArray{
    
   return  @{
      @"content":[goods_comment_data_content class]
      };
}

@end
