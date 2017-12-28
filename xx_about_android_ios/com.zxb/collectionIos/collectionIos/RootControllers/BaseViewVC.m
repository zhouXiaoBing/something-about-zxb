
//
//  BaseViewVC.m
//  collectionIos
//
//  Created by Mac on 2017/12/28.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import "BaseViewVC.h"

#pragma mark - UIViewController (Dismiss)
@interface UIViewController (Dismiss)
- (void)dismissModalVC;
@end
@implementation UIViewController (Dismiss)
- (void)dismissModalVC{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end


@interface BaseViewVC ()

@end

@implementation BaseViewVC

//controller 出现的时候所有的Controller 都可以做的操作 比如友盟的统计
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // bar 的风格
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
//
    //横竖屏切换
//    if (self.interfaceOrientation != UIInterfaceOrientationPortrait
//        && !([self supportedInterfaceOrientations] & UIInterfaceOrientationMaskLandscapeLeft)) {
//        [self forceChangeToOrientation:UIInterfaceOrientationPortrait];
//    }
    
}

//what the view disappear all controllers can do
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
//    [MobClick endLogPageView:[NSString stringWithUTF8String:object_getClassName(self)]];
    
}


- (void)tabBarItemClicked{
    DebugLog(@"\ntabBarItemClicked : %@", [self class]);
}

#pragma mark - Orientations
//- (BOOL)shouldAutorotate{
//    return UIInterfaceOrientationIsLandscape(self.interfaceOrientation);
//}
//
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
//    return UIInterfaceOrientationPortrait;
//}
//
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
//    return UIInterfaceOrientationMaskPortrait;
//}
//
//- (void)forceChangeToOrientation:(UIInterfaceOrientation)interfaceOrientation{
//    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:interfaceOrientation] forKey:@"orientation"];
//}

#pragma mark Notification
+ (void)handleNotificationInfo:(NSDictionary *)userInfo applicationState:(UIApplicationState)applicationState{
//    if (applicationState == UIApplicationStateInactive) {
//        //If the application state was inactive, this means the user pressed an action button from a notification.
//        //标记为已读
//        NSString *notification_id = [userInfo objectForKey:@"notification_id"];
//        if (notification_id) {
//            [[Coding_NetAPIManager sharedManager] request_markReadWithCodingTipIdStr:notification_id andBlock:^(id data, NSError *error) {
//            }];
//        }
//        //弹出临时会话
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            DebugLog(@"handleNotificationInfo : %@", userInfo);
//            NSString *param_url = [userInfo objectForKey:@"param_url"];
//            [self presentLinkStr:param_url];
//        });
//    }else if (applicationState == UIApplicationStateActive){
//        NSString *param_url = [userInfo objectForKey:@"param_url"];
//        [self analyseVCFromLinkStr:param_url analyseMethod:AnalyseMethodTypeJustRefresh isNewVC:nil];//AnalyseMethodTypeJustRefresh
//        //标记未读
//        UIViewController *presentingVC = [BaseViewController presentingVC];
//        if ([presentingVC isKindOfClass:[Message_RootViewController class]]) {
//            [(Message_RootViewController *)presentingVC refresh];
//        }
//        [[UnReadManager shareManager] updateUnRead];
//    }
}


@end
