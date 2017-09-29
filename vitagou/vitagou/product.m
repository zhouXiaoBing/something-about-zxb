//
//  product.m
//  vitagou
//
//  Created by Mac on 2017/7/12.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import "product.h"


@implementation product

+(void)getProductDetail:(NSString *)goods_id
success:(void (^)(zxb_Result *, zxb_product_data *))success failure:(void (^)(NSError *))failure
{
    NSLog(@"getProductDetail执行。。 goods_id  %@",goods_id);
    
    //暂时没有找到好的方法 使用拼接字符串的方式-----------------------------------------
    NSString *str = [APP_GOODS_DETAILS stringByAppendingString:@"?goods_id="];
    NSString *strUrl = [str stringByAppendingString:goods_id];
    NSURL *URL = [NSURL URLWithString:strUrl];
    //----------------------------------------------------------------------------
    
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
            product *pro = [product mj_objectWithKeyValues:html];
            zxb_Result *result = pro.result;
            zxb_product_data *product_data = pro.data;
            success(result,product_data);
        }
    }];
    
    [dataTask resume];
    
}

@end
