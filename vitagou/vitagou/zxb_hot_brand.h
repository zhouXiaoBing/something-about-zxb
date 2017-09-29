//
//  zxb_hot_brand.h
//  vitagou
//
//  Created by Mac on 2017/4/20.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface zxb_hot_brand : NSObject

@property (nonatomic, assign) NSString *id;

@property (nonatomic, assign) NSString *name;

@property (nonatomic, strong) NSString *logo;

@property (nonatomic, assign) NSString *brandlist_ad;

@property (nonatomic, assign) NSString *brand_ad;

@property (nonatomic, strong) NSString *url;//b避免EXC_BAD_ACCESS

//@property (nonatomic, assign) NSString *description;

@property (nonatomic, assign) NSString *sort;

@property (nonatomic, assign) NSString *category_ids;

@property (nonatomic, assign) NSString *is_hot;

@property (nonatomic, assign) NSString *brand_company;

@property (nonatomic, assign) NSString *address;

@property (nonatomic, assign) NSString *brand_init;

@property (nonatomic, assign) NSString *brand_id;




@end
