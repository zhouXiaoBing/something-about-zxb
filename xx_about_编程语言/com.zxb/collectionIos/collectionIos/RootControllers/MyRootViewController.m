//
//  MyRootViewController.m
//  collectionIos
//
//  Created by Mac on 2017/12/27.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import "MyRootViewController.h"
#import "RDVTabBarItem.h"
#import "OneRootVC.h"
#import "TwoRootVC.h"
#import "ThreeRootVC.h"


@interface MyRootViewController ()

@end


@implementation MyRootViewController

//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        [self initView];
//    }
//    return self;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"enter in MyRootViewController_viewDidLoad!!!");
//    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    self.window.rootViewController = [self rootController];//调用初始化的方法
//    self.window.backgroundColor = [UIColor colorWithRed:92/255.0 green:107/255.0 blue:192/255.0 alpha:0.8];
//    [self.window makeKeyAndVisible];
    [self setupViewControllers];

}

#pragma mark 底部导航栏菜单的设置
- (void)setupViewControllers {
    OneRootVC * one_vc = [[OneRootVC alloc]init];
    UINavigationController *nav_one = [[BaseNavigationController alloc]initWithRootViewController:one_vc];
    
    TwoRootVC * two_vc = [[TwoRootVC alloc]init];
     UINavigationController *nav_two = [[BaseNavigationController alloc]initWithRootViewController:two_vc];
    
    ThreeRootVC * three_vc = [[ThreeRootVC alloc]init];
    UINavigationController *nav_three = [[BaseNavigationController alloc]initWithRootViewController:three_vc];
    
    [self setViewControllers:@[nav_one,nav_two,nav_three]];
    
    [self customizeTabBarForController];
}

- (void)customizeTabBarForController {
    
    NSArray * tabBarItemImages = @[@"tab",@"tab",@"tab"];
    NSArray * tabBarItemTitles = @[@"壹",@"贰",@"叁"];
    NSInteger index = 0;
    
    for (RDVTabBarItem *item in [[self tabBar] items]) {
        
        item.titlePositionAdjustment = UIOffsetMake(0, 3);
        // string connect by " %@ "
        UIImage *selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",[tabBarItemImages objectAtIndex:index]]];
        
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal",
                                                        [tabBarItemImages objectAtIndex:index]]];
        [item setFinishedSelectedImage:selectedImage withFinishedUnselectedImage:unselectedimage];
        [item setTitle:[tabBarItemTitles objectAtIndex:index]];
        
        if (kDevice_Is_iPhoneX) {
            item.badgePositionAdjustment = UIOffsetMake(0, 18);
        }
        index++;
    }
    if (kDevice_Is_iPhoneX) {
        [self.tabBar setHeight:83];
        [self.tabBar setContentEdgeInsets:UIEdgeInsetsMake(18, 0, 0, 0)];
    }
    
    self.tabBar.backgroundView.backgroundColor = [UIColor whiteColor];
    //tabBar 添加上划线
    [self.tabBar addLineUp:YES andDown:NO andColor:[UIColor grayColor]];
    
}

//-(void)initView{
//
//    NSLog(@"enter in MyRootViewController_initView!!!");
//    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    self.window.rootViewController = [self rootController];//调用初始化的方法
//    self.window.backgroundColor = [UIColor greenColor];
//    [self.window makeKeyAndVisible];
//}



- (UITabBarController *)rootController {
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    
    
    return tabBarController;
}
@end
