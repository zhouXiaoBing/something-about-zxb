//
//  ProductMainCell.m
//  vitagou
//
//  Created by Mac on 2017/7/27.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import "ProductMainCell.h"

@interface ProductMainCell ()

@end

@implementation ProductMainCell

-(void)setContentSubview:(UIView *)contentSubview {
    if (_contentSubview) {
        [_contentSubview removeFromSuperview];   // 移除之前的内容视图
    }
    _contentSubview = contentSubview;
    [self.contentView addSubview:contentSubview];
}

@end
