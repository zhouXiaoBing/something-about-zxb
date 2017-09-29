//
//  UICollectionViewController+CurrentPage.h
//  vitagou
//
//  Created by Mac on 2017/7/31.
//  Copyright © 2017年 Vitagou. All rights reserved.
//  根据上一次的位置和偏移量判断当前页码

#import <UIKit/UIKit.h>
//#import "UIViewController.h"

@interface UICollectionViewController (CurrentPage)


/**
 *  根据上一次的位置和滚动偏移量计算滚动停止后的页码
 *
 *  @param pageNumber   上一次的页码
 *  @param count        总页数
 *  @param offset       偏移量
 *
 *  @return 所滚到的页码
 */
- (NSUInteger)setCurrentPageNumberWithLastPageNumber:(NSUInteger)pageNumber
                                          totalCount:(NSUInteger)count
                                              offset:(CGFloat)offset;

@end
