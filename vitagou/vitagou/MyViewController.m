/*
     File: MyViewController.m 
 Abstract: The root view controller for the iPhone design of this app. 
  Version: 1.6 
  
 Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple 
 Inc. ("Apple") in consideration of your agreement to the following 
 terms, and your use, installation, modification or redistribution of 
 this Apple software constitutes acceptance of these terms.  If you do 
 not agree with these terms, please do not use, install, modify or 
 redistribute this Apple software. 
  
 In consideration of your agreement to abide by the following terms, and 
 subject to these terms, Apple grants you a personal, non-exclusive 
 license, under Apple's copyrights in this original Apple software (the 
 "Apple Software"), to use, reproduce, modify and redistribute the Apple 
 Software, with or without modifications, in source and/or binary forms; 
 provided that if you redistribute the Apple Software in its entirety and 
 without modifications, you must retain this notice and the following 
 text and disclaimers in all such redistributions of the Apple Software. 
 Neither the name, trademarks, service marks or logos of Apple Inc. may 
 be used to endorse or promote products derived from the Apple Software 
 without specific prior written permission from Apple.  Except as 
 expressly stated in this notice, no other rights or licenses, express or 
 implied, are granted by Apple herein, including but not limited to any 
 patent rights that may be infringed by your derivative works or by other 
 works in which the Apple Software may be incorporated. 
  
 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE 
 MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION 
 THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS 
 FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND 
 OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS. 
  
 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL 
 OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
 INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION, 
 MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED 
 AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE), 
 STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE 
 POSSIBILITY OF SUCH DAMAGE. 
  
 Copyright (C) 2014 Apple Inc. All Rights Reserved. 
 
  
 */

#import "TabHomeController.h"
#import "TabCartController.h"
#import "TabMyController.h"
#import "MyViewController.h"
#import "BaseNavigationController.h"

@interface MyViewController ()

@end


#pragma mark -

@implementation MyViewController

// load the view nib and initialize the pageNumber ivar



// set the label and background color when the view has finished loading
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [self rootController];//调用初始化的方法
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
}

- (UITabBarController *)rootController {
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    
    //home tab
    TabHomeController *homeController = [[TabHomeController alloc] init];
    homeController.tabBarItem = [self createTabBarItem:@"首页" imageNamed:@"tab_home" selectedImageNamed:@"tab_home_s"];
    UINavigationController *homeNavController = [[UINavigationController alloc] initWithRootViewController:homeController];
    
    TabCartController *cartController = [[TabCartController alloc] init];
    cartController.tabBarItem = [self createTabBarItem:@"购物车" imageNamed:@"tab_cart" selectedImageNamed:@"tab_cart_s"];
    UINavigationController *cartNavController = [[UINavigationController alloc] initWithRootViewController:cartController];
    //my tab
    TabMyController *myController = [[TabMyController alloc] init];
    myController.tabBarItem = [self createTabBarItem:@"我的" imageNamed:@"tab_my" selectedImageNamed:@"tab_my_s"];
    UINavigationController *myNavController = [[UINavigationController alloc] initWithRootViewController:myController];
    
    tabBarController.viewControllers = @[homeNavController, cartNavController, myNavController];
    return tabBarController;
    
    
}
//
- (UITabBarItem *)createTabBarItem:(NSString *)title imageNamed:(NSString *)imageNamed selectedImageNamed:selectedImageNamed {
    UIImage *image = [[UIImage imageNamed:imageNamed] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectedImage = [[UIImage imageNamed:selectedImageNamed] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:title
                                                             image:image
                                                     selectedImage:selectedImage];
    return tabBarItem;
}
@end
