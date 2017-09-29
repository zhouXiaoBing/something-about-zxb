//
//  zxb_category.h
//  vitagou
//
//  Created by Mac on 2017/8/7.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

@interface zxb_category : NSObject

@property (nonatomic, assign) NSString *id;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, assign) NSString *parent_id;

@property (nonatomic, assign) NSString *sort;

@property (nonatomic, assign) NSString *visibility;

@property (nonatomic, assign) NSString *intro;

@property (nonatomic, assign) NSString *img;

@property (nonatomic, assign) NSString *keywords;

@property (nonatomic, assign) NSString *descript;

@property (nonatomic, assign) NSString *title;

@property (nonatomic, assign) NSString *price_points;

@property (nonatomic, assign) NSString *recommend;

@property (nonatomic, assign) NSString *category_id;


@end
