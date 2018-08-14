//
//  HotBtnView.m
//  vitagou
//
//  Created by Mac on 2018/8/14.
//  Copyright © 2018年 vitagou. All rights reserved.
//

#import "HotBtnView.h"
@implementation HotBtnView
+ (instancetype)titleIconWith:(NSString *)title icon:(UIImage *)image controller:(UIViewController *)controller tag:(NSInteger)tag {
    HotBtnView *titleIconAction = [[self alloc]init];
    titleIconAction.title = title;
    titleIconAction.icon = image;
    titleIconAction.controller = controller;
    titleIconAction.tag = tag;
    return titleIconAction;
}
@end

