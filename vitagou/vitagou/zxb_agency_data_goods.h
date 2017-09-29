
//
//  zxb_agency_data_goods.h
//  vitagou
//
//  Created by Mac on 2017/9/6.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import "MJExtension.h"
#import "zxb_cart_goods.h"
@interface zxb_agency_data_goods : NSObject

@property (nonatomic , strong) NSString *true_name;

@property (nonatomic , strong) NSString *seller_logo;

@property (nonatomic , strong) NSString *seller_id;

@property (nonatomic , strong) NSString *agency_id;

@property (nonatomic , strong) NSString *agency;

@property (nonatomic , strong) NSMutableArray *goods;

@end
