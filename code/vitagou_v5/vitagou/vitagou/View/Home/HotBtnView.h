//
//  HotBtnView.h
//  vitagou
//
//  Created by Mac on 2018/8/14.
//  Copyright © 2018年 vitagou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotBtnView : NSObject

@property (nonatomic,copy) NSString *title;
@property (nonatomic,strong) UIImage *icon;
@property (nonatomic,strong) UIViewController *controller;
@property (nonatomic,assign) NSInteger tag;

+ (instancetype)titleIconWith:(NSString *)title icon:(UIImage *)image controller:(UIViewController *)controller tag:(NSInteger)tag;

@end
