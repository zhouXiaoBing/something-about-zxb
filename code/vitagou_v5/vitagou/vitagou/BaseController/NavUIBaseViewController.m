//
//  NavUIBaseViewController.m
//  vitagou
//
//  Created by Mac on 2018/7/16.
//  Copyright © 2018年 vitagou. All rights reserved.
//

#import "NavUIBaseViewController.h"


@implementation NavUIBaseViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    NSLog(@"NavUIBaseViewController_viewDidload");
    Weak(self);
    //在dealloc移除，内存管理
    [self.navigationItem addObserverBlockForKeyPath:KeyPath(self.navigationItem, title) block:^(id  _Nonnull obj, id  _Nonnull oldVal, NSString  *_Nonnull newVal) {
        if (newVal.length > 0 && ![newVal isEqualToString:oldVal]) {
            weakself.title = newVal;
        }
    }];
}

#pragma mark - 生命周期
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
}

- (void)viewDidLayoutSubviews{
    NSLog(@"NavUIBaseViewController_viewDidLayoutSubviews");
    [super viewDidLayoutSubviews];
    self.navigationBar.width = self.view.width;
    [self.view  bringSubviewToFront:self.navigationBar];//前台展示
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)dealloc
{
    [self.navigationItem removeObserverBlocksForKeyPath:KeyPath(self.navigationItem, title)];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return  UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden{
    return NO;
}

#pragma mark - DataSource
- (BOOL)navUIBaseViewControllerIsNeedNavBar:(NavUIBaseViewController *)navUIBaseViewController{
    return YES;
}

/** 头部标题 */
- (NSMutableAttributedString *)NavigationBarTitle:(NavigationBar *)navigationBar{
    return [self changeTitle:self.title ?:self.navigationItem.title];
}

/** 背景图片 */

/** 背景色 */
- (UIColor *)NavigationBackgroundColor:(NavigationBar *)navigationBar{
    return  [UIColor whiteColor];
}

/** 是否显示底部黑线 */

/** 导航条高度 */

- (CGFloat)NavigationHeight:(NavigationBar *)navigationBar{
NSLog(@"NavUIBaseViewController_NavigationHeight");
    return [UIApplication sharedApplication].statusBarFrame.size.height + 44.0;
}

/** 导航条的左边的 view */
/** 导航条右边的 view */
/** 导航条中间的 View */
/** 导航条左边的按钮 */
/** 导航条右边的按钮 */

#pragma mark - Delefate
/** 左边按钮的点击 */

- (void)rightButtonEvent:(UIButton *)sender navigationBar:(NavigationBar *)navigationBar{
    NSLog(@"%s", __func__);
}
- (void)titleClickEvent:(UILabel *)sender navigationBar:(NavigationBar *)navigationBar{
    NSLog(@"%s", __func__);
}
- (void)leftButtonEvent:(UIButton *)sender navigationBar:(NavigationBar *)navigationBar{
    NSLog(@"%s", __func__);
}

#pragma mark - 自定义代码

- (NSMutableAttributedString *)changeTitle:(NSString *)curTitle{
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:curTitle ?: @""];
    
    [title addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, title.length)];
    
    [title addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:17] range:NSMakeRange(0, title.length)];
    
    return title;
}

//初始化了navigation
- (NavigationBar *)navigationBar{
    NSLog(@"NavUIBaseViewController_navigationBar");
    //父控制器必须是导航控制器
    NSLog(@"Controller_type %@",self.parentViewController);
    if (_navigationBar &&[self.parentViewController isKindOfClass:[UINavigationController class]]) {
        NSLog(@"NavUIBaseViewController_if");
        NavigationBar * navigationBar = [[NavigationBar alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 0)];
        [self.view addSubview:navigationBar];

        _navigationBar = navigationBar;

        navigationBar.dataSource = self;
        navigationBar.Delegate = self;
        navigationBar.hidden = ![self navUIBaseViewControllerIsNeedNavBar:self];
    }

    return  _navigationBar;

}

- (void)setTitle:(NSString *)title{
    [super setTitle:title];
    self.navigationBar.title = [self changeTitle:title];
}

@end
