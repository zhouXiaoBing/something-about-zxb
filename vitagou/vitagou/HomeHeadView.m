//
//  HomeHeadView.m
//  vitagou
//
//  Created by Mac on 2017/5/5.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import "HomeHeadView.h"


@implementation HomeHeadView


-(NSArray *)hotBtnView
{
    //轮播图下面的特卖按钮
    if (!_hotBtnView) {
        _hotBtnView = @[
                        [HotBtnView titleIconWith:@"品牌汇" icon:[UIImage imageNamed:@"tab_home"] controller:nil tag:0],
                        [HotBtnView titleIconWith:@"购实惠" icon:[UIImage imageNamed:@"tab_home"] controller:nil tag:1],
                        [HotBtnView titleIconWith:@"全部分类" icon:[UIImage imageNamed:@"tab_home"] controller:nil tag:2]
                        ];
    }
    return  _hotBtnView;
    
    
}

- (instancetype)initWithHeadData:(zxb_home_data *)headData{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    NSMutableArray *foucsImages = [NSMutableArray array];
    [headData.index_slide enumerateObjectsUsingBlock:^(zxb_index_slide *obj,NSUInteger idx, BOOL * _Nonnull stop)
     {
         [foucsImages addObject:[VITAGOUURL stringByAppendingString:obj.img]];
     }];
    
    _scrollerPageView = [ScrollerPageView pageScroller:foucsImages placeHolderImage:[UIImage imageNamed:@"place_holder"]];
    //_scrollerPageView.backgroundColor = [UIColor orangeColor];
    
    _menuView = [[MenuView alloc]initMenus:self.hotBtnView WithLine:NO];
    
    
    [self addSubview:self.scrollerPageView];
    [self addSubview:self.menuView];
    
    
    
  
    [_scrollerPageView layoutIfNeeded];
    [_menuView layoutIfNeeded];
    
    [self.scrollerPageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self);
//        make.edges.equalTo(self);
        make.top.equalTo(self);
        make.trailing.equalTo(self);
        make.height.mas_equalTo(Width*0.37);
    }];
    [self.menuView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.equalTo(_scrollerPageView.mas_bottom);
         make.trailing.equalTo(self);
         make.leading.equalTo(self);
         make.height.mas_equalTo(80);
     }];
    return self;//返回值

}

- (void)setHeight:(CGFloat)height{
  //  _height = height;
    NSLog(@"通知高度 %f",height);
    [AJNotification postNotificationName:HomeTableHeadViewHeightDidChange
                                  object:[NSNumber numberWithFloat:height]];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.height = CGRectGetMaxY(self.menuView.frame);
}


-(void)setCallback:(ClikedCallback)callback{
    self.scrollerPageView.clikeCall = callback;
    NSLog(@"setCallback");
}

@end
