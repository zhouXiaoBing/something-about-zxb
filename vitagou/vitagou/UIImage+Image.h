
//
//  UIImage+Image.h
//  vitagou
//
//  Created by Mac on 2017/8/2.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Image)


//类方法
/**
 *  根据图片名参数创建一个UIImage对象，并返回不渲染的原图
 *
 *  @param imageName 图片路径名
 *
 *  @return 没有经过渲染的原图
 */
+ (instancetype)originalImageNamed:(NSString *)imageName;

/**
 *  根据图片名参数创建一个UIImage对象，并将原图的高宽缩小1/2
 *
 *  @param imageName 图片路径名
 *
 *  @return 高宽为原图1/2的图片
 */
+ (instancetype)stretchableImageNamed:(NSString *)imageName;

@end

