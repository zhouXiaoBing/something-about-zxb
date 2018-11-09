//
//  IntroductoryPagesHelper.h
//  lvdouyi
//
//  Created by Mac on 2018/9/7.
//  Copyright © 2018年 vitagou. All rights reserved.
//
#define kScreenWidthRatio  (UIScreen.mainScreen.bounds.size.width / 375.0)
#define kScreenHeightRatio (UIScreen.mainScreen.bounds.size.height / 667.0)
#define AdaptedWidth(x)  ceilf((x) * kScreenWidthRatio)
#define AdaptedHeight(x) ceilf((x) * kScreenHeightRatio)
#define AdaptedFontSize(R)     [UIFont systemFontOfSize:AdaptedWidth(R)]

#define ScreenWidth  [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height



#import <UIKit/UIKit.h>

@interface IntroductoryPagesHelper : NSObject

+ (instancetype)shareInstance;

+ (void)showIntroductoryPageView:(NSArray<NSString *> *)imageArray;

@end
