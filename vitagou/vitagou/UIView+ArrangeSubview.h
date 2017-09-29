//
//  UIView+ArrangeSubview.h
//  vitagou
//
//  Created by Mac on 2017/6/12.
//  Copyright © 2017年 Vitagou. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "Masonry.h"

@interface UIView (ArrangeSubview)
-(void)arrangeSubviewWithSpacingHorizontally:(NSArray*)views;
- (void)arrangeSubviewWithSpacingVertically:(NSArray*)views;
@end
