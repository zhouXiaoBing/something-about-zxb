//
//  RequestBaseViewController.m
//  vitagou
//
//  Created by Mac on 2018/7/19.
//  Copyright © 2018年 vitagou. All rights reserved.
//


#import "RequestBaseViewController.h"
#import "MBProgressHUD+LMJ.h"

@interface RequestBaseViewController ()

@property (nonatomic, strong) Reachability *reachHost;

@end

@implementation RequestBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self reachHost];
}

#pragma mark - 加载框
- (void)showLoading
{
    [MBProgressHUD showProgressToView:self.view Text:@"加载中..."];
}

- (void)dismissLoading
{
    [MBProgressHUD hideHUDForView:self.view];
}

#define kURL_Reachability__Address @"www.baidu.com"
#pragma mark - 监听网络状态
- (Reachability *)reachHost
{
    if(_reachHost == nil)
    {
        _reachHost = [Reachability reachabilityWithHostName:kURL_Reachability__Address];
        Weak(self);
        [_reachHost setUnreachableBlock:^(Reachability * reachability){
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself networkStatus:reachability.currentReachabilityStatus inViewController:weakself];
            });
        }];
        
        [_reachHost setReachableBlock:^(Reachability * reachability){
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself networkStatus:reachability.currentReachabilityStatus inViewController:weakself];
            });
        }];
        [_reachHost startNotifier];
    }
    return _reachHost;
}

#pragma mark - LMJRequestBaseViewControllerDelegate
- (void)networkStatus:(NetworkStatus)networkStatus inViewController:(RequestBaseViewController *)inViewController
{
    //判断网络状态
    switch (networkStatus) {
        case NotReachable:
            [MBProgressHUD showError:@"当前网络连接失败，请查看设置" ToView:self.view];
            break;
        case ReachableViaWiFi:
            NSLog(@"wifi上网2");
            break;
        case ReachableViaWWAN:
            NSLog(@"手机上网2");
            break;
        default:
            break;
    }
}

- (void)dealloc
{
    if ([self isViewLoaded]) {
        [MBProgressHUD hideHUDForView:self.view animated:NO];
    }
    [_reachHost stopNotifier];
    _reachHost = nil;
}


@end 
