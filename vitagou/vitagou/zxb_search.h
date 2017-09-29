//
//  zxb_search.h
//  vitagou
//
//  Created by Mac on 2017/8/15.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import "zxb_Result.h"
#import "zxb_hot_word.h"

@interface zxb_search : NSObject

@property(nonatomic, strong) zxb_Result *result;

@property(nonatomic, strong) NSMutableArray *data;

+(void)getHotWordData:(void(^)(zxb_Result *result, NSMutableArray *data))success
               failure:(void(^)(NSError *error))failure;

@end
