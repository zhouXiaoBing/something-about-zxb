//
//  UIView+Common.m
//  collectionIos
//
//  Created by Mac on 2018/1/3.
//  Copyright © 2018年 Vitagou. All rights reserved.
//
/*
 UIView 相关的操作修改 比如 圆角 上划线
 */

#import "UIView+Common.h"

#define kTagLineView 1007 //边缘线的tag值


@implementation UIView (Common)

#pragma mark tabBar 边缘划线
- (void)addLineUp:(BOOL)hasUp andDown:(BOOL)hasDown{
    
    [self addLineUp:hasUp andDown:hasDown andColor:[UIColor grayColor]];
    
}

- (void)addLineUp:(BOOL)hasUp andDown:(BOOL)hasDown andColor:(UIColor *)color{
    
    return [self addLineUp:hasUp andDown:hasDown andColor:color andLeftSpace:0];
    
}

- (void)addLineUp:(BOOL)hasUp andDown:(BOOL)hasDown andColor:(UIColor *)color andLeftSpace:(CGFloat)leftSpace{
    
    [self removeViewWithTag:kTagLineView];
    
    if (hasUp) {
        UIView *upView = [UIView lineViewWithPointYY:0 andColor:color andLeftSpace:leftSpace];
        upView.tag = kTagLineView;
        [self addSubview:upView];
    }
    
    if (hasDown) {
        UIView *downView = [UIView lineViewWithPointYY:CGRectGetMaxY(self.bounds)-0.5 andColor:color andLeftSpace:leftSpace];
        downView.tag = kTagLineView;
        [self addSubview:downView];
    }
    
}

- (void)removeViewWithTag:(NSInteger)tag{
    for (UIView *aView in [self subviews]) {
        if (aView.tag == tag) {
            [aView removeFromSuperview];
        }
    }
}

+ (UIView *)lineViewWithPointYY:(CGFloat)pointY{
    return [self lineViewWithPointYY:pointY andColor:[UIColor grayColor]];
}

+ (UIView *)lineViewWithPointYY:(CGFloat)pointY andColor:(UIColor *)color{
    return [self lineViewWithPointYY:pointY andColor:color andLeftSpace:0];
}

+ (UIView *)lineViewWithPointYY:(CGFloat)pointY andColor:(UIColor *)color andLeftSpace:(CGFloat)leftSpace{
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(leftSpace, pointY, kScreen_Width - leftSpace, 0.5)];
    
    lineView.backgroundColor = color;
    
    return lineView;
}


@end

