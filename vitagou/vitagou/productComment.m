//
//  productComment.m
//  vitagou
//
//  Created by Mac on 2017/7/20.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "productComment.h"

@implementation productComment

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    self.backgroundColor = [UIColor whiteColor];
    
    //商品评论(90)
    _productCommentTitle = [[UILabel alloc]init];
    _productCommentTitle.font = [UIFont systemFontOfSize:12];
    _productCommentTitle.textColor = [UIColor blackColor];
    
    _productCommetRate = [[UILabel alloc]init];
    _productCommetRate.font = [UIFont systemFontOfSize:12];
    _productCommetRate.textColor = [UIColor blackColor];
    
    _userName = [[UILabel alloc]init];
    _userName.font = [UIFont systemFontOfSize:12];
    _userName.textColor = [UIColor blackColor];
    
    _productCommentContent = [[UILabel alloc]init];
    _productCommentContent.font = [UIFont systemFontOfSize:13];
    _productCommentContent.textColor = [UIColor blackColor];
    [_productCommentContent setNumberOfLines:0];
    _productCommentContent.lineBreakMode = NSLineBreakByWordWrapping;
    
    _productCommentTopic = [[UILabel alloc]init];
    _productCommentTopic.font = [UIFont systemFontOfSize:13];
    _productCommentTopic.textColor = [UIColor blackColor];
    _productCommentTopic.text = @"评价:";
    
    
    CGFloat barWidth = 200;
    CGFloat x = 20;
    _productRatingBar = [[RatingBar alloc]initWithFrame:CGRectMake(x, 100, barWidth, 50)];
    _productRatingBar.isIndicator = NO;
    
    [_productRatingBar setImageDeselected:@"iconfont-xingunselected" halfSelected:@"iconfont-banxing" fullSelected:@"iconfont-xing" andDelegate:nil];
    
    _productCommentDate = [[UILabel alloc]init];
    _productCommentDate.font = [UIFont systemFontOfSize:13];
    _productCommentDate.textColor = [UIColor blackColor];
    
    _moreProductComment = [[UIButton alloc]init];
    [_moreProductComment setBackgroundColor:[UIColor colorWithRed:198/255.0 green:0/255.0 blue:44/255.0 alpha:1.0]];
    [_moreProductComment.layer setCornerRadius:5];
    _moreProductComment.titleLabel.font = [UIFont systemFontOfSize: 12.0];
    [_moreProductComment setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    [_moreProductComment setTitle:@"查看更多评论" forState:UIControlStateNormal];
    [_moreProductComment addTarget:self action:@selector(setMoreCommentBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_productCommentTitle];
    [self addSubview:_productCommetRate];
    [self addSubview:_userName];
    [self addSubview:_productCommentContent];
    [self addSubview:_productCommentTopic];
    [self addSubview:_productRatingBar];
//    _productRatingBar.isIndicator = NO;
//    [_productRatingBar setImageDeselected:@"iconfont-xingunselected"                                                                                halfSelected:@"iconfont-banxing" fullSelected:@"iconfont-xing" andDelegate:self];
    
    [self addSubview:_productCommentDate];
    [self addSubview:_moreProductComment];
    
    
    [_productCommentTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self).offset(10);
        make.width.mas_equalTo(Width/2-10);
        make.height.mas_equalTo(Width/12);
    }];
    
    [_productCommetRate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.right.equalTo(self).offset(-10);
        make.left.equalTo(_productCommentTitle.mas_right);
        make.width.mas_equalTo(Width/2-10);
        make.height.mas_equalTo(Width/12);
    }];
    
    [_userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_productCommentTitle.mas_bottom);
        make.left.equalTo(self).offset(10);
        make.width.mas_equalTo(Width/2);
        make.height.mas_equalTo(Width/12);
    
    }];
    
    [_productCommentContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_userName.mas_bottom);
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.width.mas_equalTo(Width-20);
        make.height.mas_equalTo(Width/6);
    }];
    
    [_productCommentTopic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_productCommentContent.mas_bottom);
        make.left.equalTo(self).offset(10);
//        make.width.mas_equalTo(Width/2);
        make.centerY.equalTo(_productCommentTopic.mas_centerY);
        make.height.mas_equalTo(Width/12);
    }];
    
    [_productRatingBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_productCommentContent.mas_bottom);
        make.left.equalTo(_productCommentTopic.mas_right).offset(10);
//        make.width.mas_equalTo(Width/2);
        make.height.mas_equalTo(Width/12);
    }];
    
    [_productCommentDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_productRatingBar.mas_bottom);
        make.left.equalTo(self).offset(10);
        make.width.mas_equalTo(Width/2);
        make.height.mas_equalTo(Width/12);
    }];
    
    [_moreProductComment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_productCommentDate.mas_bottom);
//        make.left.equalTo(self).offset(10);
        make.centerX.equalTo(self.mas_centerX);
        make.width.mas_equalTo(Width/2);
        make.height.mas_equalTo(Width/12);
    }];
    
    return self;
}

-(void)setMoreCommentBtn:(UIButton *)moreProductComment{
    NSLog(@"！！！");
}

//当商品没有评价的时候 隐藏整个显示评价为0 并且评价的button 弹出没有更多评价
-(void)setProducCommentData:(zxb_product_data *)producCommentData{
//    NSString *str = @"商品评价(";
//    NSString *str2 = [str stringByAppendingString:producCommentData.comment.pageHtml.total_num];
//    _productCommentTitle.text =[str2 stringByAppendingString:@")"];
//    
//    _productCommetRate.text = @"100%好评";
//    
////    NSString *str3 = @"用户名:";
//    
////    _userName.text = [str3 stringByAppendingString:producCommentData.comment.data[0].username];
////    _CommentData = producCommentData.comment.data[0];
//    [self setCommentData:producCommentData.comment.data[0]];
//    
}

-(void)setCommentData:(zxb_comment_data *)CommentData{//在这个里面设置星级评价
    
    NSString *str3 = @"用户名:";
    _userName.text = [str3 stringByAppendingString:CommentData.username];
    _productCommentContent.text = CommentData.contents;
    
    float rating = [CommentData.point floatValue];
    
    [_productRatingBar displayRating:rating];
    
    _productCommentDate.text = CommentData.time;
    
}
@end

