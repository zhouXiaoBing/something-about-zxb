//
//  MenuView.h
//  vitagou
//
//  Created by Mac on 2018/8/14.
//  Copyright © 2018年 vitagou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotBtnView.h"

@interface MenuView : UIView
- (instancetype)initMenus:(NSArray<HotBtnView *> *)menus WithLine:(BOOL)showLine;
@end
