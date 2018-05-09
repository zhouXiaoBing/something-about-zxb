//
//  SaleResult.m
//  collectionIos
//
//  Created by Mac on 2018/1/30.
//  Copyright © 2018年 Vitagou. All rights reserved.
//

#import "SaleResult.h"
#import "SaleRotate.h"

@implementation SaleResult

+ (NSDictionary *)objectClassInArray{//出现关键字冲突
    return @{
             @"rotateZxb" : [SaleRotate class]
             };
}

@end
