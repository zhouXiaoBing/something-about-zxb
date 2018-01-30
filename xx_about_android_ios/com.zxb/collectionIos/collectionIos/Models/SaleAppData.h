//
//  SaleAppData.h
//  collectionIos
//
//  Created by Mac on 2018/1/17.
//  Copyright © 2018年 Vitagou. All rights reserved.
//

#import "SaleResult.h"

@interface SaleAppData : NSObject

@property(nonatomic, strong) NSString *request_code;

@property(nonatomic, strong) NSString *reason;

@property(nonatomic, strong) SaleResult *result;

@end
