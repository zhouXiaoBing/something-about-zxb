//
//  zxb_classify_two.m
//  vitagou
//
//  Created by Mac on 2017/8/7.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "zxb_classify_two.h"

@implementation zxb_classify_two

+ (NSDictionary *)objectClassInArray{//出现关键字冲突
    return @{
             @"data" : [zxb_classify_two_data class]
             };
}

+(void)getClassifyTwoData:(NSString *)category_id success:(void (^)(zxb_Result *, NSMutableArray *))success failure:(void (^)(NSError *))failure
{
    NSString *str = [APP_TWO_CLASSIFY stringByAppendingString:@"?category_id="];
    NSString *strUrl = [str stringByAppendingString:category_id];
    NSURL *URL = [NSURL URLWithString:strUrl];
    
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
            zxb_classify_two *cls = [zxb_classify_two mj_objectWithKeyValues:html];
            zxb_Result *result = cls.result;
            NSMutableArray *two_data = cls.data;
            success(result,two_data);
        }
    }];
    
    [dataTask resume];
}

@end
