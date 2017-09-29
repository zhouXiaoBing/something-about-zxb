//
//  cartCollectionViewHeadCell.m
//  vitagou
//
//  Created by Mac on 2017/9/7.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cartCollectionViewHeadCell.h"

@interface cartCollectionViewHeadCell ()

@property (nonatomic , strong) UIImageView *shopImage;

@property (nonatomic , strong) UILabel *shopName;

@property (nonatomic , strong) UILabel *shopAgency;

@property (nonatomic, strong) UIView *underView;

@end

@implementation cartCollectionViewHeadCell


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    
    self.backgroundColor = [UIColor whiteColor];
    
    _shopImage = [[UIImageView alloc]init];

    _shopName = [[UILabel alloc]init];
    _shopName.font = [UIFont systemFontOfSize:12];
    _shopName.textColor = [UIColor blackColor];
    [_shopName setNumberOfLines:0];
    _shopName.lineBreakMode = NSLineBreakByWordWrapping;
    
    _shopAgency = [[UILabel alloc]init];
    _shopAgency.font = [UIFont systemFontOfSize:12];
    _shopAgency.textColor = [UIColor blackColor];
    [_shopAgency setNumberOfLines:0];
    _shopAgency.lineBreakMode = NSLineBreakByWordWrapping;
    
    _underView = [[UIView alloc]init];
    _underView.backgroundColor = [UIColor grayColor];
    
    [self addSubview:_shopImage];
    [self addSubview:_shopName];
    [self addSubview:_shopAgency];
    [self addSubview:_underView];
    
    [_shopImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(10);
//        make.top.bottom.mas_equalTo(self);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(20);
        make.centerY.mas_equalTo(self);
    }];
    
    [_shopName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(35);
//        make.top.bottom.mas_equalTo(self);
        make.centerY.mas_equalTo(self);
        make.height.mas_equalTo(30);
    }];
    
    [_shopAgency mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-10);
//        make.top.bottom.mas_equalTo(self);
        make.centerY.mas_equalTo(self);
         make.height.mas_equalTo(30);
    }];
    
    [_underView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(Width);
        make.height.mas_equalTo(0.5);
        make.bottom.mas_equalTo(self.bottom).offset(-0.5);
    }];
    
    return self;
}

-(void)setAgencyDataGoods:(zxb_agency_data_goods *)agencyDataGoods{
    NSLog(@"true_name %@",agencyDataGoods.true_name);
    [_shopImage sd_setImageWithURL:[NSURL URLWithString:[VITAGOUURL stringByAppendingString:agencyDataGoods.seller_logo]] placeholderImage:[UIImage imageNamed:@"place_holder"]];
    
    _shopName.text = agencyDataGoods.true_name;
    
    _shopAgency.text = agencyDataGoods.agency;
    
}


@end

