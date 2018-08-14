//
//  HomeScrollView.m
//  vitagou
//
//  Created by Mac on 2018/8/10.
//  Copyright © 2018年 vitagou. All rights reserved.
//
#import "HomeScrollView.h"
@interface HomeScrollView ()<SDCycleScrollViewDelegate>

@end

@implementation HomeScrollView

NSArray *foucsImages;
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"initWithFrame_HomeScrollView");
        [self scrollView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

//- (SDCycleScrollView *)scrollView{
//    NSLog(@"首页轮播图：HomeScrollView");
//    _scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 44, kScreen_Width, kScreen_Width*9/16) imageURLStringsGroup:foucsImages];
//    NSLog(@"iamgeArray %lu",(unsigned long)self.imageArray.count);
////    self.scrollView = view;
//    [self addSubview:_scrollView];
//    return _scrollView;
//}


- (void)setImageArray:(NSArray *)imageArray{
    _scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 44, kScreen_Width, kScreen_Width*13/32) imageURLStringsGroup:imageArray];
    [self addSubview:_scrollView];
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    
}
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"被点击图片的index: %ld",(long)index);
}

@end
