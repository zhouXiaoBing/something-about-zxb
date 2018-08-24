//
//  StringUtil.h
//  vitagou
//
//  Created by Mac on 2018/8/24.
//  Copyright © 2018年 vitagou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringUtil : NSObject

//去掉字符串的两边的空格和换行符
+ (NSString *)trim:(NSString *)string;

//MD5
+ (NSString *)md5:(NSString *)string;

//随机数
+(NSString *) randomStringWithLength:(NSInteger *)len;

//字符串加密
+(NSString *) encrypt:(NSString *) txt key:(NSString *) key;

//字符串解密
+(NSString *) decrypt:(NSString *) txt key:(NSString *) key;

//json格式字符串转字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

//字典转json格式字符串
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;


@end
