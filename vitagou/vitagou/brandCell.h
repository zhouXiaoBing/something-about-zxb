//
//  brandCell.h
//  vitagou
//
//  Created by Mac on 2017/7/6.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "zxb_hot_brand.h"


@interface brandCell : UICollectionViewCell

@property(nonatomic,strong) zxb_hot_brand *brand;

@property(nonatomic,strong) UIImageView *brandView;

@property(nonatomic, strong) NSString *bid;


@end
