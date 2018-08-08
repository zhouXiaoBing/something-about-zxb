//
//  ItemSection.h
//  vitagou
//
//  Created by Mac on 2018/7/19.
//  Copyright © 2018年 vitagou. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WordItem;
@interface ItemSection : NSObject

/** <#digest#> */
@property (nonatomic, copy) NSString *headerTitle;

/** <#digest#> */
@property (nonatomic, copy) NSString *footerTitle;

/** <#digest#> */
@property (nonatomic, strong) NSMutableArray<WordItem *> *items;

+ (instancetype)sectionWithItems:(NSArray<WordItem *> *)items andHeaderTitle:(NSString *)headerTitle footerTitle:(NSString *)footerTitle;

@end
