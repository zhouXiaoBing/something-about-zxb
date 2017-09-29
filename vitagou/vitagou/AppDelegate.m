//
//  AppDelegate.m 首先理解这个是一个类似Android里面application的类是一直运行的 不管在哪个页面都会有她的存在
//  vitagou
//
//  Created by Mac on 2017/3/23.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import "AppDelegate.h"
#import "GuideViewController.h"
#import "MyViewController.h"

@interface AppDelegate ()
//这里连线到MainWindow.xib


@end

@implementation AppDelegate

/*
 NSString *isFirstOpenApp = [[NSUserDefaults standardUserDefaults] objectForKey:IsFristOpenApp];
 if (isFirstOpenApp == nil) {//enter in loop img
 self.window.rootViewController = [GuideViewController new];
 [[NSUserDefaults standardUserDefaults] setObject:IsFristOpenApp forKey:IsFristOpenApp];
 }else{
 [self loadAdRootController];
 }
 //------------------引导页轮播--------------------------
 //这里加载了PhoneContent的xib，也就进入了引导页的界面
 self.window = [[UIWindow alloc] init];
 NSString *nibTitle = @"PhoneContent";
 [[NSBundle mainBundle] loadNibNamed:nibTitle owner:self options:nil];
 [self.window makeKeyAndVisible];
 self.window.frame = [[UIScreen mainScreen]bounds];
 
 
 //-----------------------------------------------------
 
 
 self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
 self.window.rootViewController = [self rootController];//调用初始化的方法
 self.window.backgroundColor = [UIColor whiteColor];
 [self.window makeKeyAndVisible];
 */

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
     NSLog(@"didFinishLaunchingWithOptions被执行");
    [self addNotification];
    [self buildKeyWindow];//是否执行轮播图
    
    
    return YES;
}

- (void)buildKeyWindow {
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    NSString *isFirstOpenApp = [[NSUserDefaults standardUserDefaults] objectForKey:IsFristOpenApp];
    if (isFirstOpenApp == nil) {
        self.window.rootViewController = [GuideViewController new];
        [[NSUserDefaults standardUserDefaults] setObject:IsFristOpenApp forKey:IsFristOpenApp];
    }else{
        [self loadAdRootController];
    }
}




- (void)addNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showMainTabarController) name:GuideViewControllerDidFinish object:nil];
}

- (void)loadAdRootController {
    //self.window.rootViewController = [MainTabBarController new];
    self.window.rootViewController = [MyViewController new];
}

- (void)showMainTabarController {
    self.window.rootViewController = [MyViewController new];
}
/*
 //据说这是一个已经被放弃的方法  还有这个是mac应用时会使用的方法
 - (void)applicationDidFinishLaunching:(UIApplication *)application{
     NSLog(@"applicationDidFinishLaunching被执行");
//    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen]
    self.window = [[UIWindow alloc] init];
    // decide which kind of content we need based on the device idiom,
    // when we load the proper nib, the "ContentController" class will take it from here
    //
    NSString *nibTitle = @"PhoneContent";
    NSLog(@"dd");
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//    {
//        nibTitle = @"PhoneContent";
//    }
    [[NSBundle mainBundle] loadNibNamed:nibTitle owner:self options:nil];
    [self.window makeKeyAndVisible];
    self.window.frame = [[UIScreen mainScreen]bounds];
}

*/
- (void)applicationWillResignActive:(UIApplication *)application {
    NSLog(@"applicationWillResignActive被执行");
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"applicationDidEnterBackground被执行");
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
     NSLog(@"applicationWillEnterForeground被执行");
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
     NSLog(@"applicationDidBecomeActive被执行");
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"applicationWillTerminate被执行");
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {//原代码中注册相关
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"vitagou"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
