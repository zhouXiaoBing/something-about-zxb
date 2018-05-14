//
//  ViewController.m
//  test
//
//  Created by Mac on 2018/5/14.
//  Copyright © 2018年 test. All rights reserved.
//

#import "ViewController.h"
#include<stdlib.h>

@interface ViewController ()

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"yyxk");
    [self encrypt];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)encrypt{
    NSString *txt = @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
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
}


@end
