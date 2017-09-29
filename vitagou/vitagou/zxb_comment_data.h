//
//  zxb_comment_data.h
//  vitagou
//
//  Created by Mac on 2017/7/13.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import "zxb_comment_images.h"

@interface zxb_comment_data : NSObject

@property (nonatomic, strong) NSString *head_ico;

@property (nonatomic, strong) NSString *goods_id;

@property (nonatomic, strong) NSString *order_no;

@property (nonatomic, strong) NSString *comment_time;

@property (nonatomic, strong) NSString *time;

@property (nonatomic, strong) NSString *contents;

@property (nonatomic, strong) NSString *experience;

@property (nonatomic, strong) NSString *recontents;

@property (nonatomic, strong) NSString *recomment_time;

@property (nonatomic, strong) NSString *point;

@property (nonatomic, strong) NSString *status;

@property (nonatomic, strong) NSString *seller;

@property (nonatomic, strong) NSString *username;

//array
@property (nonatomic, strong) NSMutableArray *images;





@end
