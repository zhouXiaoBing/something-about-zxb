//
//  zxb_home.m
//  vitagou
//
//  Created by Mac on 2017/4/19.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import "zxb_home.h"
#import "zxb_Result.h"
#import "zxb_home_data.h"
#import "zxb_promotion.h"
#import "zxb_objGroup.h"
#import "zxb_promotion.h"

@implementation zxb_home

+(void)getHomeData:(void(^)(zxb_Result *result, zxb_home_data *data))success

failure:(void(^)(NSError *error))failure
{
    NSLog(@"getHomeData方法执行。。。");
       NSURL *URL = [NSURL URLWithString:APP_HOME];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.responseSerializer = [[AFCompoundResponseSerializer alloc] init];//不做任何序列化纯二进制数据的显示
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSObject *data = responseObject;
            NSString * html = [[NSString alloc] initWithData:(NSData*)data encoding:NSUTF8StringEncoding];
            zxb_home *homeData = [zxb_home mj_objectWithKeyValues:html];
            zxb_Result *result = homeData.result;
            zxb_home_data *home = homeData.data;
            success(result,home);
        }
    }];
    [dataTask resume];

}
@end


