//
//  StringUtil.m
//  vitagou
//
//  Created by Mac on 2018/8/24.
//  Copyright © 2018年 vitagou. All rights reserved.
//

#import "StringUtil.h"
#import <CommonCrypto/CommonDigest.h>

@implementation StringUtil

+ (NSString *)trim:(NSString *)string
{
    //去除两端空格
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    //去除两端空格和回车
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return string;
}

+ (NSString *)md5:(NSString *)string{
    const char *cStr = [string UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), result );
    
    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1],
            result[2], result[3],
            result[4], result[5],
            result[6], result[7],
            result[8], result[9],
            result[10], result[11],
            result[12], result[13],
            result[14], result[15]
            ];
}


+(NSString *)randomStringWithLength:(NSInteger *)len{
    
    NSString *letters = @"abcdefghijklmnopqrstuvwxyz0123456789";
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform([letters length])]];
    }
    
    return randomString;
}


+ (NSString *)encrypt:(NSString *)txt key:(NSString *)key{
    if (!txt) {
        return txt;
    }
    if (!key) {
        return [self md5:@""];
    }
    NSString *chars = @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_.";
    NSString *ikey = @"-x6g6ZWm2G9g_vr0Bo.pOq3kRIxsZ6rm";
    //生成随机数 3个
    int nh1 = arc4random()%64;
    int nh2 = arc4random()%64;
    int nh3 = arc4random()%64;
    NSLog(@"随机数1：%d",nh1);
    NSLog(@"随机数2：%d",nh2);
    NSLog(@"随机数3：%d",nh3);
    NSString *ch1 = [chars substringWithRange:NSMakeRange(nh1, 1)];
    NSString *ch2 = [chars substringWithRange:NSMakeRange(nh2, 1)];
    NSString *ch3 = [chars substringWithRange:NSMakeRange(nh3, 1)];
    NSLog(@"ch1：%@",ch1);
    NSLog(@"ch2：%@",ch2);
    NSLog(@"ch3：%@",ch3);
    int nhnum = nh1 + nh2 + nh3;
    int knum = 0;
    int i = 0;
    //拿到字符串的 ASCII 码
    while (key != nil && i < key.length) {
        knum += [key characterAtIndex:i];
        i++;
    }
    //substr 截取 加密后的 字符串 16位
    NSString *mdkey = [[self md5:[[self md5:[[[self md5:[key stringByAppendingString:ch1]] stringByAppendingString:ch2] stringByAppendingString:ikey]] stringByAppendingString:ch3]] substringWithRange:NSMakeRange(nhnum%8, knum%8+16)];
    //base64_encode + 时间戳 + 下划线 + 待加密string
    NSDate *datetime = [NSDate date];
    NSTimeZone *zone = [NSTimeZone timeZoneForSecondsFromGMT:8];
    NSInteger interval = [zone secondsFromGMTForDate:datetime];
    NSDate *localeDate = [datetime  dateByAddingTimeInterval: interval];
    NSString *unixtime = [NSString stringWithFormat:@"%.f", floor([localeDate timeIntervalSince1970])];
    NSString *str1 = [unixtime stringByAppendingString:@"_"];
    NSString *str2 = [str1 stringByAppendingString:txt];
    NSData *data = [str2 dataUsingEncoding:NSUTF8StringEncoding];
    txt = [data base64EncodedStringWithOptions:0];
    NSString *rp1 = [txt stringByReplacingOccurrencesOfString:@"+" withString:@"-"];
    NSString *rp2 = [rp1 stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    txt = [rp2 stringByReplacingOccurrencesOfString:@"=" withString:@"."];
    NSString *tmp =@"";
    int j = 0;
    int k = 0;
    NSUInteger tlen = [txt length];
    NSUInteger klen = [mdkey length];
    for (int i = 0; i < tlen; i++) {
        if (k == klen) {
            k = 0;
        }
        //txt i 位置的字符
        NSString *txti = [txt substringWithRange:NSMakeRange(i, 1)];
        //txt i 位置的字符 对应在 chars 中的位置
        NSRange range = [chars rangeOfString:txti];
        NSUInteger loc = range.location;
        //mdkey k 位置的 字符 的 ASCII 码
        int asc = [mdkey characterAtIndex:k++];
        j = (nhnum + loc + asc)%64;
        //chars j 位置的字符
        NSString * charsj = [chars substringWithRange:NSMakeRange(j, 1)];
        tmp = [tmp stringByAppendingString:charsj];
    }
    NSUInteger tmplen = [tmp length];
    //在字符串 tmp 指定位置插入 ch3 ch2 ch1
    NSMutableString *strtmp = [[NSMutableString alloc]initWithString:tmp];
    [strtmp insertString:ch3 atIndex:nh2 % (++tmplen)];
    [strtmp insertString:ch2 atIndex:nh1 % (++tmplen)];
    [strtmp insertString:ch1 atIndex:knum % (++tmplen)];
    //    NSLog(@"加密结果： %@",strtmp);
    return strtmp;
}

+ (NSString *)decrypt:(NSString *)txt key:(NSString *)key{
    if (!txt) {
        return txt;
    }
    if (!key) {
        return [self md5:@""];
    }
    NSString *chars = @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_.";
    NSString *ikey = @"-x6g6ZWm2G9g_vr0Bo.pOq3kRIxsZ6rm";
    int knum = 0;
    int i = 0;
    NSUInteger tlen = [txt length];
    while (key != nil && i < key.length) {
        knum += [key characterAtIndex:i];
        i++;
    }
    NSString *ch1 = [txt substringWithRange:NSMakeRange(knum % tlen, 1)];
    NSRange range = [chars rangeOfString:ch1];
    NSUInteger nh1 = range.location;
    //删除 txt  knum % tlen 位置的字符
    NSMutableString *strtxt = [[NSMutableString alloc]initWithString:txt];
    [strtxt deleteCharactersInRange:NSMakeRange(knum % (tlen--), 1)];//params 位置 长度
    NSString *ch2 = [strtxt substringWithRange:NSMakeRange(nh1 % tlen, 1)];
    NSRange rangech2 = [chars rangeOfString:ch2];
    NSUInteger nh2 = rangech2.location;
    [strtxt deleteCharactersInRange:NSMakeRange(nh1 % (tlen--), 1)];
    NSString *ch3 = [strtxt substringWithRange:NSMakeRange(nh2 % tlen, 1)];
    NSRange rangech3 = [chars rangeOfString:ch3];
    NSUInteger nh3 = rangech3.location;
    [strtxt deleteCharactersInRange:NSMakeRange(nh2 % (tlen--), 1)];
    NSUInteger nhnum = nh1 + nh2 +nh3;
    NSString *mdkey = [[self md5:[[self md5:[[[self md5:[key stringByAppendingString:ch1]] stringByAppendingString:ch2] stringByAppendingString:ikey]] stringByAppendingString:ch3]] substringWithRange:NSMakeRange(nhnum%8, knum%8+16)];
    NSString *tmp = @"";
    int j = 0;
    int k = 0;
    NSUInteger strtlen = [strtxt length];
    NSUInteger klen = [mdkey length];
    for (int i = 0; i < strtlen; i++) {
        if (k == klen) {
            k = 0;
        }
        //txt i 位置的字符
        NSString *txti = [strtxt substringWithRange:NSMakeRange(i, 1)];
        //txt i 位置的字符 对应在 chars 中的位置
        NSRange range = [chars rangeOfString:txti];
        NSUInteger loc = range.location;
        int asc = [mdkey characterAtIndex:k++];
        j = (int)loc - (int)nhnum - asc ;
        while (j < 0) {
            j += 64;
        }
        NSString * charsj = [chars substringWithRange:NSMakeRange(j, 1)];
        tmp = [tmp stringByAppendingString:charsj];
    }
    NSString *tmp1 = [tmp stringByReplacingOccurrencesOfString:@"-" withString:@"+"];
    NSString *tmp2 = [tmp1 stringByReplacingOccurrencesOfString:@"_" withString:@"/"];
    NSString *strtmp = [tmp2 stringByReplacingOccurrencesOfString:@"." withString:@"="];
    //base64 解码
    NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:strtmp options:0];
    NSString *strtmpDecode = [[NSString alloc] initWithData:decodedData encoding:NSUTF8StringEncoding];
    //    NSLog(@"解密数据带时间戳：%@",strtmpDecode);
    //    如果 解码后 有时间戳存在 去掉这个时间戳
    NSRegularExpression *regex = [[NSRegularExpression alloc]initWithPattern:@"/\d{10}_/s" options:0 error: nil];
    if ([regex matchesInString:strtmpDecode options:0 range:NSMakeRange(0, 11)]) {
        
        strtmpDecode = [strtmpDecode substringFromIndex:11];
        
    }
    //    NSLog(@"解密数据： %@",strtmpDecode);
    return strtmpDecode;
}
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString{
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                         options:NSJSONReadingMutableContainers
                                                          error:&err];
    
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

+ (NSString *)dictionaryToJson:(NSDictionary *)dic{
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

}



@end
