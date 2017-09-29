//
//  cartCollectionViewFootCell.m
//  vitagou
//
//  Created by Mac on 2017/9/7.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cartCollectionViewFootCell.h"

@interface  cartCollectionViewFootCell ()

@property (nonatomic, strong) UILabel *productNum;

@property (nonatomic, strong) UILabel *productTotalPrice;

@property (nonatomic, strong) UIButton *settleAccount;

@property (nonatomic, strong) UIView *underView;

@end

@implementation  cartCollectionViewFootCell

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (!self) {
        return  nil;
    }
    
    
    self.backgroundColor = [UIColor whiteColor];
    
    _productNum = [[UILabel alloc]init];
    _productNum.font = [UIFont systemFontOfSize:12];
    _productNum.textColor = [UIColor blackColor];
    [_productNum setNumberOfLines:0];
    _productNum.lineBreakMode = NSLineBreakByWordWrapping;
    
    _productTotalPrice = [[UILabel alloc]init];
    _productTotalPrice.font = [UIFont systemFontOfSize:12];
    _productTotalPrice.textColor = [UIColor blackColor];
    [_productTotalPrice setNumberOfLines:0];
    _productTotalPrice.lineBreakMode = NSLineBreakByWordWrapping;
    
    _settleAccount = [[UIButton alloc]init];
    [_settleAccount setBackgroundColor:[UIColor redColor]];
    [_settleAccount.layer setCornerRadius:5];
    _settleAccount.titleLabel.font = [UIFont systemFontOfSize: 12.0];
    [_settleAccount setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [_settleAccount setTitle:@"结算" forState:UIControlStateNormal];
    
    _underView = [[UIView alloc]init];
    _underView.backgroundColor = [UIColor grayColor];
    
    [self addSubview:_productNum];
    [self addSubview:_productTotalPrice];
    [self addSubview:_settleAccount];
    [self addSubview:_underView];
    
    [_productNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(10);
//        make.top.bottom.mas_equalTo(self);
        make.centerY.mas_equalTo(self);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(Width/3);
    }];
    
    [_productTotalPrice mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.bottom.mas_equalTo(self);
        make.centerX.mas_equalTo(self);
        make.centerY.mas_equalTo(self);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(Width/3);
    }];
    
    [_settleAccount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-10);
//        make.top.bottom.mas_equalTo(self);
        make.centerY.mas_equalTo(self);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(Width/5);
    }];
    
    [_underView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(Width);
        make.height.mas_equalTo(0.5);
        make.bottom.mas_equalTo(self.bottom).offset(-0.5);
    }];
    
    
    return  self;
}


-(void)setGoodsNum:(NSString *)goodsNum{

    _productNum.text = [[@"已选中" stringByAppendingString:goodsNum] stringByAppendingString:@"件商品"];
}

-(void)setTotalPrice:(NSString *)totalPrice{
    NSLog(@"setTotalPrice");
    _productTotalPrice.text = [[@"" stringByAppendingString:totalPrice] stringByAppendingString:@"元"];
    
}
    

@end
