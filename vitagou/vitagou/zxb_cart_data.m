

//
//  zxb_cart_data.m
//  vitagou
//
//  Created by Mac on 2017/9/6.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import "zxb_cart_data.h"

@implementation zxb_cart_data

+ (NSDictionary *)objectClassInArray{//出现关键字冲突
    return @{
             @"data" : [zxb_agency_data_goods class]
             };
}

+(void)getCartData:(NSString *)user_token success:(void (^)(zxb_Result *, NSMutableArray *))success failure:(void (^)(NSError *))failure
{
    NSString *str = [APP_QUERY_JOINCART stringByAppendingString:@"?user_token="];
    NSString *strUrl = [str stringByAppendingString:user_token];
    
    NSURL *URL = [NSURL URLWithString:strUrl];
    NSLog(@"URl %@",URL);
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

            zxb_cart_data *zcd = [zxb_cart_data mj_objectWithKeyValues:html];
            zxb_Result *result = zcd.result;
            NSLog(@"result.msg %@",result.msg);
            NSMutableArray *cartData = zcd.data;
            NSLog(@"cartData.count %lu",cartData.count);
            success(result,cartData);
        }
    }];
    
    [dataTask resume];
}

+(void)goodsEdit:(NSString *)user_token goods_id:(NSString *)goods_id goods_num:(NSString *)goods_num success:(void (^)(zxb_Result *))success failure:(void (^)(NSError *))failure{
    
    NSString *strUrl = [[[[[[APP_COMPUTE_JOINCART stringByAppendingString:@"?user_token="] stringByAppendingString:user_token] stringByAppendingString:@"&goods_id="] stringByAppendingString:goods_id] stringByAppendingString:@"&goods_number="] stringByAppendingString:goods_num];
    
    NSURL *URL = [NSURL URLWithString:strUrl];
    NSLog(@"URl %@",URL);
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
        
            zxb_cart_data *zcd = [zxb_cart_data mj_objectWithKeyValues:html];
            zxb_Result *result = zcd.result;
            NSLog(@"result.msg %@",result.msg);
            success(result);
        }
    }];
    
    [dataTask resume];
    
}

+(void)goodsDel:(NSString *)user_token goods_id:(NSString *)goods_id success:(void (^)(zxb_Result *))success failure:(void (^)(NSError *))failure{
    
    NSString *strUrl = [[[[APP_DEL_JOINCART stringByAppendingString:@"?user_token="] stringByAppendingString:user_token] stringByAppendingString:@"&goods_id="] stringByAppendingString:goods_id];
    
    NSURL *URL = [NSURL URLWithString:strUrl];
    NSLog(@"URl %@",URL);
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
           
            zxb_cart_data *zcd = [zxb_cart_data mj_objectWithKeyValues:html];
            zxb_Result *result = zcd.result;
            NSLog(@"result.msg %@",result.msg);
            success(result);
        }
    }];
    
    [dataTask resume];
}

+(void)goodsBeChoose:(NSString *)user_token goods_id:(NSString *)goods_id isCheck:(NSString *)ischeck success:(void (^)(zxb_Result *))success failure:(void (^)(NSError *))failure{
    
    NSString *strUrl = [[[[[[APP_SELECTED_JOINCART stringByAppendingString:@"?user_token="] stringByAppendingString:user_token] stringByAppendingString:@"&goods_id="] stringByAppendingString:goods_id] stringByAppendingString:@"&ischeck="] stringByAppendingString:ischeck];
    
    NSURL *URL = [NSURL URLWithString:strUrl];
    NSLog(@"URl %@",URL);
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

            zxb_cart_data *zcd = [zxb_cart_data mj_objectWithKeyValues:html];
            zxb_Result *result = zcd.result;
            NSLog(@"result.msg %@",result.msg);
            
            success(result);
        }
    }];
    
    [dataTask resume];
}
@end
