//
//  HomeNavBar.m
//  vitagou
//
//  Created by Mac on 2017/4/7.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

/*
 1.维他购的logo，没有任何操作
 2.搜索框，用来搜索商品//UIsearchBar
 3.跳转到分类的图标
 */
#import "HomeNavBar.h"

@interface HomeNavBar ()
{
    
    UIView *navbar;
//划分为3个部分1.logo 2.搜索 3.点击跳转分类页
UIView *grad_logo;
UIView *grad_search;
UIView *grad_go_category;
    
UIImageView *image_logo;
UIButton *button_go_category;


//搜索自定义样式
UIImageView *image_search;
UILabel *label_search;
    

    
}
@end

@implementation HomeNavBar

+(CGFloat)height
{
    return 44;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        CGFloat height = [HomeNavBar height];
        CGFloat grid_logo_width = kSelfWidth * 0.2;
        CGFloat grid_search_width = kSelfWidth * 0.7;
        CGFloat grid_go_category_width = kSelfWidth * 0.1;
        
        grad_logo = [[UIView alloc]initWithFrame:CGRectMake(0, 0, grid_logo_width, height)];
        grad_search = [[UIView alloc]initWithFrame:CGRectMake(grid_logo_width, 0, grid_search_width, height)];
        grad_go_category = [[UIView alloc]initWithFrame:CGRectMake(grid_logo_width+grid_search_width, 0, grid_go_category_width, height)];
        
        grad_logo.backgroundColor = kColorBlue;
        grad_search.backgroundColor = kColorRed;
        grad_go_category.backgroundColor = kColorMainGrey;
        
        [self addSubview:grad_logo];
        [self addSubview:grad_search];
        [self addSubview:grad_go_category];
        
        //公用变量
        CGFloat gridImageWidth = 24;
        CGFloat gridImageHeight = 24;
        CGFloat gridTopMargin = 3;
        CGFloat gridTitleTopMargin = 2;
        
        
        CGFloat gridTitleTop = gridTopMargin + gridImageHeight + gridTitleTopMargin;
        UIFont *gridTitleFont = [UIFont systemFontOfSize:12];
        UIColor *gridTitleColor = kColorWhite;
        
        
        image_logo = [UIImageView new];
        image_logo.image = [UIImage imageNamed:@"home_logo"];
        
        [grad_logo addSubview:image_logo];
        
        [image_logo mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.centerX.mas_equalTo(grad_logo.mas_centerX);
             make.top.mas_equalTo(gridTopMargin);
             make.width.mas_equalTo(gridImageWidth);
             make.height.mas_equalTo(gridImageHeight);
         
         }];
        
        
        
        
    }
    
  return self;
}

@end
