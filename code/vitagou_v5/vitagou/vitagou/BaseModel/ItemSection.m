//
//  ItemSection.m
//  vitagou
//
//  Created by Mac on 2018/7/19.
//  Copyright © 2018年 vitagou. All rights reserved.
//

#import "ItemSection.h"


@implementation ItemSection

+ (instancetype)sectionWithItems:(NSArray<WordItem *> *)items andHeaderTitle:(NSString *)headerTitle footerTitle:(NSString *)footerTitle
{
    ItemSection *item = [[self alloc] init];
    if (items.count) {
        [item.items addObjectsFromArray:items];
    }
    
    item.headerTitle = headerTitle;
    item.footerTitle = footerTitle;
    
    return item;
}

- (NSMutableArray<WordItem *> *)items
{
    if(!_items)
    {
        _items = [NSMutableArray array];
    }
    return _items;
}

@end
