//
//  DiscountPriceView.m
//  vitagou
//
//  Created by Mac on 2017/6/8.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import <Foundation/Foundation.h>
//现价  原价
#import "DiscountPriceView.h"
#import "NSString+Extension.h"

@interface DiscountPriceView()

@property (nonatomic,strong) UILabel *marketPriceLabel;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UIView *lineView;
@property (nonatomic) BOOL hasMarketPrice;

@end

@implementation DiscountPriceView

- (instancetype)init{
    if (self = [super init]) {
        _marketPriceLabel = [[UILabel alloc]init];
        _marketPriceLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:_marketPriceLabel];
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.textColor = [UIColor redColor];
        _priceLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:_priceLabel];
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor blackColor];
        [self addSubview:_lineView];
        
        //现在是平行的模式 改为上下  
        [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self);
            make.centerY.equalTo(self);
        }];
        [_marketPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(_priceLabel.mas_trailing).offset(3);
            make.centerY.equalTo(self);
        }];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(_marketPriceLabel.mas_width);
            make.height.mas_equalTo(1);
            make.leading.equalTo(_marketPriceLabel);
            make.centerY.equalTo(_marketPriceLabel);
        }];
        
//        [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.leading.equalTo(self);
//            make.centerY.equalTo(self);
//        }];
//        [_marketPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.leading.equalTo(_priceLabel.mas_trailing).offset(3);
//            make.centerY.equalTo(self);
//            make.top.equalTo(_priceLabel.mas_bottom);
//        }];
//        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.width.mas_equalTo(_marketPriceLabel.mas_width);
//            make.height.mas_equalTo(1);
//            make.leading.equalTo(_marketPriceLabel);
//            make.centerY.equalTo(_marketPriceLabel);
//        }];
        
    }
    return self;
}

-(void)setGoods:(zxb_promotion *)goods {
//    NSLog(@"pro")
    self.priceLabel.text = [NSString stringWithFormat:@"￥%.2f",[goods.promote_price doubleValue]];
    self.marketPriceLabel.text = [NSString stringWithFormat:@"￥%.2f",[goods.market_price doubleValue]];
    [self.priceLabel sizeToFit];
    [self.marketPriceLabel sizeToFit];
    if ([goods.promote_price isEqualToString:goods.market_price]) {
        self.marketPriceLabel.hidden = YES;
        self.lineView.hidden = YES;
    }else{
        self.marketPriceLabel.hidden = NO;
        self.lineView.hidden = NO;
    }
}

-(void)setGoodsRecommend:(zxb_recommend_goods *)goodsRecommend{
    self.priceLabel.text = [NSString stringWithFormat:@"￥%.2f",[goodsRecommend.sell_price doubleValue]];
    self.marketPriceLabel.text = [NSString stringWithFormat:@"￥%.2f",[goodsRecommend.market_price doubleValue]];
    [self.priceLabel sizeToFit];
    [self.marketPriceLabel sizeToFit];
    if ([goodsRecommend.sell_price isEqualToString:goodsRecommend.market_price]) {
        self.marketPriceLabel.hidden = YES;
        self.lineView.hidden = YES;
    }else{
        self.marketPriceLabel.hidden = NO;
        self.lineView.hidden = NO;
    }
}

-(void)setGoodsNew:(zxb_new_goods *)goodsNew{
    self.priceLabel.text = [NSString stringWithFormat:@"￥%.2f",[goodsNew.sell_price doubleValue]];
    self.marketPriceLabel.text = [NSString stringWithFormat:@"￥%.2f",[goodsNew.market_price doubleValue]];
    [self.priceLabel sizeToFit];
    [self.marketPriceLabel sizeToFit];
    if ([goodsNew.sell_price isEqualToString:goodsNew.market_price]) {
        self.marketPriceLabel.hidden = YES;
        self.lineView.hidden = YES;
    }else{
        self.marketPriceLabel.hidden = NO;
        self.lineView.hidden = NO;
    }
}

-(void)setProductData:(zxb_product_data *)productData{
    self.priceLabel.text = [NSString stringWithFormat:@"￥%.2f",[productData.sell_price doubleValue]];
    self.marketPriceLabel.text = [NSString stringWithFormat:@"￥%.2f",[productData.market_price doubleValue]];
    [self.priceLabel sizeToFit];
    [self.marketPriceLabel sizeToFit];
    if ([productData.sell_price isEqualToString:productData.market_price]) {
        self.marketPriceLabel.hidden = YES;
        self.lineView.hidden = YES;
    }else{
        self.marketPriceLabel.hidden = NO;
        self.lineView.hidden = NO;
    }
}

-(void)setListData:(zxb_list_data *)listData{
    self.priceLabel.text = [NSString stringWithFormat:@"￥%.2f",[listData.sell_price doubleValue]];
    self.marketPriceLabel.text = [NSString stringWithFormat:@"￥%.2f",[listData.market_price doubleValue]];
    [self.priceLabel sizeToFit];
    [self.marketPriceLabel sizeToFit];
    if ([listData.sell_price isEqualToString:listData.market_price]) {
        self.marketPriceLabel.hidden = YES;
        self.lineView.hidden = YES;
    }else{
        self.marketPriceLabel.hidden = NO;
        self.lineView.hidden = NO;
    }
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
