//
//  HomeHeadView.h
//  vitagou
//
//  Created by Mac on 2017/5/5.
//  Copyright © 2017年 Vitagou. All rights reserved.
//
/*
 包含轮播图 以及跳转的button
 */

#import <Foundation/Foundation.h>
#import "ScrollerPageView.h"
#import "zxb_home.h"
#import "zxb_home_data.h"
#import "TabHomeController.h"
#import "HotBtnView.h"
#import "MenuView.h"
@interface HomeHeadView : UIView

@property(nonatomic,strong) ScrollerPageView *scrollerPageView;//轮播图
@property (nonatomic,strong) NSArray *hotBtnView;

@property(nonatomic,strong) MenuView *menuView;//跳转button
@property (nonatomic, assign) CGFloat height;

- (instancetype)initWithHeadData:(zxb_home_data *)headData;

@property (nonatomic, copy) ClikedCallback callback;

@end
