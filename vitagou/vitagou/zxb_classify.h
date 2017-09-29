//
//  zxb_classify.h
//  vitagou
//
//  Created by Mac on 2017/8/7.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import "MJExtension.h"
#import "zxb_Result.h"
#import "HttpClient.h"
#import "AFNetworking.h"
#import "zxb_classify_data.h"

@interface zxb_classify : NSObject

@property(nonatomic,strong) zxb_Result *result;

@property(nonatomic, strong) zxb_classify_data *data;

+(void)getClassifyData:(void(^)(zxb_Result *result, zxb_classify_data *data))success
    failure:(void(^)(NSError *error))failure;
@end
