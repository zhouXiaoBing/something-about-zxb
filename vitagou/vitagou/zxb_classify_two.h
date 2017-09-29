//
//  zxb_classify_two.h
//  vitagou
//
//  Created by Mac on 2017/8/7.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import "zxb_Result.h"
#import "zxb_classify_two_data.h"
@interface zxb_classify_two : NSObject

@property(nonatomic,strong) zxb_Result *result;

@property(nonatomic, strong) NSMutableArray *data;

+(void)getClassifyTwoData:(NSString *)category_id
               success:(void(^)(zxb_Result *result, NSMutableArray *data))success
               failure:(void(^)(NSError *error))failure;

@end
