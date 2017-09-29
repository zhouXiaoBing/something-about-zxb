

//
//  disCountPriceViewUpToDown.m
//  vitagou
//
//  Created by Mac on 2017/9/14.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import <Foundation/Foundation.h>
//现价  原价
#import "disCountPriceViewUpToDown.h"
#import "NSString+Extension.h"

@interface disCountPriceViewUpToDown()

@property (nonatomic,strong) UILabel *marketPriceLabel;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UIView *lineView;
@property (nonatomic) BOOL hasMarketPrice;

@end

@implementation disCountPriceViewUpToDown 


- (instancetype)init{
    if (self = [super init]) {
        _marketPriceLabel = [[UILabel alloc]init];
        _marketPriceLabel.font = [UIFont systemFontOfSize:11];
        [self addSubview:_marketPriceLabel];
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.textColor = [UIColor redColor];
        _priceLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:_priceLabel];
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor blackColor];
        [self addSubview:_lineView];
        
        //现在是平行的模式 改为上下
        [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self).offset(-15);
            make.centerX.equalTo(self);
        }];
        [_marketPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.leading.equalTo(_priceLabel.mas_trailing).offset(3);
            make.bottom.mas_equalTo(self).offset(-5);
            make.centerX.equalTo(self);
        }];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(_marketPriceLabel.mas_width);
            make.height.mas_equalTo(1);
            make.leading.equalTo(_marketPriceLabel);
            make.centerY.equalTo(_marketPriceLabel);
        }];
        

        
    }
    return self;
}

-(void)setCartGoods:(zxb_cart_goods *)cartGoods{
    self.priceLabel.text = [NSString stringWithFormat:@"￥%.2f",[cartGoods.goods_price doubleValue]];
    self.marketPriceLabel.text = [NSString stringWithFormat:@"￥%.2f",[cartGoods.market_price doubleValue]];
    [self.priceLabel sizeToFit];
    [self.marketPriceLabel sizeToFit];
    if ([cartGoods.goods_price isEqualToString:cartGoods.market_price]) {
        self.marketPriceLabel.hidden = YES;
        self.lineView.hidden = YES;
    }else{
        self.marketPriceLabel.hidden = NO;
        self.lineView.hidden = NO;
    }
}

@end
