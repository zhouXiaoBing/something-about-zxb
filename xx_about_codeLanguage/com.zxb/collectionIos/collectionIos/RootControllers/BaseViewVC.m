
//
//  BaseViewVC.m
//  collectionIos
//
//  Created by Mac on 2017/12/28.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import "BaseViewVC.h"
#import "MyRootViewController.h"

#pragma mark - UIViewController (Dismiss)
@interface UIViewController (Dismiss)
- (void)dismissModalVC;
@end
@implementation UIViewController (Dismiss)
- (void)dismissModalVC{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end


@interface BaseViewVC ()

@end

@implementation BaseViewVC


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    // bar 的风格
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];

}


- (void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    
}

-(void)viewDidLoad{
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];

}

+ (UIViewController *)presentingVC{
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    UIViewController *result = window.rootViewController;
    while (result.presentedViewController) {
        result = result.presentedViewController;
    }
    if ([result isKindOfClass:[MyRootViewController class]]) {
        result = [(MyRootViewController *)result selectedViewController];
    }
    if ([result isKindOfClass:[UINavigationController class]]) {
        result = [(UINavigationController *)result topViewController];
    }
    return result;
}

+ (void)presentVC:(UIViewController *)viewController{
    if (!viewController) {
        return;
    }
    UINavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:viewController];
    if (!viewController.navigationItem.leftBarButtonItem) {
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:viewController action:@selector(dismissModalVC)];
    }
    [[self presentingVC] presentViewController:nav animated:YES completion:nil];
}
+ (void)goToVC:(UIViewController *)viewController{
    if (!viewController) {
        return;
    }
    UINavigationController *nav = [self presentingVC].navigationController;
    if (nav) {
        [nav pushViewController:viewController animated:YES];
    }
}



@end
