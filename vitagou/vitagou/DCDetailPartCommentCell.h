//
//  DCDetailPartCommentCell.h
//  CDDMall
//
//  Created by apple on 2017/6/21.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "zxb_comment.h"
#import "zxb_comment_data.h"

@interface DCDetailPartCommentCell : UICollectionViewCell


@property(nonatomic,strong) zxb_comment_data *CommentData;

@property(nonatomic,strong) zxb_comment *Comment;



@end
