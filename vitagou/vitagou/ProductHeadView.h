//
//  ProductHeadView.h
//  vitagou
//
//  Created by Mac on 2017/7/18.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

/*
 系统导航栏
 手动轮播图
 name
 描述
 价格
 
 
 所有内容都写到headView里面 自带滑动效果
 
 */
#import "ScrollerViewForProduct.h"
#import "zxb_product_data.h"
#import "zxb_photo.h"
#import "productDes.h"
#import "productComment.h"
@interface ProductHeadView : UIView

@property(nonatomic,strong) ScrollerViewForProduct *scrollerViewForPro;//轮播图
@property(nonatomic,strong) productDes *proDes;

-(instancetype)initWithData:(zxb_product_data *)productData;

@property(nonatomic,strong) zxb_product_data *proData;

@property (nonatomic, strong)  UIView *lineView;

@property (nonatomic, strong)  UIView *lineView2;

@property (nonatomic, strong)  productComment *productComment;

@property(nonatomic, strong) UIWebView *productDetailWebView;

 

@end
