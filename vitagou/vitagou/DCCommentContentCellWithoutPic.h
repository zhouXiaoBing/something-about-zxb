//
//  DCCommentContentCellWithoutPic.h
//  vitagou
//
//  Created by Mac on 2017/9/6.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RatingBar.h"
#import "zxb_comment.h"
#import "goods_comment_data_content.h"


@interface DCCommentContentCellWithoutPic : UICollectionViewCell

@property(nonatomic,strong) UILabel *userName;

@property(nonatomic,strong) UILabel *productCommentContent;

@property(nonatomic,strong) RatingBar *productRatingBar;

@property(nonatomic,strong) UILabel *productCommentTopic;

@property(nonatomic,strong) UILabel *productCommentDate;

@property(nonatomic,strong) zxb_comment_data *commentData;

@property(nonatomic,strong) goods_comment_data_content *content;

@end
