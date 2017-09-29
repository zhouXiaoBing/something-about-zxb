

//
//  goods_comment_data_content.h
//  vitagou
//
//  Created by Mac on 2017/9/25.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import "goods_comment_data_content_img.h"

@interface goods_comment_data_content : NSObject

@property(nonatomic, strong) NSString *goods_id;

@property(nonatomic, strong) NSString *order_no;

@property(nonatomic, strong) NSString *user_id;

@property(nonatomic, strong) NSString *time;

@property(nonatomic, strong) NSString *comment_time;

@property(nonatomic, strong) NSString *contents;

@property(nonatomic, strong) NSString *experience;

@property(nonatomic, strong) NSString *recontents;

@property(nonatomic, strong) NSString *recomment_time;

@property(nonatomic, strong) NSString *point;

@property(nonatomic, strong) NSString *status;

@property(nonatomic, strong) NSString *seller;

@property(nonatomic, strong) NSString *username;

@property(nonatomic, strong) NSString *nickname;

@property(nonatomic, strong) NSMutableArray *images;

@end
