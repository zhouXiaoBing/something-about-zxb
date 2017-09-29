//
//  fitPeopleCell.m
//  vitagou
//
//  Created by Mac on 2017/7/7.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import "fitPeopleCell.h"

@interface fitPeopleCell()

/*
 你听到的成功经验，百分之百都是幸存者偏差
 */

@end

@implementation fitPeopleCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    
    self.backgroundColor = [UIColor whiteColor];

    _group = [[UIImageView alloc]init];
    [_group setImage:[UIImage imageNamed:@"place_holder"]];//默认图片
    //图片处理成圆角
    _group.layer.masksToBounds = YES;
    _group.layer.cornerRadius = Width/8;//这个值需要精确
    
    _groupName = [[UILabel alloc]init];
    _groupName.font = [UIFont systemFontOfSize:14];
    _groupName.textColor = [UIColor blackColor];
    
    
    [self addSubview:_group];
    [self addSubview:_groupName];
    
    
    [_group mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self).offset(5);
        make.width.mas_equalTo(Width/4);
        make.height.mas_equalTo(Width/4);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click)];
    _group.userInteractionEnabled = YES;
    [_group addGestureRecognizer:tap];
    
    [_groupName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(_group.mas_bottom);
       // make.width.mas_equalTo(Width/4);//有时候不给宽度可以保证居中
        make.height.mas_equalTo(20);
    }];
    
    return self;
}


-(void)setGroupData:(zxb_objGroup *)groupData{
    [_group sd_setImageWithURL:[NSURL URLWithString:
                                    [VITAGOUURL stringByAppendingString:groupData.img]] placeholderImage:[UIImage imageNamed:@"place_holder"]];
    _groupName.text = groupData.name;
    _category_id = groupData.category_id;
}

-(void)click{
    [AJNotification postNotificationName:FitPeopleCellNotifacation object:_category_id];
}
@end
