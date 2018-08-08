//
//  homeData.h
//  vitagou
//
//  Created by Mac on 2018/7/26.
//  Copyright © 2018年 vitagou. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "adv_list.h"
@interface homeData : NSObject

@property(nonatomic,strong) NSString *code;

@property(nonatomic,strong) NSMutableArray *datas;

+(void)getHomeData:(void(^)(NSString *code, homeData *data))success
           failure:(void(^)(NSError *error))failure;

@end
