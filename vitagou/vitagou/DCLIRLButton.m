//
//  DCLIRLButton.m
//  CDDMall
//
//  Created by apple on 2017/6/27.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCLIRLButton.h"

// Controllers

// Models

// Views

// Vendors

// Categories

// Others

@interface DCLIRLButton ()



@end

@implementation DCLIRLButton

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.titleLabel sizeToFit];
    self.titleLabel.centerX = self.width * 0.55;
    self.imageView.x = self.titleLabel.x - self.imageView.width - 5;
}

#pragma mark - Setter Getter Methods

@end
