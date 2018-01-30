//
//  mainCyrclePagerCell.m
//  collectionIos
//
//  Created by Mac on 2018/1/26.
//  Copyright © 2018年 Vitagou. All rights reserved.
//

#import "mainCyrclePagerCell.h"

@interface mainCyrclePagerCell()


@end

@implementation mainCyrclePagerCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //init imageView
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Width*9/16)];
        [self addSubview:image];
        _imageView = image;
//https://github.com/zhouXiaoBing/something-about-zxb/blob/master/pic/%E6%9A%97%E7%BA%A2%E7%99%BD%E6%A0%BC%E5%AD%90180x180.jpeg
    }
    return self;
}
@end
