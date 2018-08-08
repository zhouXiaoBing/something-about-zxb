//
//  RequestBaseViewController.h
//  vitagou
//
//  Created by Mac on 2018/7/19.
//  Copyright © 2018年 vitagou. All rights reserved.
//

#import "TextViewController.h"
#import "Reachability.h"

@class RequestBaseViewController;
@protocol RequestBaseViewControllerDelegate<NSObject>
@optional
#pragma mark - 网络监听
/*
 NotReachable = 0,
 ReachableViaWiFi = 2,
 ReachableViaWWAN = 1,
 ReachableVia2G = 3,
 ReachableVia3G = 4,
 ReachableVia4G = 5,
 */

- (void)networkStatus:(NetworkStatus)networkStatus inViewController:(RequestBaseViewController *)inViewController;

@end

@interface RequestBaseViewController : TextViewController<RequestBaseViewControllerDelegate>

#pragma mark - 加载框

- (void)showLoading;

- (void)dismissLoading;

@end






