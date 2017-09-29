//
//  DCCommentContentCell.h
//  CDDMall
//
//  Created by apple on 2017/6/27.
//
//用户名、评论内容、图片、评分、评论时间

#import <UIKit/UIKit.h>
#import "RatingBar.h"
#import "zxb_comment.h"
#import "goods_comment_data_content.h"


@interface DCCommentContentCell : UICollectionViewCell

@property(nonatomic,strong) UILabel *userName;

@property(nonatomic,strong) UILabel *productCommentContent;

@property(nonatomic,strong) RatingBar *productRatingBar;

@property(nonatomic,strong) UILabel *productCommentTopic;

@property(nonatomic,strong) UILabel *productCommentDate;

@property(nonatomic,strong) zxb_comment_data *commentData;

@property(nonatomic,strong) goods_comment_data_content *content;

@end
