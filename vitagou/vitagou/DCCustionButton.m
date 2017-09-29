//
//  DCCustionButton.m
//  CDDMall
//
//  Created by apple on 2017/6/13.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCCustionButton.h"

// Controllers

// Models

// Views

// Vendors

// Categories

// Others

@interface DCCustionButton ()



@end

@implementation DCCustionButton

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{
    self.titleLabel.font = [UIFont systemFontOfSize:14];
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    
    [self sizeToFit];
    
    //计算完加一个艰巨
    self.width += 10;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.x = self.width * 0.3;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + 10;
}
#pragma mark - Setter Getter Methods

@end
