//
//  zxb_product_list.m
//  vitagou
//
//  Created by Mac on 2017/8/15.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import "zxb_product_list.h"
#import "zxb_list_data.h"

@implementation zxb_product_list

+ (NSDictionary *)objectClassInArray{//出现关键字冲突
    return @{
             @"data" : [zxb_list_data class]
             };
}
//label catagory_id  bid  keyword
+(void)getProductListData:(NSString *)categoryOrBrandOrKeyword_id label:(NSString *)label success:(void (^)(zxb_Result *, NSMutableArray *))success failure:(void (^)(NSError *))failure
{
    NSString *str;
    if ([label isEqualToString:@"category_id"]) {
        NSLog(@"getProductListData: category_id %@",categoryOrBrandOrKeyword_id);
        str = [APP_TYPE_SEARCH stringByAppendingString:@"?cat="];
    }else if ([label isEqualToString:@"bid"]){
        NSLog(@"getProductListData: bid %@",categoryOrBrandOrKeyword_id);
        str = [APP_TYPE_SEARCH stringByAppendingString:@"?bid="];
    }else if ([label isEqualToString:@"keyword"]){
        NSLog(@"getProductListData: keyword %@",categoryOrBrandOrKeyword_id);
        str = [APP_TYPE_SEARCH stringByAppendingString:@"?keyword="];
//        [categoryOrBrandOrKeyword_id stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
//    [categoryOrBrandOrKeyword_id stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *strUrl = [str stringByAppendingString:categoryOrBrandOrKeyword_id];
    NSLog(@"strUrl %@",strUrl);
    //[text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]
//    [strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [strUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
//    NSURL *URL = [NSURL URLWithString:[strUrl stringByAppendingString:[categoryOrBrandOrKeyword_id stringByAppendingFormat:@"%@", [NSCharacterSet URLFragmentAllowedCharacterSet]]]];
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
            zxb_product_list *zpl = [zxb_product_list mj_objectWithKeyValues:html];
            zxb_Result *result = zpl.result;
            NSMutableArray *pro_data = zpl.data;
            success(result,pro_data);
        }
    }];
    
    [dataTask resume];
    
}

+(void)getProductListDataByOrder:(NSString *)categoryOrBrandOrKeyword_id
                           label:(NSString *)label
                           order:(NSString *)order success:(void (^)(zxb_Result *, NSMutableArray *))success failure:(void (^)(NSError *))failure{
    NSString *str;
    if ([label isEqualToString:@"category_id"]) {
        NSLog(@"getProductListData: category_id %@",categoryOrBrandOrKeyword_id);
        str = [APP_TYPE_SEARCH stringByAppendingString:@"?cat="];
    }else if ([label isEqualToString:@"bid"]){
        NSLog(@"getProductListData: bid %@",categoryOrBrandOrKeyword_id);
        str = [APP_TYPE_SEARCH stringByAppendingString:@"?bid="];
    }else if ([label isEqualToString:@"keyword"]){
        NSLog(@"getProductListData: keyword %@",categoryOrBrandOrKeyword_id);
        str = [APP_TYPE_SEARCH stringByAppendingString:@"?keyword="];

    }
    
    NSString *strUrl = [str stringByAppendingString:categoryOrBrandOrKeyword_id];
    NSLog(@"strUrl %@",strUrl);
    
    NSString *strUrlByOrder = [strUrl stringByAppendingString:@"&order="];
    
    NSString *strUrlByOrderUrl = [strUrlByOrder stringByAppendingString:order];
   
    NSURL *URL = [NSURL URLWithString:strUrlByOrderUrl];
    NSLog(@"strUrlByOrderUrl %@",URL);
    
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
            zxb_product_list *zpl = [zxb_product_list mj_objectWithKeyValues:html];
            zxb_Result *result = zpl.result;
            NSMutableArray *pro_data = zpl.data;
            success(result,pro_data);
        }
    }];
    
    [dataTask resume];
}

@end
