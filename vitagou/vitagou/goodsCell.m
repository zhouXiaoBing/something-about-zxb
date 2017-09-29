//
//  goodsCell.m
//  vitagou
//
//  Created by Mac on 2017/7/7.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import "goodsCell.h"
#import "ProductController.h"

@implementation goodsCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    
    self.backgroundColor = [UIColor whiteColor];
    //添加点击跳转
    _backImageView = [[UIImageView alloc]init];
    _backImageView.contentMode = UIViewContentModeCenter;
    [_backImageView setUserInteractionEnabled:YES];
    [_backImageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click)]];
    
    _goodsView = [[UIImageView alloc]init];
    [_goodsView setImage:[UIImage imageNamed:@"place_holder"]];//默认图片
    //多行显示
    _goodsName = [[UILabel alloc]init];
    _goodsName.font = [UIFont systemFontOfSize:12];
    _goodsName.textColor = [UIColor blackColor];
    [_goodsName setNumberOfLines:0];
    _goodsName.lineBreakMode = NSLineBreakByWordWrapping;
    
    _goodsDes = [[UILabel alloc]init];
    _goodsDes.font = [UIFont systemFontOfSize:14];
    _goodsDes.textColor = [UIColor blackColor];
    
    _goodsPrice = [[DiscountPriceView alloc]init];
    
    _lineView = [[UIView alloc]init];
    _lineView.backgroundColor = [UIColor grayColor];
    
    _lineView_ = [[UIView alloc]init];
    _lineView_.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
    
    [self addSubview:_backImageView];
    [self addSubview:_lineView];
    [self addSubview:_goodsView];
    [self addSubview:_goodsName];
    [self addSubview:_goodsDes];
    [self addSubview:_goodsPrice];
    [self addSubview:_lineView_];
    
    [_backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self).offset(1);
//        make.left.equalTo(self).offset(1);
//        make.right.equalTo(self).offset(-1);
//        make.bottom.equalTo(self).offset(-4);
        make.edges.equalTo(self);
    }];
    [_goodsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backImageView).offset(5);
        make.left.equalTo(_backImageView).offset(5);
        make.right.equalTo(_backImageView).offset(-5);
//        make.bottom.equalTo(_backImageView).offset(-5);
        make.width.mas_equalTo(Width/2);
        make.height.mas_equalTo(Width/2);
    }];
    
    [_goodsName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_goodsView.mas_bottom).offset(5);
        make.left.equalTo(_backImageView).offset(5);
        make.right.equalTo(_backImageView).offset(-5);
        make.centerX.equalTo(_backImageView.mas_centerX);
        make.height.mas_equalTo(30);
    }];
    
    [_goodsPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_lineView.mas_top).offset(-5);
//        make.right.equalTo(self).offset(-5);
//        make.bottom.equalTo(self).offset(-5);
        make.width.mas_equalTo(Width/2);
        make.height.mas_equalTo(15);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_goodsDes.mas_top).offset(-5);
        make.left.equalTo(_backImageView).offset(5);
        make.right.equalTo(_backImageView).offset(-5);
        make.width.mas_equalTo(Width/2);
        make.height.mas_equalTo(1);
    }];
    
    [_goodsDes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_lineView_.mas_bottom).offset(-10);
        make.centerX.equalTo(_backImageView.mas_centerX);
        make.height.mas_equalTo(15);
    }];
    
    //各item之间的分割线
    [_lineView_ mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_backImageView.mas_bottom);
        make.height.mas_equalTo(5);
        make.width.mas_equalTo(Width);
    }];

    return self;
}

-(void)setGoodsRecommend:(zxb_recommend_goods *)goodsRecommend{

    [self.goodsView sd_setImageWithURL:[NSURL URLWithString:[VITAGOUURL stringByAppendingString:goodsRecommend.img]] placeholderImage:[UIImage imageNamed:@"place_holder"]];
    
    _goodsName.text = goodsRecommend.name;
    
    _goodsPrice.goodsRecommend = goodsRecommend;
    
    _goodsDes.text = goodsRecommend.brand_goods;
    
    self.goods_id = goodsRecommend.goods_id;
}

-(void)setGoodsNew:(zxb_new_goods *)goodsNew{
    
    [self.goodsView sd_setImageWithURL:[NSURL URLWithString:[VITAGOUURL stringByAppendingString:goodsNew.img]] placeholderImage:[UIImage imageNamed:@"place_holder"]];
    
    _goodsName.text = goodsNew.name;
    
    _goodsPrice.goodsNew = goodsNew;
    
    _goodsDes.text = goodsNew.brand_goods;
    

}


- (void)click
{
    [AJNotification postNotificationName:ProductGoodsId object:self.goods_id ];
}
@end
