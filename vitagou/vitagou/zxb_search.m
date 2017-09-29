//
//  zxb_search.m
//  vitagou
//
//  Created by Mac on 2017/8/15.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "zxb_search.h"

@implementation zxb_search

+ (NSDictionary *)objectClassInArray{//出现关键字冲突
    return @{
             @"data" : [zxb_hot_word class]
             };
}

+(void)getHotWordData:(void (^)(zxb_Result *, NSMutableArray *))success failure:(void (^)(NSError *))failure
{
    NSURL *URL = [NSURL URLWithString:APP_HOT_SEARCH];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.responseSerializer = [[AFCompoundResponseSerializer alloc] init];//不做任何序列化纯二进制数据的显示
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else{
            NSObject *data = responseObject;
            NSString * html = [[NSString alloc] initWithData:(NSData*)data encoding:NSUTF8StringEncoding];
            zxb_search *zs= [zxb_search mj_objectWithKeyValues:html];
            zxb_Result *result = zs.result;
            NSMutableArray *two_data = zs.data;
            success(result,two_data);
        }
    }];
    
    [dataTask resume];
}

@end
