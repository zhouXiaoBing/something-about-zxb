//
//  secondClassifyCellFlag.m
//  vitagou
//
//  Created by Mac on 2017/9/1.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "secondClassifyCellFlag.h"

@implementation secondClassifyCellFlag

-(instancetype)initWithFrame:(CGRect)frame{
    NSLog(@"secondClassifyCell in");
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont systemFontOfSize:12];
    _titleLabel.textColor = [UIColor blackColor];
    
    _titleImageView = [[UIImageView alloc]init];
    
    
    [self addSubview:_titleImageView];
    [self addSubview:_titleLabel];
    
    [_titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.mas_equalTo((Width-70)/2-10);
        //        make.height.mas_equalTo(Width*1/2);
        make.height.mas_equalTo((Width-70)/2-2-50);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(_titleImageView.mas_bottom).offset(10);
    }];
    
    
    
    
    return  self;
}



-(void)setClassify_two_data:(zxb_classify_two_data *)classify_two_data{
    NSLog(@"setClassify_two_data.name  %@", classify_two_data.name);
    [_titleImageView sd_setImageWithURL:[NSURL URLWithString:[VITAGOUURL stringByAppendingString:classify_two_data.img]] placeholderImage:[UIImage imageNamed:@"place_holder"]];
    
    _titleLabel.text = classify_two_data.name;
}

@end

