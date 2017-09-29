
//
//  UICollectionViewController+CurrentPage.m
//  vitagou
//
//  Created by Mac on 2017/7/31.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import "UICollectionViewController+CurrentPage.h"

@implementation UICollectionViewController (CurrentPage)

- (NSUInteger)setCurrentPageNumberWithLastPageNumber:(NSUInteger)pageNumber
                                          totalCount:(NSUInteger)count
                                              offset:(CGFloat)offset {
    
    NSUInteger currentPageNumber = pageNumber;
    
    for (NSUInteger i = 0; i < count; i++) {
        if (offset == self.view.frameWidth *i) {
            currentPageNumber = i;
        }
    }
    
    return currentPageNumber;
}

@end
