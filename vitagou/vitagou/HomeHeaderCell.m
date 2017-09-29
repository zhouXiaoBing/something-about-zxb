//
//  HomeHeaderCell.m
//  vitagou
//
//  Created by Mac on 2017/6/9.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import "HomeHeaderCell.h"
//这个就可以对应是我的大标题  可以不用HomeCellTitleView 直接用这个
@interface HomeHeaderCell()

@property (nonatomic,strong) UILabel *titleLabel;

@end

@interface HomeFooterCell()
@property (nonatomic,strong) UILabel *titleLabel;
@end

@implementation HomeHeaderCell

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _titleLabel = [[UILabel alloc]init];
//        _titleLabel.text = @"新品特卖";
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = [UIColor colorWithRed:150/255.0 green:150/255.0  blue:150/255.0  alpha:1.0];
        [_titleLabel sizeToFit];
        
        [self addSubview:_titleLabel];
        UIView *leftLine = [[UIView alloc]init];
        UIView *rightLine = [[UIView alloc]init];
        UIColor *color = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1.0];
        leftLine.backgroundColor = color;
        rightLine.backgroundColor = color;
        [self addSubview:leftLine];
        [self addSubview:rightLine];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
        [leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(1);
            make.leading.equalTo(self).offset(10);
            make.centerY.equalTo(self);
            make.trailing.equalTo(_titleLabel.mas_leading).offset(-10);
        }];
        [rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.height.mas_equalTo(1);
            make.leading.equalTo(_titleLabel.mas_trailing).offset(10);
            make.trailing.equalTo(self).offset(-10);
        }];
    }
    return self;
}

- (void)showTitleLable:(BOOL)show {
    for (UIView *view in self.subviews) {
        view.hidden = !show;
    }
}

-(void)setTitle:(NSString *)str{
    _titleLabel.text = str;
}
@end

@implementation HomeFooterCell

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"点击查看更多商品 >";
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor colorWithRed:150/255.0 green:150/255.0  blue:150/255.0  alpha:1.0];
        [_titleLabel sizeToFit];
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self);
            make.width.mas_equalTo(self);
            make.centerY.equalTo(self);
        }];
    }
    return self;
}

@end
