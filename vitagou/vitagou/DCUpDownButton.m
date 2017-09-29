//
//  DCUpDownButton.m
//  CDDMall
//
//  Created by apple on 2017/6/15.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCUpDownButton.h"

// Controllers

// Models

// Views

// Vendors

// Categories

// Others


@interface DCUpDownButton ()



@end

@implementation DCUpDownButton
#pragma mark - Intial
-(void)setUp
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:12];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setUp];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.centerX = self.width * 0.5;
    self.imageView.centerY  =  self.height * 0.3;
    
    [self.titleLabel sizeToFit];
    self.titleLabel.centerX = self.width * 0.5;
    self.titleLabel.y  =  self.imageView.bottom + 5;
}

@end
