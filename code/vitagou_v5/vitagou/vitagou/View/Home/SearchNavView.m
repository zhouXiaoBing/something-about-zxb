//
//  SearchNavView.m
//  vitagou
//
//  Created by Mac on 2018/7/20.
//  Copyright © 2018年 vitagou. All rights reserved.
//


#import "SearchNavView.h"
/** StatusBar 高度*/
#define kStatusBarHeight [UIApplication sharedApplication].statusBarFrame.size.height
/** 默认的 nav高度 */
#define kDefaultNavBarHeight ([UIApplication sharedApplication].statusBarFrame.size.height + 44.0)
/** 可触摸的区域高度 */
#define kSmallTouchSizeHeight 44.0

#define kLeftRightViewSizeMinWidth 60.0

#define kLeftMargin 0.0

#define kRightMargin 0.0

#define kNavBarCenterY(H) ((self.frame.size.height - kStatusBarHeight - H) * 0.5 + kStatusBarHeight)

#define kViewMargin 5.0

@implementation SearchNavView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupNavigationBarUIOnce];
    }
    return  self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setupNavigationBarUIOnce];
}

- (void)layoutSubviews{
    NSLog(@"SearchView_layoutSubviews");
    [super layoutSubviews];
    [self.superview bringSubviewToFront:self];
//    UIImageView *logo = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 44)];
////    self.leftLogo.frame = CGRectMake(0, 0, 40, 44);
//    logo.backgroundColor = [UIColor redColor];
//    self.leftLogo.backgroundColor = [UIColor redColor];
//    [self addSubview:logo];
    [self setLeftLogo:_leftLogo];
    [self setSearchView:_searchView];
    [self setBottomSeparateLine:_bottomSeparateLine];
    
}

- (void)setupNavigationBarUIOnce{
    NSLog(@"SearchView_setupNavigationBarUIOnce");
    self.backgroundColor = [UIColor clearColor];
    
}

- (void)setLeftLogo:(UIImageView *)leftLogo{
    NSLog(@"SearchView_setLeftLogo");
    [leftLogo removeFromSuperview];
     leftLogo = [[UIImageView alloc]initWithFrame:CGRectMake(2, 2, kScreen_Width/4, 40)];
     [leftLogo setImage:[UIImage imageNamed:@"HomeLogo"]];
    leftLogo.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:leftLogo];
    [self layoutIfNeeded];
}

- (void)setSearchView:(UIButton *)searchView{
    
//    [_searchView removeFromSuperview];
   
    //searchView 的位置和形状
   searchView = [[UIButton alloc]initWithFrame:CGRectMake(kScreen_Width/4+10, 3, kScreen_Width*3/4-20, 38)];
    searchView.backgroundColor = grayzxb;
    searchView.layer.masksToBounds = YES;
    searchView.layer.cornerRadius = 12;
     [self addSubview:searchView];
    /**
     CGSize titleSize = button.titleLabel.bounds.size;
     CGSize imageSize = button.imageView.bounds.size;
     CGFloat interval = 1.0;
     button.imageEdgeInsets = UIEdgeInsetsMake(0,titleSize.width + interval, 0, -(titleSize.width + interval));
     button.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageSize.width + interval), 0, imageSize.width + interval);
     */
    
    [searchView setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    
    NSLog(@"searchView.frame.size.width %f",searchView.frame.size.width);
    float  width =  searchView.frame.size.width;
    [searchView setTitle:@"搜索" forState:UIControlStateNormal];
    searchView.imageEdgeInsets =UIEdgeInsetsMake(0,0,0,width*3/4);
    searchView.titleEdgeInsets = UIEdgeInsetsMake(0,0,0,width*3/4);
    [searchView addTarget:self action:@selector(searchViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self layoutIfNeeded];
}


-(void)setBottomSeparateLine:(UIView *)bottomSeparateLine{
    NSLog(@"SearchView_setBottomSeparateLine");
    CGFloat height = 0.5;
   bottomSeparateLine = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, height)];
    [self addSubview:bottomSeparateLine];
    bottomSeparateLine.backgroundColor = [UIColor grayColor];
    [self layoutIfNeeded];
}

- (void)searchViewBtnClick:(UIButton *)btn{
    if ([self.searchDelegate respondsToSelector:@selector(searchViewEvent:search:)]) {
        [self.searchDelegate searchViewEvent:btn search:self];
    }
}
@end
