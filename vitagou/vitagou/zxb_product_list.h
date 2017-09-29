//
//  zxb_product_list.h
//  vitagou
//
//  Created by Mac on 2017/8/15.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import "zxb_Result.h"

@interface zxb_product_list : NSObject

@property(nonatomic,strong) zxb_Result *result;

@property(nonatomic, strong) NSMutableArray *data;

//@property(nonatomic, strong) NSString *str;

+(void)getProductListData:(NSString *)categoryOrBrandOrKeyword_id
                    label:(NSString *)label
                  success:(void(^)(zxb_Result *result, NSMutableArray *data))success
              failure:(void(^)(NSError *error))failure;

+(void)getProductListDataByOrder:(NSString *)categoryOrBrandOrKeyword_id
                        label:(NSString *)label
                           order:(NSString *)order
                         success:(void(^)(zxb_Result *result, NSMutableArray *data))success
                         failure:(void(^)(NSError *error))failure;


@end
