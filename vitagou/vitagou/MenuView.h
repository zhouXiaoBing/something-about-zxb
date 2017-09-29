//
//  MenuView.h
//  vitagou
//
//  Created by Mac on 2017/6/2.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotBtnView.h"

@interface MenuView : UIView
- (instancetype)initMenus:(NSArray<HotBtnView *> *)menus WithLine:(BOOL)showLine;
@end
