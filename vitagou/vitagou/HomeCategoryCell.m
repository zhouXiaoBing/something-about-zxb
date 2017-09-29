//
//  HomeCategoryCell.m
//  vitagou
//
//  Created by Mac on 2017/5/10.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

/*
 
 */

#import "HomeCategoryCell.h"

@interface HomeCategoryCell ()
@property (nonatomic, strong) UIImageView *sortImage;
@end

@implementation HomeCategoryCell

- (instancetype)initWithFrame:(CGRect)frame
{
    NSLog(@"HomeCategoryCell on doing");
    self = [super initWithFrame:frame];
    if (self) {
        _sortImage = [[UIImageView alloc]init];
        [self addSubview:_sortImage];
    }
    
    [_sortImage mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.equalTo(self);
//        make.leading.equalTo(self).offset(10);
        
//        make.trailing.equalTo(self).offset(-10);
        make.size.mas_equalTo(CGSizeMake(300, 300));
//        make.height.equalTo(@100);
//        
//        make.width.equalTo(@100);
    }];
    
    
    for (int n = 0; n <= 5; n++) {
        [_sortImage setImage:[UIImage imageNamed:@"small_six"]];
    }
    
    return self;
}




@end

