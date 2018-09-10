//
//  IntroductoryPagesHelper.m
//  lvdouyi
//
//  Created by Mac on 2018/9/7.
//  Copyright © 2018年 vitagou. All rights reserved.
//

#import "IntroductoryPagesHelper.h"
#import "IntroductoryPagesView.h"

@interface IntroductoryPagesHelper ()

@property (weak, nonatomic) UIWindow * curWindow;

@property (strong, nonatomic) IntroductoryPagesView *curIntroductoryPagesView;

@end

@implementation IntroductoryPagesHelper

static IntroductoryPagesHelper *shareInstance_ = nil;

+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        shareInstance_ = [[IntroductoryPagesHelper alloc]init];
    });
    return shareInstance_;
}

+ (void)showIntroductoryPageView:(NSArray<NSString *> *)imageArray{
    NSLog(@"IntroductoryPagesHelper_showIntroductoryPageView");
    if (![IntroductoryPagesHelper shareInstance].curIntroductoryPagesView) {
        [IntroductoryPagesHelper shareInstance].curIntroductoryPagesView = [IntroductoryPagesView pagesViewWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) images:imageArray];
        [IntroductoryPagesHelper shareInstance].curWindow = [UIApplication sharedApplication].keyWindow;
        [[IntroductoryPagesHelper shareInstance].curWindow addSubview:[IntroductoryPagesHelper shareInstance].curIntroductoryPagesView];
    }
}


@end
