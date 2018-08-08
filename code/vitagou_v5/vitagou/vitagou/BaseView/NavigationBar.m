//
//  NavigationBar.m
//  vitagou
//
//  Created by Mac on 2018/7/16.
//  Copyright © 2018年 vitagou. All rights reserved.
//

#import "NavigationBar.h"


#define kStatusBarHeight [UIApplication sharedApplication].statusBarFrame.size.height

#define kDefaultNavBarHeight ([UIApplication sharedApplication].statusBarFrame.size.height + 44.0)

#define kSmallTouchSizeHeight 44.0

#define kLeftRightViewSizeMinWidth 60.0

#define kLeftMargin 0.0

#define kRightMargin 0.0

#define kNavBarCenterY(H) ((self.frame.size.height - kStatusBarHeight - H) * 0.5 + kStatusBarHeight)

#define kViewMargin 5.0

@implementation NavigationBar

#pragma mark - system

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super  initWithFrame: frame]) {
        [self setupNavigationBarUIOnce];
    }
    return  self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setupNavigationBarUIOnce];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.superview bringSubviewToFront:self];
    
    self.leftView.frame = CGRectMake(0,kStatusBarHeight,self.leftView.width,self.leftView.height);
    
    self.rightView.frame = CGRectMake(self.width - self.rightView.width, kStatusBarHeight, self.rightView.width, self.rightView.height);
    
    self.titleView.frame = CGRectMake(0, kStatusBarHeight + (44.0 - self.titleView.height) * 0.5, MIN(self.width - MAX(self.leftView.width, self.rightView.width) * 2 - kViewMargin * 2,self.titleView.width),self.titleView.height);
    
    self.titleView.x = (self.width * 0.5 - self.titleView.width * 0.5);
    
    self.bottomBlackLineView.frame = CGRectMake(0,self.height,self.width,0.5);
}

#pragma mark - Setter

- (void)setTitleView:(UIView *)titleView{
    [_titleView removeFromSuperview];
    [self addSubview:titleView];
    
    _titleView = titleView;
    
    __block BOOL isHaveTapGes = NO;
    
    [titleView.gestureRecognizers enumerateObjectsUsingBlock:^(__kindof UIGestureRecognizer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UITapGestureRecognizer class]]) {
            isHaveTapGes = YES;
            *stop = YES;
        }
    }];
    
    if(!isHaveTapGes){
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(titleClick:)];
        [titleView addGestureRecognizer:tap];
    }
    [self layoutIfNeeded];
}

- (void)setTitle:(NSMutableAttributedString *)title{
    if([self.dataSource respondsToSelector:@selector(NavigationBarTitleView:)] && [self.dataSource NavigationBarTitleView:self]){
        return;
    }
    
    /**头部标题*/
    UILabel *navTitleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width * 0.4, 44)];
    
    navTitleLable.numberOfLines = 0;//可能出现多行标题
    [navTitleLable setAttributedText:title];
    navTitleLable.textAlignment = NSTextAlignmentCenter;
    
    navTitleLable.backgroundColor = [UIColor clearColor];
    navTitleLable.userInteractionEnabled = YES;
    navTitleLable.lineBreakMode = NSLineBreakByClipping;
    
    self.titleView = navTitleLable;
    
}

- (void)setLeftView:(UIView *)leftView{
    [_leftView removeFromSuperview];
    [self addSubview:leftView];
    
    _leftView = leftView;
    
    if ([leftView isKindOfClass:[UIButton class]] ) {
        UIButton *btn = (UIButton *)leftView;
        
        [btn addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self layoutIfNeeded];
}

- (void)setBackgroundImage:(UIImage *)backgroundImage{
    _backgroundImage = backgroundImage;
    
    self.layer.contents = (id)backgroundImage.CGImage;
}

- (void)setRightView:(UIView *)rightView
{
    [_rightView removeFromSuperview];
    
    [self addSubview:rightView];
    
    _rightView = rightView;
    
    if ([rightView isKindOfClass:[UIButton class]]) {
        
        UIButton *btn = (UIButton *)rightView;
        
        [btn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self layoutIfNeeded];
}

- (void)setDataSource:(id<NavigationBarDataSource>)dataSource{
    _dataSource = dataSource;
    [self setupDataSourceUI];
}

#pragma mark - getter

- (UIView *)bottomBlackLineView{
    if (!_bottomBlackLineView) {
        CGFloat height = 0.5;
        UIView * bottomBlackLineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, height)];
        [self addSubview:bottomBlackLineView];
        _bottomBlackLineView = bottomBlackLineView;
        bottomBlackLineView.backgroundColor = [UIColor lightGrayColor];
    }
    return  _bottomBlackLineView;
}

