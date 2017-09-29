//
//  fisrtClassifyCell.h
//  vitagou
//
//  Created by Mac on 2017/8/7.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import "zxb_classify_data.h"
#import "zxb_classify.h"
#import "zxb_category.h"


@interface fisrtClassifyCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;

@property (strong , nonatomic)UIView *indicatorView;

@property (nonatomic, strong) UIImageView *backImageView;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIView *yellowView;

@property (nonatomic, strong) zxb_classify *classsify;

@property (nonatomic, strong) zxb_classify_data *classifyData;

@property (nonatomic, strong) zxb_category *category;

@property (nonatomic, strong) NSString *categoryId;

@property (nonatomic, strong) NSString *categoryName;

//+(instancetype)cellWithConllection:(UICollectionView *)collView;

@end
