//
//  secondClassifyCellPurpose.h
//  vitagou
//
//  Created by Mac on 2017/9/1.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import "zxb_classify_two.h"
#import "zxb_classify_two_data.h"

@interface secondClassifyCellPurpose : UICollectionViewCell

@property (nonatomic, strong) UILabel *titleLabel;//分类标题

@property (nonatomic, strong) UIImageView *titleImageView;

@property (nonatomic, strong) zxb_classify_two_data *classify_two_data;

@end
