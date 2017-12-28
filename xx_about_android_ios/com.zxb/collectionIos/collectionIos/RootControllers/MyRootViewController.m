//
//  MyRootViewController.m
//  collectionIos
//
//  Created by Mac on 2017/12/27.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import "MyRootViewController.h"
#import "RDVTabBarItem.h"

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
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
