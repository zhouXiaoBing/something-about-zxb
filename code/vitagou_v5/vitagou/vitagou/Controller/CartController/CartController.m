//
//  CartController.m
//  vitagou
//
//  Created by Mac on 2018/7/19.
//  Copyright © 2018年 vitagou. All rights reserved.
//

#import "CartController.h"

@interface CartController ()

@property(nonatomic,strong) UIView *testView;

@end


@implementation CartController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.title = @"CartController";
    _testView = [[UIView alloc]initWithFrame:self.view.bounds];
    _testView.backgroundColor = [UIColor greenColor];
}


#pragma mark - NavgationBarDataSource
/** 头部标题 */
- (NSMutableAttributedString *)NavigationBarTitle:(NavigationBar *)navigationBar{
    return  nil;
}
/** 导航条左边的按钮 */
- (UIImage *)NavigationBarLeftButtonImage:(UIButton *)leftButton navigationBar:(NavigationBar *)navigationBar{
    return nil;
}
/** 背景色 */
- (UIImage *)NavigationBarBackgroundImage:(NavigationBar *)navigationBar{
    return nil;
}
/** 是否显示底部黑线 */
- (BOOL)NavigationIsHideBottomLine:(NavigationBar *)navigationBar{
    return  YES;
}
/** 导航条的高度 */
- (CGFloat)NavigationHeight:(NavigationBar *)navigationBar{
    return 44;
}
/** 导航条的左边的 view */
- (UIView *)NavigationBarLeftView:(NavigationBar *)navigationBar{
    return nil;
}
/** 导航条右边的 view */
- (UIView *)NavigationBarRightView:(NavigationBar *)navigationBar{
    return nil;
}
/** 导航条中间的 View */
- (UIView *)NavigationBarTitleView:(NavigationBar *)navigationBar{
    return nil;
}
/** 导航条右边的按钮 */
- (UIImage *)NavigationBarRightButtonImage:(UIButton *)rightButton navigationBar:(NavigationBar *)navigationBar{
    return  nil;
}

#pragma mark - NavgationBarDelegate

/** 左边的按钮的点击 */
-(void)leftButtonEvent:(UIButton *)sender navigationBar:(NavigationBar *)navigationBar{
    
}
/** 右边的按钮的点击 */
-(void)rightButtonEvent:(UIButton *)sender navigationBar:(NavigationBar *)navigationBar{
    
}
/** 中间如果是 label 就会有点击 */
-(void)titleClickEvent:(UILabel *)sender navigationBar:(NavigationBar *)navigationBar{
    
}

@end
