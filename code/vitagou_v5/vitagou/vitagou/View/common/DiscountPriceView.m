//
//  DiscountPriceView.m
//  vitagou
//
//  Created by Mac on 2018/8/21.
//  Copyright © 2018年 vitagou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DiscountPriceView.h"
//#import "NSString+Extension.h"


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
        _marketPriceLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:_marketPriceLabel];
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.textColor = [UIColor redColor];
        _priceLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_priceLabel];
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor blackColor];
        [self addSubview:_lineView];
        
        [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self);
            make.centerY.equalTo(self);
        }];
        [_marketPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.priceLabel.mas_trailing).offset(3);
            make.centerY.equalTo(self);
        }];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(self.marketPriceLabel.mas_width);
            make.height.mas_equalTo(1);
            make.leading.equalTo(self.marketPriceLabel);
            make.centerY.equalTo(self.marketPriceLabel);
        }];
        
    }
     return self;
}

//- (void)setSellPrice:(NSString *)sellPrice{
//    self.priceLabel.text = [NSString stringWithFormat:@"￥%.2f",[sellPrice doubleValue]];
//}
//
//- (void)setMarketPrice:(NSString *)marketPrice{
//    self.marketPriceLabel.text = [NSString stringWithFormat:@"￥%.2f",[marketPrice doubleValue]];
//    self.marketPriceLabel.hidden = NO;
//    self.lineView.hidden = NO;


//}

- (void)sell_market_Price:(NSString *)sellPrice marketPrice:(NSString *)marketPrice{
    
    self.priceLabel.text = [NSString stringWithFormat:@"￥%.2f",[sellPrice doubleValue]];
    
    self.marketPriceLabel.text = [NSString stringWithFormat:@"￥%.2f",[marketPrice doubleValue]];
    
    [self.priceLabel sizeToFit];
    [self.marketPriceLabel sizeToFit];
    
    if ([sellPrice isEqualToString:marketPrice]) {
        self.marketPriceLabel.hidden = YES;
        self.lineView.hidden = YES;
    }else{
        self.marketPriceLabel.hidden = NO;
        self.lineView.hidden = NO;
    }
    
}
@end