#pragma mark - event

- (void)leftBtnClick:(UIButton *)btn{
    if ([self.Delegate respondsToSelector:@selector(leftButtonEvent:navigationBar:)]) {
        [self.Delegate leftButtonEvent:btn navigationBar:self];
    }
}

- (void)rightBtnClick:(UIButton *)btn{
    if ([self.Delegate respondsToSelector:@selector(rightButtonEvent:navigationBar:)]) {
        [self.Delegate rightButtonEvent:btn navigationBar:self];
    }
}

- (void)titleClick:(UIGestureRecognizer *)Tap{
    UILabel *view = (UILabel *)Tap.view;
    if ([self.Delegate respondsToSelector:@selector(titleClickEvent:navigationBar:)]) {
        [self.Delegate titleClickEvent:view navigationBar:self];
    }
}

#pragma mark - custom
- (void)setupDataSourceUI{
    /**导航条高度*/
    if ([self.dataSource respondsToSelector:@selector(NavigationHeight:)]) {
        self.size = CGSizeMake(kScreen_Width, [self.dataSource NavigationHeight:self]);
    }else{
        self.size = CGSizeMake(kScreen_Width, kDefaultNavBarHeight);
    }
    /** 是否显示底部黑线 */
    if ([self.dataSource respondsToSelector:@selector(NavigationIsHideBottomLine:)]) {
        if ([self.dataSource  NavigationIsHideBottomLine:self]){
            self.bottomBlackLineView.hidden = YES;
        }
    }
    /** 背景图片 */
    if ([self.dataSource respondsToSelector:@selector(NavigationBarBackgroundImage:)]) {
        self.backgroundImage = [self.dataSource NavigationBarBackgroundImage:self];
    }
    /** 背景色 */
    if ([self.dataSource respondsToSelector:@selector(NavigationBackgroundColor:)]) {
        self.backgroundColor = [self.dataSource NavigationBackgroundColor:self];
    }
    
    /** 导航条中间的 View */
    if ([self.dataSource respondsToSelector:@selector(NavigationBarTitleView:)]) {
        self.titleView = [self.dataSource NavigationBarTitleView:self];
    }else if ([self.dataSource respondsToSelector:@selector(NavigationBarTitle:)]){
        /** 头部标题 */
        self.title = [self.dataSource NavigationBarTitle:self];
    }
    /** 导航条左边的 View */
    /** 导航条左边的按钮 */
    if ([self.dataSource respondsToSelector:@selector(NavigationBarLeftView:)]) {
        self.leftView = [self.dataSource NavigationBarLeftView:self];
    }else if ([self.dataSource respondsToSelector:@selector(NavigationBarLeftButtonImage:navigationBar:)]){
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kSmallTouchSizeHeight, kSmallTouchSizeHeight)];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        
        UIImage * image = [self.dataSource NavigationBarLeftButtonImage:btn navigationBar:self];
        
        if (image) {
            [btn setImage:image forState:UIControlStateNormal];
        }
        self.leftView = btn;
    }
    
    /** 导航条右边的 view */
    /** 导航条右边的按钮 */
    if ([self.dataSource respondsToSelector:@selector(NavigationBarRightView:)]) {
        self.rightView = [self.dataSource NavigationBarRightView:self];
        
    }else if ([self.dataSource respondsToSelector:@selector(NavigationBarLeftButtonImage:navigationBar:)]){
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kLeftRightViewSizeMinWidth, kSmallTouchSizeHeight)];
        
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        
        UIImage *image = [self.dataSource NavigationBarRightButtonImage:btn navigationBar:self];
        
        if (image) {
            [btn setImage:image forState:UIControlStateNormal];
        }
        
        self.rightView = btn;
    }
}
- (void)setupNavigationBarUIOnce{
    self.backgroundColor = [UIColor redColor];
}

@end

