//
//  zxb_home.h
//  vitagou
//
//  Created by Mac on 2017/4/19.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
#import "zxb_Result.h"
#import "zxb_home_data.h"

@interface zxb_home : NSObject

//以下相当于Javabean
@property (nonatomic,copy) NSNumber *id;

@property (nonatomic,strong) zxb_Result *result;

@property(nonatomic,strong) zxb_home_data *data;

//+ (void)getHomeData:(void(^)(BOOL result, NSNumber *code, NSString *message, NSArray *categories))success
//                          failure:(void(^)(NSError *error))failure;


+(void)getHomeData:(void(^)(zxb_Result *result, zxb_home_data *data))success
failure:(void(^)(NSError *error))failure;

@end
