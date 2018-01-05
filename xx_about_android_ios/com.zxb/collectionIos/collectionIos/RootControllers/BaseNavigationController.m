//
//  BaseNavigationController.m
//  collectionIos
//
//  Created by Mac on 2017/12/28.
//  Copyright © 2017年 Vitagou. All rights reserved.
//


#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@property (strong, nonatomic) UIView *navLineV;

@end

@implementation BaseNavigationController

- (void)viewDidLoad{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //藏旧
    [self hideBorderInView:self.navigationBar];
    //添新 这是一条线
    if (!_navLineV) {
        _navLineV = [[UIView alloc]initWithFrame:CGRectMake(0, 44, kScreen_Width, 1.0/ [UIScreen mainScreen].scale)];
        _navLineV.backgroundColor = [UIColor blackColor];
        [self.navigationBar addSubview:_navLineV];
    }
}

- (void)hideNavBottomLine{
    [self hideBorderInView:self.navigationBar];
    if (_navLineV) {
        _navLineV.hidden = YES;
    }
}

- (void)showNavBottomLine{
    _navLineV.hidden = NO;
}


- (void)hideBorderInView:(UIView *)view{
    if ([view isKindOfClass:[UIImageView class]]
        && view.frame.size.height <= 1) {
        view.hidden = YES;
    }
    for (UIView *subView in view.subviews) {
        [self hideBorderInView:subView];
    }
}

- (BOOL)shouldAutorotate{
    return [self.visibleViewController shouldAutorotate];
    
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return [self.visibleViewController preferredInterfaceOrientationForPresentation];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if (![self.visibleViewController isKindOfClass:[UIAlertController class]]) {//iOS9 UIWebRotatingAlertController
        return [self.visibleViewController supportedInterfaceOrientations];
    }else{
        return UIInterfaceOrientationMaskPortrait;
    }
}

@end
