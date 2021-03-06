//
//  HomeHorizontalGoodItem.m
//  vitagou
//
//  Created by Mac on 2018/9/4.
//  Copyright © 2018年 vitagou. All rights reserved.
//
#import "HomeHorizontalGoodItem.h"


@implementation HomeHorizontalGoodItem 

- (instancetype)initWithFrame:(CGRect)frame
{
    NSLog(@"HomeHorizontalGoodItem_initWithFrame");
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    self.backgroundColor = [UIColor whiteColor];
    _goodsView = [[UIImageView alloc]init];
    _goodsName = [[UILabel alloc]init];
    _goodsName.font = [UIFont systemFontOfSize:12];
    _goodsName.textColor = [UIColor blackColor];
    [_goodsName setNumberOfLines:0];
    _goodsName.lineBreakMode = NSLineBreakByWordWrapping;
    _goodsPrice = [[UILabel alloc]init];
    _goodsPrice.font = [UIFont systemFontOfSize:14];
    _goodsPrice.textColor = [UIColor redColor];
    
    
    [self addSubview:_goodsView];
    [self addSubview:_goodsName];
    [self addSubview:_goodsPrice];
    
    [_goodsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.width.mas_equalTo(kScreenWidth/3);
        make.height.mas_equalTo(kScreenWidth/3);
        make.centerX.equalTo(self);
    }];
    
    [_goodsName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.goodsView.mas_bottom);
        make.width.mas_equalTo(kScreenWidth/3);
        make.height.mas_equalTo(30);
    }];
    [_goodsPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.goodsName.mas_bottom);
        make.width.mas_equalTo(kScreenWidth/3);
        make.height.mas_equalTo(15);
    }];
    return self;
}

- (void)setSpecial:(special_pic_item *)special{
    NSLog(@"HomeHorizontalGoodItem_setSpecial");
    [self.goodsView sd_setImageWithURL:[NSURL URLWithString:special.goods_image] placeholderImage:[UIImage imageNamed:@"place_holder"]];
    _goodsName.text = special.goods_name;
    _goodsPrice.text = [NSString stringWithFormat:@"￥%.2f",[special.goods_price doubleValue]];
    
}
@end
