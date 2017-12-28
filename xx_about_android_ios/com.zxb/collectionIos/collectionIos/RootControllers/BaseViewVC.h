//
//  BaseViewVC.h
//  collectionIos
//
//  Created by Mac on 2017/12/28.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewVC : UIViewController

- (void)tabBarItemClicked;//the "-" stands instance method

+ (void)handleNotificationInfo:(NSDictionary *)userInfo applicationState:(UIApplicationState)applicationState;

@end




