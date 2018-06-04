//
//  UIView+Common.h
//  collectionIos
//
//  Created by Mac on 2018/1/3.
//  Copyright © 2018年 Vitagou. All rights reserved.
//

@interface UIView (Common)

#pragma mark tabBar 边缘划线 
- (void)addLineUp:(BOOL)hasUp andDown:(BOOL)hasDown;
- (void)addLineUp:(BOOL)hasUp andDown:(BOOL)hasDown andColor:(UIColor *)color;
- (void)addLineUp:(BOOL)hasUp andDown:(BOOL)hasDown andColor:(UIColor *)color andLeftSpace:(CGFloat)leftSpace;

@end
