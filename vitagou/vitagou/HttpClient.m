//
//  HttpClient.m
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/8/16.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "HttpClient.h"

@implementation HttpClient

+ (instancetype)sharedInstance
{
    static HttpClient *client;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        client = [[HttpClient alloc] init];
    });
    return client;
}

- (void)request:(NSString *)url
         params:(NSDictionary *)params
           type:(HttpResponseType)type
        success:(void(^)(NSObject *response))success
        failure:(void(^)(NSError *error))failure
{
    //__weak typeof(self) weakSelf = self;
    [self POST:url parameters:params
       success:^(AFHTTPRequestOperation *operation, id response){
           
            #ifdef DEBUG
                //NSLog(@"url:%@\r\nbody:%@", url, response);
            #endif
           //NSLog(@"url:%@\r\nbody:%@", url, response);

           success(response);
       }
       failure:^(AFHTTPRequestOperation *operation, NSError *error){
           failure(error);
       }];
    
}

+ (void)requestJson:(NSString *)url
             params:(NSMutableDictionary *)params
            success:(void(^)(BOOL status, NSNumber *code, NSString *message, NSDictionary *data))success
            failure:(void(^)(NSError *error))failure
{
    if (!params)
        params = [NSMutableDictionary new];
    
    //总是提交客户端类型参数，标明是什么类型的客户端
    [params setObject:kTerminalTypeValue forKey:kTerminalTypeName];
    
    //提交app_cart_cookie_id，不注册用户也能添加产品到购物车
    NSString *app_cart_cookie_id = [StorageUtil getAppCartCookieId];
    NSString *access_token = [StorageUtil getAccessToken];
    NSNumber *user_id = [StorageUtil getUserId];
    //因为NSDictionary setObject: object 不能为 nil，所以这些判断是要的
    if (app_cart_cookie_id == nil)
        app_cart_cookie_id = @"";
    if (access_token == nil)
        access_token = @"";
    if (user_id == nil)
        user_id = @0;
    [params setObject:app_cart_cookie_id forKey:kStorageAppCartCookieId];
    [params setObject:access_token forKey:kStorageAccessToken];
    [params setObject:user_id forKey:kStorageUserId];
    
    
    
    [[self sharedInstance] request:url params:params type:HttpResponseType_Json
        success:^(NSObject *response){
        NSDictionary *dict = (NSDictionary *)response;
        BOOL result = [[dict objectForKey:@"status"] boolValue];
        NSNumber *code = [dict objectForKey:@"code"];
        NSString *message = [dict objectForKey:@"message"];
        NSDictionary *data = [dict objectForKey:@"data"];
    success(result, code, message, data);
                           }
        failure:failure];
}

+(void)requestJson2:(NSString *)url params:(NSMutableDictionary *)params success:(void (^)(NSObject *result,NSObject*data))success failure:(void (^)(NSError *))failure

{
    if (!params)
        params = [NSMutableDictionary new];
    
    [[self sharedInstance] request:url params:params type:HttpResponseType_Json success:^(NSObject *response) {
     //   NSData *dat = (NSData *)response;
//        //NSLog(@"dat :%@",dat);
//        NSString *jsonString = [[NSString alloc] initWithData:dat
//                                                     encoding:NSUTF8StringEncoding];
      //  NSLog(@"jsonString :%@",jsonString);
        NSDictionary *dict = (NSDictionary *)response;
        
//       NSString *responseString = [[NSString alloc] initWithData:dat encoding:NSUTF8StringEncoding];
        
        NSLog(@"response :%@",response);
        
        NSObject *result = [dict objectForKey:@"result"];
        NSObject *data = [dict objectForKey:@"data"];
        success(result,data);
    } failure:^(NSError *error) { 
        
    }];
}

+(void)requestJson3:(NSString *)url params:(NSMutableDictionary *)params success:(void (^)(NSObject *obj))success failure:(void (^)(NSError *))failure

{
    if (!params)
        params = [NSMutableDictionary new];
    
    [[self sharedInstance] request:url params:params type:HttpResponseType_Json success:^(NSObject *response) {
       // NSDictionary *dict = (NSDictionary *)response;
        NSObject *obj = response;
       // NSDictionary *result = [dict objectForKey:@"result"];
      //  NSDictionary *data = [dict objectForKey:@"data"];
        success(obj);
    } failure:^(NSError *error) {
        
    }];
}

- (NSString *)descriptionWithLocale:(id)locale  {
    NSString *string;
    @try {    string = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
    } @catch (NSException *exception)
    {      NSString *reason = [NSString stringWithFormat:@"reason:%@",exception.reason];          string = [NSString stringWithFormat:@"转换失败:/n%@,/n转换终止,输出如下:/n%@",reason,self.description];
    } @finally
    {
    }
    return string;
}
@end
