//
//  zxb_objGroup.h
//  vitagou
//
//  Created by Mac on 2017/4/20.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface zxb_objGroup : NSObject

@property (nonatomic, assign) NSString *id;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, assign) NSString *parent_id;

@property (nonatomic, assign) NSString *sort;

@property (nonatomic, assign) NSString *visibility;

@property (nonatomic, assign) NSString *intro;

@property (nonatomic, strong) NSString *img;

@property (nonatomic, assign) NSString *keywords;

@property (nonatomic, assign) NSString *descript;

@property (nonatomic, assign) NSString *title;

@property (nonatomic, assign) NSString *price_points;

@property (nonatomic, assign) NSString *recommend;

@property (nonatomic, assign) NSString *category_id;

@property (nonatomic, assign) NSString *brand_id;

@end
