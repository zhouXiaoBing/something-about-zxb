//
//  GuideCell.h
//  vitagou
//
//  Created by Mac on 2017/6/28.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface GuideCell : UICollectionViewCell

@property (nonatomic,strong) UIImage *image;

- (void)setNextButtonHidden:(BOOL)hidden;

@end
