//
//  productMainController.h
//  vitagou
//
//  Created by Mac on 2017/7/26.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import "product.h"
#import "ProductHeadView.h"
#import "ScrollerViewForProduct.h"
#import "zxb_photo.h"
/*
 1.导航栏，系统的
 2.手动的viewpage
 3.UIlabel + discountView
 */

@interface productMainController : UIViewController

-(instancetype)initWithProductId:(NSString *)product_id;//参数是从上一级传过来的goods_id

@property(nonatomic,strong) NSString * goods_id;

@property(nonatomic,strong) product *product;

@property(nonatomic, strong) zxb_product_data *proData;

@property(nonatomic, strong) zxb_Result *result;

@property(nonatomic, strong) ProductHeadView *proView;

@property(nonatomic, strong) NSArray<zxb_photo *> *photoArray;

@end
