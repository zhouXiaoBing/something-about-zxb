//
//  UIView+Frame.h
//  vitagou
//
//  Created by Mac on 2017/7/31.
//  Copyright © 2017年 Vitagou. All rights reserved.
//  快速存取UIView的frame成员(originX, originY, frameWidth, frameHeight)及center

#import <UIKit/UIKit.h>

@interface UIView (Frame)

//分类不能添加成员属性
//@property如果在分类里面，只会自动生成存、取方法的声明，而没有方法的实现
/**原点x*/
@property (nonatomic, assign) CGFloat originX;
/**原点y*/
@property (nonatomic, assign) CGFloat originY;
/**frame宽*/
@property (nonatomic, assign) CGFloat frameWidth;
/**frame高*/
@property (nonatomic, assign) CGFloat frameHeight;
/**center的x*/
@property (nonatomic, assign) CGFloat centerX;
/**center的y*/
@property (nonatomic, assign) CGFloat centerY;

@end
