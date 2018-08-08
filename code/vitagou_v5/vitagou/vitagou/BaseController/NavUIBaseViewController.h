//
//  NavUIBaseViewController.h
//  vitagou
//
//  Created by Mac on 2018/7/16.
//  Copyright © 2018年 vitagou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavigationBar.h"


@class NavUIBaseViewController;

@protocol NavUIBaseViewControllerDataSource <NSObject>

@optional

- (BOOL)navUIBaseViewControllerIsNeedNavBar:(NavUIBaseViewController *)navUIBaseViewController;

@end

@interface NavUIBaseViewController : UIViewController <NavUIBaseViewControllerDataSource,NavigationBarDelegate,NavigationBarDataSource>
/* 默认的导航栏字体 */
- (NSMutableAttributedString *)changeTitle:(NSString *)curTitle;

@property(weak,nonatomic) NavigationBar * navigationBar;

@end






