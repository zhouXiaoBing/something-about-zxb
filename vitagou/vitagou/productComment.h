//
//  productComment.h
//  vitagou
//
//  Created by Mac on 2017/7/20.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import "RatingBar.h"
#import "zxb_product_data.h"
#import "zxb_comment_data.h"
#import "zxb_comment.h"

@interface productComment : UIView

@property(nonatomic,strong) UILabel *productCommentTitle;

@property(nonatomic,strong) UILabel *productCommetRate;

@property(nonatomic,strong) UILabel *userName;

@property(nonatomic,strong) UILabel *productCommentContent;

@property(nonatomic,strong) RatingBar *productRatingBar;

@property(nonatomic,strong) UILabel *productCommentTopic;

@property(nonatomic,strong) UILabel *productCommentDate;

@property(nonatomic,strong) UIButton *moreProductComment;

@property(nonatomic,strong) zxb_product_data *producCommentData;

@property(nonatomic,strong) zxb_comment_data *CommentData;

@property(nonatomic,strong) zxb_comment *Comment;


@end
