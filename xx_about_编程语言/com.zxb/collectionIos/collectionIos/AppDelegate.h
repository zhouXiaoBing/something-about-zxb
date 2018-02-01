//
//  AppDelegate.h
//  collectionIos
//
//  Created by Mac on 2017/12/26.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "MyRootViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

@property (readonly, strong) MyRootViewController *myRootViewController;

@property (strong, nonatomic) UIViewController *viewController;

- (void)saveContext;

- (void)setRootViewController;

@end

