//
//  NavigationBar.h
//  vitagou
//
//  Created by Mac on 2018/7/16.
//  Copyright © 2018年 vitagou. All rights reserved.
//

#import <UIKit/UIKit.h>


@class NavigationBar;

@protocol NavigationBarDataSource<NSObject>

@optional

/** 头部标题 */
- (NSMutableAttributedString*)NavigationBarTitle:(NavigationBar *)navigationBar;
/** 背景图片 */
- (UIImage *)NavigationBarBackgroundImage:(NavigationBar *)navigationBar;
/** 背景色 */
- (UIColor *)NavigationBackgroundColor:(NavigationBar *)navigationBar;
/** 是否显示底部黑线 */
- (BOOL)NavigationIsHideBottomLine:(NavigationBar *)navigationBar;
/** 导航条的高度 */
- (CGFloat)NavigationHeight:(NavigationBar *)navigationBar;
/** 导航条的左边的 view */
- (UIView *)NavigationBarLeftView:(NavigationBar *)navigationBar;
/** 导航条右边的 view */
- (UIView *)NavigationBarRightView:(NavigationBar *)navigationBar;
/** 导航条中间的 View */
- (UIView *)NavigationBarTitleView:(NavigationBar *)navigationBar;
/** 导航条左边的按钮 */
- (UIImage *)NavigationBarLeftButtonImage:(UIButton *)leftButton navigationBar:(NavigationBar *)navigationBar;
/** 导航条右边的按钮 */
- (UIImage *)NavigationBarRightButtonImage:(UIButton *)rightButton navigationBar:(NavigationBar *)navigationBar;
@end

@protocol NavigationBarDelegate <NSObject>

@optional
/** 左边的按钮的点击 */
-(void)leftButtonEvent:(UIButton *)sender navigationBar:(NavigationBar *)navigationBar;
/** 右边的按钮的点击 */
-(void)rightButtonEvent:(UIButton *)sender navigationBar:(NavigationBar *)navigationBar;
/** 中间如果是 label 就会有点击 */
-(void)titleClickEvent:(UILabel *)sender navigationBar:(NavigationBar *)navigationBar;
@end

@interface NavigationBar : UIView

/** 底部的黑线 */
@property (weak, nonatomic) UIView *bottomBlackLineView;

/** <#digest#> */
@property (weak, nonatomic) UIView *titleView;

/** <#digest#> */
@property (weak, nonatomic) UIView *leftView;

/** <#digest#> */
@property (weak, nonatomic) UIView *rightView;

/** <#digest#> */
@property (nonatomic, copy) NSMutableAttributedString *title;

/** <#digest#> */
@property (weak, nonatomic) id<NavigationBarDataSource> dataSource;

/** <#digest#> */
@property (weak, nonatomic) id<NavigationBarDelegate> Delegate;

/** <#digest#> */
@property (weak, nonatomic) UIImage *backgroundImage;

@end


