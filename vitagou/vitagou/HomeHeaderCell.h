//
//  HomeHeaderCell.h
//  vitagou
//
//  Created by Mac on 2017/6/9.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeHeaderCell : UICollectionReusableView

- (void)showTitleLable:(BOOL)show;

-(void)setTitle:(NSString *)str;

@end

@interface HomeFooterCell : UICollectionReusableView

@end
