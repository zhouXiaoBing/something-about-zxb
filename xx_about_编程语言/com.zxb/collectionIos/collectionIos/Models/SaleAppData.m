//
//  SaleAppData.m
//  collectionIos
//
//  Created by Mac on 2018/1/17.
//  Copyright © 2018年 Vitagou. All rights reserved.
//
#import "SaleAppData.h"


@implementation SaleAppData

+(void)getSaleAppData:(void (^)(NSString *request_code, NSString *reason, SaleResult *result))success failure:(void (^)(NSError *))failure{
    
    NSDictionary * parames = @{};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager init];
    
    [manager POST:@"collectionIos/JsonData/SaleAppData.json" parameters:parames progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%zd",responseObject);
        SaleAppData *saleData = [SaleAppData mj_objectWithKeyValues:responseObject];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@" error %@",error);
    }];
    
}
@end
