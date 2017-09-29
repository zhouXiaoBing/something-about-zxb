//
//  product.h
//  vitagou
//
//  Created by Mac on 2017/7/12.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
#import "zxb_Result.h"
#import "zxb_product_data.h"
#import "HttpClient.h"
#import "AFNetworking.h"

@interface product : NSObject

@property(nonatomic,strong) zxb_Result *result;

@property(nonatomic, strong) zxb_product_data *data;

+(void)getProductDetail:(NSString *)goods_id
success:(void(^)(zxb_Result *result, zxb_product_data *data))success
    failure:(void(^)(NSError *error))failure;


@end


