//
//  HomeNavBar.h
//  vitagou
//
//  Created by Mac on 2017/4/7.
//  Copyright © 2017年 Vitagou. All rights reserved.
//
#import <UIKit/UIKit.h>

@protocol HomeNavBarDelegate <NSObject>


@end

@interface HomeNavBar : UIView

@property(nonatomic,weak) id<HomeNavBarDelegate> delegate;

+(CGFloat)height;

@end


