//
//  productToolBar.m
//  vitagou
//
//  Created by Mac on 2017/8/2.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import "productToolBar.h"

@implementation productToolBar////collection consult addToCart toBuy

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    self.backgroundColor = [UIColor whiteColor];
    
    _collection = [[UIButton alloc]init];
//    _collection.image = [UIImage imageNamed:@"favorite_no"];
    UIImage *collectionImage = [UIImage imageNamed:@"favorite_no"];
    [_collection setImage:collectionImage forState:UIControlStateNormal];
    [_collection addTarget:self action:@selector(butClick_collection:) forControlEvents:UIControlEventTouchUpInside];
    
    _consult = [[UIButton alloc]init];
//    _consult.image = [UIImage imageNamed:@"counsel"];
    UIImage *consultImage = [UIImage imageNamed:@"counsel"];
     [_consult setImage:consultImage forState:UIControlStateNormal];
    [_consult addTarget:self action:@selector(butClick_consult:) forControlEvents:UIControlEventTouchUpInside];
    
    _addToCart = [[UIButton alloc]init];
//    _addToCart.titleLabel = @"加入购物车";
    [_addToCart setTitle:@"加入购物车" forState:UIControlStateNormal];
    _addToCart.backgroundColor = [UIColor yellowColor];
    [_addToCart addTarget:self action:@selector(butClick_addToCart:) forControlEvents:UIControlEventTouchUpInside];
    
    _toBuy = [[UIButton alloc]init];
    [_toBuy setTitle:@"立即购买" forState:UIControlStateNormal];
    _toBuy.backgroundColor = [UIColor redColor];
    [_toBuy addTarget:self action:@selector(butClick_toBuy:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_collection];
    
    [self addSubview:_consult];
    
    [self addSubview:_addToCart];
    
    [self addSubview:_toBuy];
    
    [_collection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.width.mas_equalTo(Width/4);
        make.height.mas_equalTo(45);
    }];
    
    [_consult mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(Width/4);
        make.width.mas_equalTo(Width/4);
        make.height.mas_equalTo(45);
    }];
    
    [_addToCart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(Width/2);
        make.width.mas_equalTo(Width/4);
        make.height.mas_equalTo(45);
    }];
    
    [_toBuy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(Width*3/4);
        make.width.mas_equalTo(Width/4);
        make.height.mas_equalTo(45);
    }];
    return self;
}

-(void)butClick_collection:(UIButton *)collection{
    NSLog(@"收藏");
}
-(void)butClick_consult:(UIButton *)consult{
    NSLog(@"咨询");
}
-(void)butClick_addToCart:(UIButton *)addToCart{
    NSLog(@"加入购物车");
}
-(void)butClick_toBuy:(UIButton *)toBuy{
    NSLog(@"购买");
}



@end
