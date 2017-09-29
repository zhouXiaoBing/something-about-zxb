//
//  zxb_classify.m
//  vitagou
//
//  Created by Mac on 2017/8/7.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "zxb_classify.h"

@implementation zxb_classify

+(void)getClassifyData:(void (^)(zxb_Result *, zxb_classify_data*))success failure:(void (^)(NSError *))failure
{
    NSURL *URL = [NSURL URLWithString:APP_CLASSIFY];
    
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
//            product *pro = [product mj_objectWithKeyValues:html];
//            zxb_Result *result = pro.result;
//            zxb_product_data *product_data = pro.data;
            zxb_classify *cls = [zxb_classify mj_objectWithKeyValues:html];
            zxb_Result *result = cls.result; 
            zxb_classify_data *zxb_data = cls.data;
            success(result,zxb_data);
        }
    }];
    
    [dataTask resume];
}

@end
