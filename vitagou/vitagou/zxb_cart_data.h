//
//  zxb_cart_data.h
//  vitagou
//
//  Created by Mac on 2017/9/6.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import "MJExtension.h"
#import "zxb_agency_data_goods.h"
#import "zxb_Result.h"
@interface zxb_cart_data : NSObject

@property (nonatomic,strong) zxb_Result *result;

@property (nonatomic ,strong) NSMutableArray *data;

+(void)getCartData:(NSString *)user_token
           success:(void(^)(zxb_Result *result, NSMutableArray *data))success
           failure:(void(^)(NSError *error))failure;
//删除商品
+(void)goodsDel:(NSString *)user_token
       goods_id:(NSString *)goods_id
        success:(void(^)(zxb_Result *result))success
        failure:(void(^)(NSError *error))failure;

//编辑商品数量
+(void)goodsEdit:(NSString *)user_token
       goods_id:(NSString *)goods_id
       goods_num:(NSString *)goods_num
        success:(void(^)(zxb_Result *result))success
        failure:(void(^)(NSError *error))failure;

//app_selected_joinCart（购物车选中） 参数 goods_id ischeck（0未选中,1选中）
+(void)goodsBeChoose:(NSString *)user_token
        goods_id:(NSString *)goods_id
       isCheck:(NSString *)ischeck
         success:(void(^)(zxb_Result *result))success
         failure:(void(^)(NSError *error))failure;

//订单确认
+(void)orderComfirm:(NSString *)user_token
            agency_id:(NSString *)agency_id
             seller_id:(NSString *)seller_id
             success:(void(^)(zxb_Result *result))success
             failure:(void(^)(NSError *error))failure;


@end
