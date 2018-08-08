//
//  LMJIntroductoryPagesHelper.m
//  vitagou
//
//  Created by Mac on 2018/7/13.
//  Copyright © 2018年 vitagou. All rights reserved.
//

#import "LMJIntroductoryPagesHelper.h"
#import "LMJIntroductoryPagesView.h"

@interface LMJIntroductoryPagesHelper ()

@property (weak, nonatomic) UIWindow *curWindow;

@property (strong, nonatomic) LMJIntroductoryPagesView *curIntroductoryPagesView;

@end

@implementation LMJIntroductoryPagesHelper

static LMJIntroductoryPagesHelper *shareInstance_ = nil;
+ (instancetype)shareInstance{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance_ = [[LMJIntroductoryPagesHelper alloc]init];
    });
    return shareInstance_;
}

+ (void)showIntroductoryPageView:(NSArray<NSString *> *)imageArray{
    if (! [LMJIntroductoryPagesHelper shareInstance].curIntroductoryPagesView) {
        [LMJIntroductoryPagesHelper shareInstance].curIntroductoryPagesView = [LMJIntroductoryPagesView pagesViewWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height) images:imageArray];
    }
    
    [LMJIntroductoryPagesHelper shareInstance].curWindow = [UIApplication sharedApplication].keyWindow;
    [[LMJIntroductoryPagesHelper shareInstance].curWindow addSubview:[LMJIntroductoryPagesHelper shareInstance].curIntroductoryPagesView];
}

@end
