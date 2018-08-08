//
//  homeData.m
//  vitagou
//
//  Created by Mac on 2018/7/26.
//  Copyright © 2018年 vitagou. All rights reserved.
//
#import "homeData.h"


@implementation homeData

+ (NSDictionary *)objectClassInArray{//出现关键字冲突
    return @{
//             @"datas" : [adv_list class]
             };
}


+ (void)getHomeData:(void (^)(NSString *, homeData *))success failure:(void (^)(NSError *))failure{
    NSLog(@"homeData_getHomeData");
    NSDictionary *parameters = @{@"c":@"index",@"a":@"index"};
//    [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:Vitagou_URL parameters:params error:nil];
//    [AFHTTPSessionManager alloc]ini
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    [manager POST:Vitagou_URL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"homeData_POST %@",responseObject);
//        NSLog(@"homeData_responseObject %@",responseObject);
        homeData *hd = [homeData mj_objectWithKeyValues:responseObject];
        NSLog(@"code %@",hd.code);
        NSString *code = hd.code;
        success(code,hd);
//        id key = hd.datas
//        for (int i = 0; i < hd.datas.count; i++) {
//            
//            NSArray *key = [hd.datas[i] allKeys];
//            for (int j = 0; j < key.count; j++) {
//                if ([key[j] isEqualToString:@"adv_list"]) {
//                    NSLog(@"识别出来了");
////                    adv_list *al = hd.datas[i];
//                }
//            }
            
//            NSLog(@"hd.datas[i] %@",key);
//            if (hd.datas[i] ) {
//                <#statements#>
//            }
//        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"homeData_POST_failure %@",error);
    }];
    
    
   
}
@end
