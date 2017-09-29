//
//  productDes.h
//  vitagou
//
//  Created by Mac on 2017/7/19.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DiscountPriceView.h"
#import "zxb_product_data.h"

/*
 商品名称
 商品描述
 价格
 发货仓 +国旗 + 国家
 配送描述
 说明  写死字段。
 
 
 
 */
@interface productDes : UICollectionViewCell

@property(nonatomic,strong) UILabel *productName;

@property(nonatomic,strong) UILabel *productDes;

@property(nonatomic,strong) DiscountPriceView *productPrice;

@property(nonatomic,strong) UIImageView *countryImage;

@property(nonatomic,strong) UILabel *country;

@property(nonatomic,strong) UILabel *distributionDes;

@property(nonatomic,strong) UILabel *illustrate;

@property(nonatomic,strong) zxb_product_data *proData;

@end
