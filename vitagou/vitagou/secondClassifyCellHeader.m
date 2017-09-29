//
//  secondClassifyCellHeader.m
//  vitagou
//
//  Created by Mac on 2017/9/1.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import "secondClassifyCellHeader.h"


@interface secondClassifyCellHeader ()

//头部标题
@property (strong, nonatomic) UILabel *headLabel;

@end

@implementation secondClassifyCellHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _headLabel = [[UILabel alloc]init];
        _headLabel.font = [UIFont systemFontOfSize:13];
        _headLabel.textColor = [UIColor darkGrayColor];
        _headLabel.textAlignment = NSTextAlignmentCenter;//居中
        [self addSubview: _headLabel];
        
        [_headLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(70, 25));
            make.centerX.equalTo(self);
        }];
    }
    return self;
}

//设置数据
-(void)setKeyWord:(NSString *)keyWord{
    _headLabel.text = keyWord;
}
@end
