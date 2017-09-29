//
//  HotBtnView.h
//  vitagou
//
//  Created by Mac on 2017/6/2.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

/*
 
 */
#import <Foundation/Foundation.h>

@interface HotBtnView : NSObject

@property (nonatomic,copy) NSString *title;
@property (nonatomic,strong) UIImage *icon;
@property (nonatomic,strong) UIViewController *controller;
@property (nonatomic,assign) NSInteger tag;

+ (instancetype)titleIconWith:(NSString *)title icon:(UIImage *)image controller:(UIViewController *)controller tag:(NSInteger)tag;

@end
