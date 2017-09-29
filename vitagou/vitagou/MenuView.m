//
//  MenuView.m
//  vitagou
//
//  Created by Mac on 2017/6/2.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import "MenuView.h"
#import "TitleIconView.h"

/** 一行显示的个数  */
static const NSInteger DefaultRowNumbers = 3;

@interface MenuView()
@property (nonatomic,copy) NSArray<HotBtnView *> *menus;
@property (nonatomic) BOOL showLine;
@end

@implementation MenuView


- (instancetype)initMenus:(NSArray<HotBtnView *> *)menus WithLine:(BOOL)showLine {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        self.menus = menus;
        for (HotBtnView *menu in menus) {
            TitleIconView *titleIconView = [[TitleIconView alloc]initWithTitleLabel:menu.title icon:menu.icon boder:showLine];
            titleIconView.userInteractionEnabled = YES;
            titleIconView.tag = menu.tag;
            NSLog(@"menu.tag %ld",(long)menu.tag);
            
            //只是通过手势的操作指向了titleIconViewCliked这个方法，并不是带参数的方式 考虑直接在这个里面进行if else 判断后设定三个点击方法
            if (menu.tag == 0) {//品牌汇
                 UITapGestureRecognizer *tap0 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(titleIconViewCliked_brand)];
                [titleIconView addGestureRecognizer:tap0];
            }else if (menu.tag == 1){
                 UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(titleIconViewCliked_benefit)];
                [titleIconView addGestureRecognizer:tap1];
            }else{
                 UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(titleIconViewCliked_classify)];
                [titleIconView addGestureRecognizer:tap2];
            }
            [self addSubview:titleIconView];
        }
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat viewW = self.bounds.size.width / DefaultRowNumbers;
    CGFloat viewH = self.bounds.size.height / (self.menus.count / DefaultRowNumbers);
    
    for (NSInteger i = 0;i < self.subviews.count;i++) {
        TitleIconView *titleIconView = self.subviews[i];
        CGFloat viewX = (i % DefaultRowNumbers )* viewW;
        CGFloat viewY = (i / DefaultRowNumbers) * viewH;
        titleIconView.frame = CGRectMake(viewX,viewY, viewW,viewH);
    }
}
- (void)titleIconViewCliked_brand{

    NSLog(@"titleIconViewCliked_brand");
    [AJNotification postNotificationName:MenuViewNotification object:@"9999"];
}

- (void)titleIconViewCliked_benefit{
    
    NSLog(@"titleIconViewCliked_benefit");
    
}

- (void)titleIconViewCliked_classify{//从首页跳转到分类页
    
    NSLog(@"titleIconViewCliked_classify");
    [AJNotification postNotificationName:MenuViewNotification object:@"110"];
    
}

@end

