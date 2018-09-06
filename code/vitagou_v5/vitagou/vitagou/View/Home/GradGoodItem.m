//
//  GradGoodItem.m
//  vitagou
//
//  Created by Mac on 2018/9/6.
//  Copyright © 2018年 vitagou. All rights reserved.
//

#import "GradGoodItem.h"


@implementation GradGoodItem

- (instancetype)initWithFrame:(CGRect)frame
{
    NSLog(@"GradGoodItem_initWithFrame");
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
        make.width.mas_equalTo(kScreenWidth/2-10);
        make.height.mas_equalTo(kScreenWidth/2-10);
        make.centerX.equalTo(self);
    }];
    
    [_goodsName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.goodsView.mas_bottom);
        make.width.mas_equalTo(kScreenWidth/2-10);
        make.height.mas_equalTo(30);
    }];
    [_goodsPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.goodsName.mas_bottom);
        make.width.mas_equalTo(kScreenWidth/2-10);
        make.height.mas_equalTo(15);
    }];
    return self;
}
- (void)setGoodsItem:(goods_item *)goodsItem{
    NSLog(@"GradGoodsItem_setGoodsItem");
    [self.goodsView sd_setImageWithURL:[NSURL URLWithString:goodsItem.goods_image] placeholderImage:[UIImage imageNamed:@"place_holder"]];
    _goodsName.text = goodsItem.goods_name;
    _goodsPrice.text = [NSString stringWithFormat:@"￥%.2f",[goodsItem.goods_price doubleValue]];
}
@end

