//
//  recommendGoodsArray.m
//  vitagou
//
//  Created by Mac on 2017/6/12.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import "recommendGoodsArray.h"
#import "recommendgood.h"

@interface recommendGoodsArray()

@property (strong, nonatomic)  recommendgood *goodsView;
@end

@implementation recommendGoodsArray 
/**
self.subviews.count 这里是根据产品设计是显示两个推荐，如果接口给的是三个商品的数据，这里会出现问题 可以换成promotiongoods.count来给定数量
 */






- (instancetype)init
{
    self = [super init];
    NSLog(@"recommendGoodsArray-------------------");
    if (self ) {
        for (NSInteger i=0; i<2; i++) {
            recommendgood *cell = [[recommendgood alloc]init];
            cell.layer.borderColor =[UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0].CGColor;
            cell.layer.borderWidth = 0.5;
            [self addSubview:cell]; 
        }
    }
    return self; 
}





////确定good的布局显示
-(void)layoutSubviews{
    [super layoutSubviews];
     NSLog(@"layoutSubviews------------------recommendGoodsArray");
    CGFloat cellheight = Width/3;//这里不做确定 看是否可以由good的布局来实现高度
    CGFloat cellWidth = Width;
    for (NSInteger i = 0; i < 2; i++) {
         recommendgood *cell =  self.subviews[i];
         cell.frame = CGRectMake(0, i*cellheight , cellWidth, cellheight);//与之上矛盾 没有找到自适应子类高度的代码,,横向排列和竖向排列
    }


}

//填充数据 应该可以
-(void)setData:(zxb_home_data *)data{
    NSLog(@"data.promotion.countddd %lu",data.promotion.count);
    //  _goodsView = [[recommendgood alloc]init];
    for (zxb_promotion *pro in data.promotion) {
        recommendgood *cell =[[recommendgood alloc]init];
        cell.goods = pro;
        NSLog(@"marketprice %@",pro.market_price);
    }
}



@end
