//
//  CyrclePagerView.h
//  collectionIos
//
//  Created by Mac on 2018/1/17.
//  Copyright © 2018年 Vitagou. All rights reserved.
//

#import "CyrclePagerTransformLayout.h"

NS_ASSUME_NONNULL_BEGIN

//pagerView 方向
typedef NS_ENUM(NSUInteger,PagerScrollDirection) {
 PagerScrollDirectionLeft,
    PagerScrollDirectionRight
};

@class CyrclePagerView;

@protocol CyrclePagerViewDataSource <NSObject>

-(NSInteger)numberOfItemsInpagerView:(CyrclePagerView *)pageView;

-(__kindof UICollectionViewCell *)pagerView:(CyrclePagerView *)pagerView cellForItemAtIndex:(NSInteger)index;

/**
 返回pageView的布局和缓存
 */
-(CyrclePagerViewLayout *)layoutForPagerView:(CyrclePagerView *)pageView;

@end

@protocol CyrclePagerViewDelegate <NSObject>

@optional //可选属性

/**
 pagerView did scroll to new index page
 */
- (void)pagerView:(CyrclePagerView *)pageView didScrollFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex;
/**
 pagerView did selected item cell
 */
-(void)pagerView:(CyrclePagerView *)pageView didSelectedItemCell:(__kindof UICollectionViewCell *)cell atIndex:(NSInteger)index;
// custom layout
-(void)pagerView:(CyrclePagerView *)pageView initializeTransformAttributes:(UICollectionViewLayoutAttributes *)attributes;

-(void)pagerView:(CyrclePagerView *)pageView applyTransformToAttributes:(UICollectionViewLayoutAttributes *)attributes;
// scrollViewDelegate

-(void)pagerViewDidScroll:(CyrclePagerView *)pageView;

-(void)pagerViewWillBeginDragging:(CyrclePagerView *)pageView;

-(void)pagerViewDidEndDragging:(CyrclePagerView *)pageView willDecelerate:(BOOL)decelerate;

-(void)pagerViewWillBeginDecelerating:(CyrclePagerView *)pageView;

-(void)pagerViewDidEndDeceleratuing:(CyrclePagerView *)pageView;

-(void)pagerViewWillBeginScrollingAnimation:(CyrclePagerView *)pageView;

-(void)pagerViewDidEndScrollingAnimation:(CyrclePagerView *)pageView;


@end

@interface CyrclePagerView : UIView

//will be automatically resized to track the size of the pagerView

@property (nonatomic, strong, nullable) UIView *backgroudView;

@property (nonatomic, weak, nullable) id<CyrclePagerViewDataSource>   dataSoure;

@property (nonatomic, weak, nullable) id<CyrclePagerViewDelegate> delegate;

//pager view do not set dataSource and delegate
@property (nonatomic, weak, readonly) UICollectionView *collectionView;

//pager view layout
@property (nonatomic, strong, readonly) CyrclePagerViewLayout *layout;

/**
 is infinite cyrcle pageView
 */
@property (nonatomic, assign) BOOL isInfiniteLoop;

/**
 pagerVeiw automatic scroll time interval, default 0, disable automatic  间距
 */
@property (nonatomic, assign) CGFloat autoScrollInterval;

/**
 current page index 当前页面的指针
 */
@property (nonatomic, assign, readonly) NSInteger curIndex;

/**
 scollView property 边距 轨迹  拖曳动作 加速
 */
@property (nonatomic, assign, readonly) CGPoint contentOffset;
@property (nonatomic, assign, readonly) BOOL tracking;
@property (nonatomic, assign, readonly) BOOL dragging;
@property (nonatomic, assign, readonly) BOOL decelerating;

/**
 reload data, !!important!!: will clear layout and call delegate layoutForPagerView
 */
- (void)reloadData;

/**
 update data is reload data, but not clear layuot
 */
- (void)updateData;

/**
 if you only want update layout
 */
- (void)setNeedUpdateLayout;

/**
 will set layout nil and call delegate->layoutForPagerView
 */
- (void)setNeedClearLayout;

/**
 current index cell in pagerView
 */
-(__kindof UICollectionViewCell * _Nullable)curIndexCell;
/**
 visible cells in pageView
 */
- (NSArray<__kindof UICollectionViewCell *> *_Nullable)visibleCells;

/**
 visible pageView indexs, maybe repeat index
 */
- (NSArray *)visibleIndexs;

/**
 scroll to item at index
 */
- (void)scrollToItemAtIndex:(NSInteger)index animate:(BOOL)animate;
/**
 scroll to next or pre item
 */
- (void)scrollToNearlyIndexAtDirection:(PagerScrollDirection)direction animate:(BOOL)animate;
/**
 register pager view cell with class
 */
- (void)registerClass:(Class)Class forCellWithReuseIdentifier:(NSString *)identifier;

/**
 register pager view cell with nib
 */
- (void)registerNib:(UINib *)nib forCellWithReuseIdentifier:(NSString *)identifier;

/**
 dequeue reusable cell for pagerView
 */
- (__kindof UICollectionViewCell *)dequeueReusableCellWithReuseIdentifier:(NSString *)identifier forIndex:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
