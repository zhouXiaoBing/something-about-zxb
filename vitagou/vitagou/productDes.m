//
//  productDes.m
//  vitagou
//
//  Created by Mac on 2017/7/19.
//  Copyright © 2017年 Vitagou. All rights reserved.
//


#import "productDes.h"

@implementation productDes

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    self.backgroundColor = [UIColor whiteColor];
    
    self.width = Width;
    self.height = Width;
    
    _productName = [[UILabel alloc]init];
    _productName.font = [UIFont systemFontOfSize:14];
    _productName.textColor = [UIColor blackColor];
    [_productName setNumberOfLines:0];
    _productName.lineBreakMode = NSLineBreakByWordWrapping;
    
    _productDes = [[UILabel alloc]init];
    _productDes.font = [UIFont systemFontOfSize:12];
    _productDes.textColor = [UIColor grayColor];
    [_productDes setNumberOfLines:0];
    _productDes.lineBreakMode = NSLineBreakByWordWrapping;
    
    _productPrice = [[DiscountPriceView alloc]init];
    
    _countryImage = [[UIImageView alloc]init];
    
    _country = [[UILabel alloc]init];
    _country.font = [UIFont systemFontOfSize:10];
    _country.textColor = [UIColor blackColor];
    
    _distributionDes = [[UILabel alloc]init];
    _distributionDes.font = [UIFont systemFontOfSize:10];
    _distributionDes.textColor = [UIColor blackColor];
    
    _illustrate = [[UILabel alloc]init];
    _illustrate.font = [UIFont systemFontOfSize:12];
    _illustrate.textColor = [UIColor redColor];
    
    [self addSubview:_productName];
    [self addSubview:_productPrice];
    [self addSubview:_countryImage];
    [self addSubview:_distributionDes];
    [self addSubview:_country];
    [self addSubview:_illustrate];
    
    [_productName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.width.mas_equalTo(Width-20);
        make.height.mas_equalTo(Width/6);
    }];
    
   
    
    [_productPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_productName.mas_bottom);
        make.left.equalTo(self).offset(10);
        make.width.mas_equalTo(Width);
        make.height.mas_equalTo(Width/12);
    }];
    
    [_countryImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_productPrice.mas_bottom);
        make.left.equalTo(self).offset(10);
        make.width.mas_equalTo(Width/6);
        make.height.mas_equalTo(Width/6);
    }];
    
    [_country mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_productPrice.mas_bottom);
        make.left.equalTo(_countryImage.mas_right).offset(10);
        make.width.mas_equalTo(Width*5/6);
        make.height.mas_equalTo(Width/12);
    }];
    
    [_distributionDes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_country.mas_bottom);
        make.left.equalTo(_countryImage.mas_right).offset(10);
        make.width.mas_equalTo(Width*5/6);
        make.height.mas_equalTo(Width/12);
    }];
    
    
    [_illustrate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_distributionDes.mas_bottom);
        make.left.equalTo(self).offset(10);
        make.width.mas_equalTo(Width);
        make.height.mas_equalTo(Width/6);
    }];
    return self;
}

-(void)setProData:(zxb_product_data *)proData{
    _productName.text = proData.name;
    _productPrice.productData = proData;
    [_countryImage sd_setImageWithURL:[NSURL URLWithString:[VITAGOUURL stringByAppendingString:proData.agency.flag]] placeholderImage:[UIImage imageNamed:@"place_holder"]];
    _country.text = proData.agency.agency_name;
    _distributionDes.text = proData.agency.agency_desc;
    _illustrate.text = @"本品已经包邮包税，无需再额外缴纳";
}

@end
