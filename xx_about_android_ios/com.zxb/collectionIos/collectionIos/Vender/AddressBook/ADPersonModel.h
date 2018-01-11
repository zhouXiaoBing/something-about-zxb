//
//  ADPersonModel.h
//  collectionIos
//
//  Created by Mac on 2018/1/11.
//  Copyright © 2018年 Vitagou. All rights reserved.
//

@interface ADPersonModel : NSObject

/** 联系人姓名*/
@property (nonatomic, copy) NSString *name;
/** 联系人电话数组,因为一个联系人可能存储多个号码*/
@property (nonatomic, strong) NSMutableArray *mobileArray;
/** 联系人头像*/
@property (nonatomic, strong) UIImage *headerImage;


@end
