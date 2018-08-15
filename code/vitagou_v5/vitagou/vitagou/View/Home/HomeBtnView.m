//
//  HomeBtnView.m
//  vitagou
//
//  Created by Mac on 2018/8/14.
//  Copyright © 2018年 vitagou. All rights reserved.
//


#import "HomeBtnView.h"

@implementation HomeBtnView



- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"HomeBtnView ...");
        
        _menuView = [[MenuView alloc]initMenus:self.hotBtnView WithLine:NO];
        
        [self addSubview:_menuView];
        
        [self.menuView mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.leading.equalTo(self);
             make.top.equalTo(self);
             make.trailing.equalTo(self);
             make.leading.equalTo(self);
             make.height.mas_equalTo(80);
         }];
    }
    return self;
}

- (NSArray *)hotBtnView{
    NSLog(@"- (NSArray *)hotBtnView;");
    //轮播图下面的特卖按钮
    if (!_hotBtnView) {
        _hotBtnView = @[
                        [HotBtnView titleIconWith:@"品牌汇" icon:[UIImage imageNamed:@"brand"] controller:nil tag:0],
                        [HotBtnView titleIconWith:@"购实惠" icon:[UIImage imageNamed:@"cheapbuy"] controller:nil tag:1],
                        [HotBtnView titleIconWith:@"全部分类" icon:[UIImage imageNamed:@"all_categary"] controller:nil tag:2]
                        ];
    }
    return  _hotBtnView;
}



@end


