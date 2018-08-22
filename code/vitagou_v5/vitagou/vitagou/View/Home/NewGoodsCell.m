//
//  NewGoodsCell.m
//  vitagou
//
//  Created by Mac on 2018/8/20.
//  Copyright © 2018年 vitagou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewGoodsCell.h"
#import "DiscountPriceView.h"

@interface NewGoodsCell()

/** 背景图 */
@property (nonatomic,strong) UIImageView *backImageView;
/** 商品的图片 */
@property (nonatomic,strong) UIImageView *goodsImageView;
/** 商品名 */
@property (nonatomic,strong) UILabel *nameLabel;
/** 折扣 */
@property (nonatomic,strong) DiscountPriceView *discountPriceView;
/** 购买 */
@property (nonatomic,strong) UIButton *buyBtn;

@property(nonatomic ,strong) NSString *goods_id;

@end

@implementation NewGoodsCell

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    NSLog(@"recommendgoods");//log中出现两次 说明执行了两次
    
    self.backgroundColor = [UIColor whiteColor];
    _backImageView = [[UIImageView alloc]init];
    _backImageView.contentMode = UIViewContentModeCenter;
    _goodsImageView = [[UIImageView alloc]init];
    [_goodsImageView setUserInteractionEnabled:YES];
    [_goodsImageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click)]];
    
    _nameLabel = [[UILabel alloc]init];
    _nameLabel.font = [UIFont systemFontOfSize:12];
    _nameLabel.textColor = [UIColor blackColor];
    [_nameLabel setNumberOfLines:0];
    _nameLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    _discountPriceView = [[DiscountPriceView alloc]init];
    
    
    _buyBtn = [[UIButton alloc]init];
    [_buyBtn setBackgroundColor:[UIColor colorWithRed:198/255.0 green:0/255.0 blue:44/255.0 alpha:1.0]];
    [_buyBtn.layer setCornerRadius:5];
    _buyBtn.titleLabel.font = [UIFont systemFontOfSize: 12.0];
    [_buyBtn setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    [_buyBtn setTitle:@"立即抢购" forState:UIControlStateNormal];
    [_buyBtn addTarget:self action:@selector(setBuyBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [self addSubview:_backImageView];
    [self addSubview:_goodsImageView];
    [self addSubview:_nameLabel];
    [self addSubview:_discountPriceView];
    [self addSubview:_buyBtn];
    
    [_backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
        make.height.mas_equalTo(kScreen_Width/3);
        make.width.mas_equalTo(kScreen_Width);
    }];
    [_goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backImageView.mas_top);
        
        make.left.mas_equalTo(_backImageView.mas_left);
        make.width.mas_equalTo(kScreen_Width/3+15);//这里的self。width 不一s定是有宽度值的e
        make.height.mas_equalTo(kScreen_Width/3);
    }];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backImageView.mas_top).offset(5);
        make.left.equalTo(_backImageView.mas_left).offset(kScreen_Width/3+20);
        make.width.mas_equalTo(kScreen_Width*2/3-30);
        make.height.mas_equalTo(40);
    }];
    [_discountPriceView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.equalTo(_backImageView.mas_left).offset(kScreen_Width/3+20);
        make.bottom.equalTo(_backImageView.mas_bottom).offset(-15);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(25);
    }];
    [_buyBtn mas_makeConstraints:^(MASConstraintMaker *make)//没有找出不现实的原因
     {
         
         make.bottom.equalTo(_backImageView.mas_bottom).offset(-15);
         
         make.right.equalTo(_backImageView.mas_right).offset(-10);
         
         make.size.mas_equalTo(CGSizeMake(60, 25));
     }];
    
    return self;
}
//-(void)setGoods:(week_new_item *)goods {//EXC_BAD_ACCESS  将model中的数据assign改为strong
//
//
//
//    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:[VITAGOUURL stringByAppendingString:goods.img]] placeholderImage:[UIImage imageNamed:@"place_holder"]];
//
//    _nameLabel.text = goods.name;
//
//    _discountPriceView.goods = goods;
//
//    _goods_id = goods.goods_id;
//    NSLog(@"goods.goods_id %@" ,goods.goods_id);
//}

- (void)setItem:(week_new_item *)item{
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:item.goods_image] placeholderImage:[UIImage imageNamed:@""]];
    
    self.nameLabel.text = item.goods_name;
    
    [self.discountPriceView sell_market_Price:item.goods_promotion_price marketPrice:item.goods_marketprice];
    
    // 需要的goods_id
    self.goods_id = item.goods_id;
}


- (void)click
{
    NSLog(@"Click 被点击 ！！！");
}


-(void)setBuyBtn:(UIButton *)buyBtn{
    NSLog(@"BuyBtn 被点击 ！！！");
    }

@end

