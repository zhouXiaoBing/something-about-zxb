//
//  zxb_comment.h
//  vitagou
//
//  Created by Mac on 2017/7/13.
//  Copyright © 2017年 Vitagou. All rights reserved.
//


#import "zxb_page_html.h"

#import "zxb_comment_data.h"

@interface zxb_comment : NSObject

@property(nonatomic, strong) NSMutableArray *data;

@property(nonatomic,strong) zxb_page_html *pageHtml;


@end




