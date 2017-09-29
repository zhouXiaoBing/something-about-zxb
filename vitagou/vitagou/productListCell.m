//
//  productListCell.m
//  vitagou
//
//  Created by Mac on 2017/8/16.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import "productListCell.h"
#import "DiscountPriceView.h"

@interface productListCell ()

/** 背景图 */
@property (nonatomic,strong) UIImageView *backImageView;
/** 商品的图片 */
@property (nonatomic,strong) UIImageView *goodsImageView;
/** 商品名 */
@property (nonatomic,strong) UILabel *nameLabel;
/** 国家 */
@property (nonatomic,strong) UILabel *countryLabel;
/** 折扣 */
@property (nonatomic,strong) DiscountPriceView *discountPriceView;
/** 标签 */
@property (nonatomic,strong) UIButton *labelBtn;

@property(nonatomic ,strong) NSString *goods_id;

@end
@implementation productListCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }

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
    
    _countryLabel = [[UILabel alloc]init];
    _countryLabel.font = [UIFont systemFontOfSize:12];
    _countryLabel.textColor = [UIColor blackColor];
    
    _discountPriceView = [[DiscountPriceView alloc]init];
    
    _labelBtn = [[UIButton alloc]init];
    [_labelBtn setBackgroundColor:[UIColor grayColor]];
    [_labelBtn.layer setCornerRadius:5];
    _labelBtn.titleLabel.font = [UIFont systemFontOfSize: 10.0];
    [_labelBtn setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];

    [self addSubview:_backImageView];
    [self addSubview:_goodsImageView];
    [self addSubview:_nameLabel];
    [self addSubview:_countryLabel];
    [self addSubview:_discountPriceView];
    [self addSubview:_labelBtn];
    
    
    
    [_backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
        make.height.mas_equalTo(Width/3);
        make.width.mas_equalTo(Width);
    }];
    [_goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backImageView.mas_top);
        make.left.mas_equalTo(_backImageView.mas_left);
        make.width.mas_equalTo(Width/3+15);//这里的self。width 不一s定是有宽度值的e
        make.height.mas_equalTo(Width/3);
    }];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backImageView.mas_top).offset(5);
        make.left.equalTo(_backImageView.mas_left).offset(Width/3+20);
        make.width.mas_equalTo(Width*2/3-30);
        make.height.mas_equalTo(40);
    }];
    
    [_countryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_backImageView.mas_bottom).offset(-10);
        make.left.equalTo(_backImageView.mas_left).offset(Width/3+20);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    }];
    
    [_discountPriceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backImageView.mas_left).offset(Width/3+20);
        make.bottom.equalTo(_backImageView.mas_bottom).offset(-40);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(25);
    }];
    [_labelBtn mas_makeConstraints:^(MASConstraintMaker *make)//没有找出不现实的原因
     {
         
         make.bottom.equalTo(_backImageView.mas_bottom).offset(-10);
         
         make.right.equalTo(_backImageView.mas_right).offset(-10);
         
         make.size.mas_equalTo(CGSizeMake(60, 20));
     }];
    
    
    return self;
}

-(void)setListData:(zxb_list_data *)listData{
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:[VITAGOUURL stringByAppendingString:listData.img]] placeholderImage:[UIImage imageNamed:@"place_holder"]];
    
    _nameLabel.text = listData.name;
    _countryLabel.text = listData.agency_name;
    [_labelBtn setTitle: listData.brand_goods forState:UIControlStateNormal];
    _discountPriceView.listData= listData;
    _goods_id = listData.goods_id;
    
}

- (void)click
{
    
}

@end
