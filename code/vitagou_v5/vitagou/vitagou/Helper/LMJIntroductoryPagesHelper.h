//
//  LMJIntroductoryPagesHelper.h
//  vitagou
//
//  Created by Mac on 2018/7/13.
//  Copyright © 2018年 vitagou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LMJIntroductoryPagesHelper : NSObject

+ (instancetype)shareInstance;

+ (void)showIntroductoryPageView:(NSArray<NSString *> *)imageArray;

@end
