//
//  SearchNavView.h
//  vitagou
//
//  Created by Mac on 2018/7/20.
//  Copyright © 2018年 vitagou. All rights reserved.
//
/**
 *替换原有的NavigationBar
 *1.一个logo图片 imageView
 *2.一个形似searchView的可点击跳转到searchView的UIButton
 */
#import <UIKit/UIKit.h>

@class SearchNavView;

@protocol SearchViewDelegate <NSObject>

@optional
/** searchView 的点击*/
- (void)searchViewEvent:(UIView *)sender search:(SearchNavView *)searchBar;
@end

@interface SearchNavView : UIView

/** 底部的分割线 */
@property (assign, nonatomic) UIView *bottomSeparateLine;

/** 左边的logo */
@property (assign, nonatomic) UIImageView *leftLogo;

/** 类似搜索框的UIView */
@property (assign, nonatomic) UIButton *searchView;

/** searchView 点击事件的的代理 */
@property (assign,nonatomic) id<SearchViewDelegate> searchDelegate;
@end



