
//
//  zxb_goods_comment.m
//  vitagou
//
//  Created by Mac on 2017/9/25.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import "zxb_goods_comment.h"

@implementation zxb_goods_comment


+(void)getGoodsComment:(NSString *)goods_id type:(NSString *)type success:(void (^)(zxb_Result *, goods_comment_data *))success failure:(void (^)(NSError *))failure
{
    NSString *str = [[[[APP_GOODS_COMMENT stringByAppendingString:@"?goods_id="] stringByAppendingString:goods_id] stringByAppendingString:@"&type="]stringByAppendingString:@"1"];
    
    NSURL *URL = [NSURL URLWithString:str];
    
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
            zxb_goods_comment *zpl = [zxb_goods_comment mj_objectWithKeyValues:html];
            zxb_Result *result = zpl.result;
            goods_comment_data *pro_data = zpl.data;
            success(result,pro_data);
        }
    }];
    
    [dataTask resume];
}

@end
