//
//  HomeHorizontalGoodItem.m
//  vitagou
//
//  Created by Mac on 2018/9/4.
//  Copyright © 2018年 vitagou. All rights reserved.
//
#import "HomeHorizontalGoodItem.h"

@interface HomeHorizontalGoodItem()

@property(nonatomic,strong) NSString *GoodsID;
@end

@implementation HomeHorizontalGoodItem 

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    self.backgroundColor = [UIColor whiteColor];
    
    _goodsView = [[UIImageView alloc]init];
    [_goodsView setUserInteractionEnabled:YES];
    [_goodsView addGestureRecognizer:[[UIGestureRecognizer alloc]initWithTarget:self action:@selector(click)]];
    _goodsName = [[UILabel alloc]init];
    _goodsName.font = [UIFont systemFontOfSize:12];
    _goodsName.textColor = [UIColor blackColor];
    [_goodsName setNumberOfLines:0];
    _goodsName.lineBreakMode = NSLineBreakByWordWrapping;
    
    _goodsPrice = [[UILabel alloc]init];
    _goodsPrice.font = [UIFont systemFontOfSize:14];
    _goodsPrice.textColor = [UIColor redColor];
    
    /*
      self.priceLabel.text = [NSString stringWithFormat:@"￥%.2f",[goods.promote_price doubleValue]];
     */
    [self addSubview:_goodsView];
    [self addSubview:_goodsName];
    [self addSubview:_goodsPrice];
    
    [_goodsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(5);
        make.left.equalTo(self).offset(5);
        make.right.equalTo(self).offset(-5);
        make.width.mas_equalTo(kScreenWidth/2);
        make.height.mas_equalTo(kScreenWidth/2);
    }];
    
    [_goodsName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.goodsView.mas_bottom).offset(5);
        make.width.mas_equalTo(kScreenWidth/2);
        make.height.mas_equalTo(30);
    }];
    [_goodsPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.goodsView.mas_bottom).offset(5);
        make.left.equalTo(self).offset(5);
        make.width.mas_equalTo(kScreenWidth/2);
        make.height.mas_equalTo(15);
    }];
    return self;
}

- (void)setSpecial:(special_pic_item *)special{
    [self.goodsView sd_setImageWithURL:[NSURL URLWithString:special.goods_iamge] placeholderImage:[UIImage imageNamed:@"place_holder"]];
    _goodsName.text = special.goods_name;
    _goodsPrice.text = [NSString stringWithFormat:@"￥%.2f",[special.goods_price doubleValue]];
    self.GoodsID = special.goods_id;
}


- (void)click{
    //添加通知至首页然后跳转详情
}
@end
