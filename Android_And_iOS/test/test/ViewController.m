//
//  ViewController.m
//  test
//
//  Created by Mac on 2018/5/14.
//  Copyright © 2018年 test. All rights reserved.
//

#import "ViewController.h"
#include <stdlib.h>
#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>


@interface ViewController ()

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"viewDidLoad");
    [self encrypt];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)encrypt{
    NSString *txt = @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-_.=+/";
    NSString *key = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    
    NSString *chars = @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_.";
    NSString *ikey = @"-x6g6ZWm2G9g_vr0Bo.pOq3kRIxsZ6rm";
    
    //生成随机数 3个
    int nh1 = rand()%64;
    int nh2 = rand()%64;
    int nh3 = rand()%64;
    
    NSLog(@"随机数1：%d",nh1);
    NSLog(@"随机数2：%d",nh2);
    NSLog(@"随机数3：%d",nh3);
    
//    NSString char1 = [NSStrin]
    
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
//    int asciiCode = [string characterAtIndex:0]; //65

    
    while (key != nil && i < key.length) {
//        NSLog(@"ascii ：%d",[key characterAtIndex:i]);
        knum += [key characterAtIndex:i];
        i++;
//        NSLog(@"ascii ：%d",[key characterAtIndex:i++]);
    }
    NSLog(@"ascii 码之和：%d",knum);
    
//    //第一次md5
//    NSString *mdKey1 = [self md5String:[key stringByAppendingString:ch1]];
//    //第二次md5
//    NSString *mdKey2 = [self md5String:[[mdKey1 stringByAppendingString:ch2] stringByAppendingString:ikey]];
    
    //三次md5
//    NSString *mdkey = [self md5String:[[self md5String:[[[self md5String:[key stringByAppendingString:ch1]] stringByAppendingString:ch2] stringByAppendingString:ikey]] stringByAppendingString:ch3]];
    //substr 截取 加密后的 字符串 16位
    NSString *mdkey = [[self md5String:[[self md5String:[[[self md5String:[key stringByAppendingString:ch1]] stringByAppendingString:ch2] stringByAppendingString:ikey]] stringByAppendingString:ch3]] substringWithRange:NSMakeRange(nhnum%8, knum%8+16)];
    NSLog(@"nhnum: %d",nhnum);
    NSLog(@"mdkey: %@",mdkey);

    
    //base64_encode + 时间戳 + 下划线 + 待加密string
    NSDate *datetime = [NSDate date];
    NSTimeZone *zone = [NSTimeZone timeZoneForSecondsFromGMT:8];
    NSInteger interval = [zone secondsFromGMTForDate:datetime];
    NSDate *localeDate = [datetime  dateByAddingTimeInterval: interval];
    NSString *unixtime = [NSString stringWithFormat:@"%.f", floor([localeDate timeIntervalSince1970])];
    NSLog(@"unixtime: %@",unixtime);
    NSString *str1 = [unixtime stringByAppendingString:@"_"];
    NSString *str2 = [str1 stringByAppendingString:txt];
    NSData *data = [str2 dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"txt before base64EncodedStringWithOptions: %@",txt);
    txt = [data base64EncodedStringWithOptions:0];
    NSLog(@"txt after base64EncodedStringWithOptions: %@",txt);
    
    NSString *rp1 = [txt stringByReplacingOccurrencesOfString:@"+" withString:@"-"];
    NSString *rp2 = [rp1 stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    txt = [rp2 stringByReplacingOccurrencesOfString:@"=" withString:@"."];
     NSLog(@"txt after stringByReplacingOccurrencesOfString: %@",txt);
    
    NSString *tmp =@"";
    
    NSUInteger tlen = [txt length];
    NSUInteger klen = [mdkey length];
    
    
    
    
    
    
}

 - (NSString *)md5String:(NSString *)str;{
     const char *original_str = [str UTF8String];
     unsigned char result[CC_MD5_DIGEST_LENGTH];
     CC_MD5(original_str, strlen(original_str), result);
     NSMutableString *hash = [NSMutableString string];
     for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
         [hash appendFormat:@"%02X", result[i]];
     return [hash lowercaseString];
}

@end
