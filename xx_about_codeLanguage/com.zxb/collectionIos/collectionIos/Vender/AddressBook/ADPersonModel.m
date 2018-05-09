//
//  ADPersonModel.m
//  collectionIos
//
//  Created by Mac on 2018/1/11.
//  Copyright © 2018年 Vitagou. All rights reserved.
//

#import "ADPersonModel.h"

@implementation ADPersonModel

- (NSMutableArray *)mobileArray
{
    if (!_mobileArray) {
    
        _mobileArray = [NSMutableArray array];
    
    }
    return _mobileArray;
}

@end
