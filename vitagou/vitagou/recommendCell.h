//
//  recommendCell.h
//  vitagou
//
//  Created by Mac on 2017/6/8.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "zxb_promotion.h"
#import "CountDown.h"
#import "Masonry.h"
#import "zxb_home_data.h"
/** 新品特卖textlable，倒计时countDown*/
@interface recommendCell : UICollectionViewCell

@property (nonatomic,strong) UILabel *nameType;

@property(nonatomic,strong) CountDown *countDown;

@property(nonatomic, strong) zxb_home_data *data;//拿倒计时的时间

@end

