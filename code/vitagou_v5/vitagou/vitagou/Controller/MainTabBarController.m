//
//  MainTabBarController.m
//  vitagou
//
//  Created by Mac on 2018/7/13.
//  Copyright © 2018年 vitagou. All rights reserved.
//

#import "MainTabBarController.h"
#import "MyNavigationController.h"
#import "HomeController.h"
#import "CartController.h"
#import "UseController.h"

@interface MainTabBarController ()<UITabBarControllerDelegate>

@end

@implementation MainTabBarController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self addChildViewControllers];
    [self addTabarItems];
    self.delegate = self;
}

- (void)customIsInGod:(NSNotification *)noti{
    if (![noti.object boolValue]) {
        return;
    }
}

- (void)addChildViewControllers{
    MyNavigationController *home = [[MyNavigationController alloc] initWithRootViewController:[[HomeController alloc] init]];
    MyNavigationController *cart = [[MyNavigationController alloc] initWithRootViewController:[[CartController alloc] init]];
    MyNavigationController *user = [[MyNavigationController alloc] initWithRootViewController:[[UseController alloc] init]];
    self.viewControllers = @[home, cart, user];
}



- (void)addTabarItems{
    NSDictionary *homeTabBarItemsAttributes = @{@"TabBarItemsTitle":@"首页",@"TabBarItemImage":@"tab_home_s",@"TabBarItemSelectedImage":@"tab_home",};
    NSDictionary *cartTabBarItemsAttributes = @{@"TabBarItemsTitle":@"购物车",@"TabBarItemImage":@"tab_cart_s",@"TabBarItemSelectedImage":@"tab_cart",};
    NSDictionary *userTabBarItemsAttributes = @{@"TabBarItemsTitle":@"我的",@"TabBarItemImage":@"tab_user_s",@"TabBarItemSelectedImage":@"tab_user",};
    NSArray<NSDictionary *> *tabBarItemsAttributes = @[homeTabBarItemsAttributes,cartTabBarItemsAttributes,userTabBarItemsAttributes];
    
    [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.tabBarItem.title = tabBarItemsAttributes[idx][@"TabBarItemsTitle"];
        obj.tabBarItem.image = [UIImage imageNamed:tabBarItemsAttributes[idx][@"TabBarItemImage"]];
        obj.tabBarItem.selectedImage = [UIImage imageNamed:tabBarItemsAttributes[idx][@"TabBarItemSelectedImage"]];
        obj.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -3);
    }];
    self.tabBar.tintColor = tabred;
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    return YES;
}

@end
