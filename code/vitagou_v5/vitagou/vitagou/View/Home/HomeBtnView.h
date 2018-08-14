//
//  HomeBtnView.h
//  vitagou
//
//  Created by Mac on 2018/8/14.
//  Copyright © 2018年 vitagou. All rights reserved.
//

#import "HotBtnView.h"
#import "MenuView.h"
@interface HomeBtnView : UICollectionViewCell

@property (nonatomic,strong) NSArray *hotBtnView;

@property(nonatomic,strong) MenuView *menuView;//跳转button

@end
