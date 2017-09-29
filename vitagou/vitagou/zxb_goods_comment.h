

//
//  zxb_goods_comment.h
//  vitagou
//
//  Created by Mac on 2017/9/25.
//  Copyright © 2017年 Vitagou. All rights reserved.
//


#import "zxb_Result.h"
#import "goods_comment_data.h"

@interface zxb_goods_comment : NSObject

@property (nonatomic, strong) zxb_Result *result;

@property (nonatomic, strong) goods_comment_data *data;


+(void)getGoodsComment:(NSString *)goods_id
                  type:(NSString*) type
               success:(void(^)(zxb_Result *result, goods_comment_data *data))success
               failure:(void(^)(NSError *error))failure;

@end
