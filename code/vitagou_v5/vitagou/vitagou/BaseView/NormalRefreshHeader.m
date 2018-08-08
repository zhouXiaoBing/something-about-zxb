

//
//  NormalRefreshHeader.m
//  vitagou
//
//  Created by Mac on 2018/7/19.
//  Copyright © 2018年 vitagou. All rights reserved.
//

#import "NormalRefreshHeader.h"

@implementation NormalRefreshHeader


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupUIOnce];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupUIOnce];
}

- (void)setupUIOnce
{
    self.automaticallyChangeAlpha = YES;
}

// MJBug fix
- (void)endRefreshing {
    [super endRefreshing];
    self.state = MJRefreshStateIdle;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
}

@end

