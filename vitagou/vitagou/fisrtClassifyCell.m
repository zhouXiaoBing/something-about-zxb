//
//  fisrtClassifyCell.m
//  vitagou
//
//  Created by Mac on 2017/8/7.
//  Copyright © 2017年 Vitagou. All rights reserved.
//出现touch事件冲突

#import <Foundation/Foundation.h>
#import "fisrtClassifyCell.h"

@implementation fisrtClassifyCell
//static NSString *firstCell = @"firstCell";
 

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _titleLabel = [[UILabel alloc]init];
//        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:14];
        
        _backImageView = [[UIImageView alloc]init];
        
        _yellowView = [[UIView alloc]init];
        _yellowView.backgroundColor = [UIColor orangeColor];
        _yellowView.hidden = YES;
        
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor darkGrayColor];
        _lineView.alpha = 0.3;
        
    
        [self addSubview:_backImageView];
        [self addSubview:_lineView];
        [self addSubview:_yellowView];
        [self addSubview:_titleLabel];
        
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
        
        [_backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        [_yellowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self);
            make.height.equalTo(self).multipliedBy(0.8);
            make.width.equalTo(@5);
            make.centerY.equalTo(self);
        }];
        
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0.5);
            make.width.equalTo(self);
            make.bottom.equalTo(self);
        }];
        

        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

- (void)doIt:(UITapGestureRecognizer *)gesture
{
    [AJNotification postNotificationName:ClassifyNotification object:_categoryId];
    [self setSelected:YES];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
//    if (selected) {
//        _indicatorView.hidden = NO;
//        _titleLabel.textColor = [UIColor redColor];
//        self.backgroundColor = [UIColor whiteColor];
//    }else{
//        _indicatorView.hidden = YES;
//        _titleLabel.textColor = [UIColor blackColor];
//        self.backgroundColor = [UIColor clearColor];
//    }
    /*
     _titleLabel.textColor = [UIColor grayColor];
     _titleLabel.highlightedTextColor = [UIColor blackColor];
     
     _backImageView.image = [UIImage imageNamed:@"classify_normal"];
     _backImageView.highlightedImage = [UIImage imageNamed:@"classify_high_light"];
     */
        if (selected) {
            _yellowView.hidden = NO;
            _titleLabel.textColor = [UIColor redColor];
//            _backImageView.highlightedImage = [UIImage imageNamed:@"classify_high_light"];
            self.backgroundColor = [UIColor whiteColor];
            }else{
            _yellowView.hidden = YES;
            _titleLabel.textColor = [UIColor blackColor];
//            _backImageView.image = [UIImage imageNamed:@"classify_normal"];
                self.backgroundColor = [UIColor clearColor];

            }
}


-(void)setCategory:(zxb_category *)category{
    NSLog(@"setCategory %@",category.name);
    _titleLabel.text = category.name;
    _categoryId = category.category_id;
    _categoryName = category.name;
}

@end
