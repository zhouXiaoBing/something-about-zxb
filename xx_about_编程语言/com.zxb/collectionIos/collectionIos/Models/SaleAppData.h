//
//  SaleAppData.h
//  collectionIos
//
//  Created by Mac on 2018/1/17.
//  Copyright © 2018年 Vitagou. All rights reserved.
//

#import "SaleResult.h"

@interface SaleAppData : NSObject

@property(nonatomic, strong) NSString *request_code;

@property(nonatomic, strong) NSString *reason;

@property(nonatomic, strong) SaleResult *result;

+(void)getSaleAppData:(void(^)(NSString *request_code, NSString *reason, SaleResult *result))success
              failure:(void(^)(NSError *error))failure;
@end
