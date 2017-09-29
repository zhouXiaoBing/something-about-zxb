
//
//  goods_comment_data.h
//  vitagou
//
//  Created by Mac on 2017/9/25.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import "goods_comment_data_content.h"

@interface goods_comment_data : NSObject

@property(nonatomic,strong) NSString *totalNum;

@property(nonatomic,strong) NSString *pages;

@property(nonatomic,strong) NSString *page_size;

@property(nonatomic,strong) NSString *page_total;

@property(nonatomic,strong) NSMutableArray *content;

@end

