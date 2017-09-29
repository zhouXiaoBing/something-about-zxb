//
//  fitPeopleCell.h
//  vitagou
//
//  Created by Mac on 2017/7/7.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "zxb_objGroup.h"

@interface fitPeopleCell : UICollectionViewCell

@property(nonatomic,strong) zxb_objGroup *groupData;

@property(nonatomic,strong) UIImageView  *group;

@property(nonatomic,strong) UILabel *groupName;

@property(nonatomic, strong) NSString *category_id;
@end
