//
//  BaseViewVC.h
//  collectionIos
//
//  Created by Mac on 2017/12/28.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewVC : UIViewController

+ (UIViewController *)presentingVC;
+ (void)presentVC:(UIViewController *)viewController;
+ (void)goToVC:(UIViewController *)viewController;

@end




