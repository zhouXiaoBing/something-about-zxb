//
//  CyrclePagerView.m
//  collectionIos
//
//  Created by Mac on 2018/1/17.
//  Copyright © 2018年 Vitagou. All rights reserved.
//

#import "CyrclePagerView.h"

typedef struct {
    NSInteger index;
    NSInteger section;
}IndexSection;

NS_INLINE BOOL TYEqualIndexSection(IndexSection indexSection1,IndexSection indexSection2) {
    return indexSection1.index == indexSection2.index && indexSection1.section == indexSection2.section;
}

NS_INLINE IndexSection TYMakeIndexSection(NSInteger index, NSInteger section) {
    IndexSection indexSection;
    indexSection.index = index;
    indexSection.section = section;
    return indexSection;
}


@interface CyrclePagerView ()<UICollectionViewDelegate,UICollectionViewDataSource,CyrclePagerTransformLayoutDelegate>
{
    struct {
        unsigned int pagerViewDidScroll :1;
        unsigned int didScrollFromIndexToNewIndex   :1;
        unsigned int initializeTransformAttributes   :1;
        unsigned int applyTransformToAttributes   :1;
    }_delegateFlags;
    struct {
        unsigned int cellForItemAtIndex   :1;
        unsigned int layoutForPagerView   :1;
    }_dataSourceFlags;
}

//UI
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, strong) CyrclePagerViewLayout *layout;
@property (nonatomic, strong) NSTimer *timer;

//data
@property (nonatomic, assign) NSInteger numberOfItems;

@property (nonatomic, assign) IndexSection indexSection; // current index
@property (nonatomic, assign) NSInteger dequeueSection;
@property (nonatomic, assign) IndexSection beginDragIndexSection;
@property (nonatomic, assign) NSInteger firstScrollIndex;

@property (nonatomic, assign) BOOL needClearLayout;
@property (nonatomic, assign) BOOL didReloadData;
@property (nonatomic, assign) BOOL didLayout;

@end

#define kPagerViewMaxSectionCount 200
#define kPagerViewMinSectionCount 18

@implementation CyrclePagerView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configureProperty];
        
        [self addCollectionView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self configureProperty];
        
        [self addCollectionView];
    }
    return self;
}

- (void)configureProperty {
    _didReloadData = NO;
    _didLayout = NO;
    _autoScrollInterval = 0;
    _isInfiniteLoop = YES;
    _beginDragIndexSection.index = 0;
    _beginDragIndexSection.section = 0;
    _indexSection.index = -1;
    _indexSection.section = -1;
    _firstScrollIndex = -1;
}

-(void)addCollectionView{
    CyrclePagerTransformLayout *layout = [[CyrclePagerTransformLayout alloc]init];
    UICollectionView * collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    layout.delegate = _delegateFlags.applyTransformToAttributes ? self : nil;
    
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.pagingEnabled = NO;
    collectionView.decelerationRate = 1-0.0076;
    

    //是否预加载
    if ([collectionView respondsToSelector:@selector(setPrefetchingEnabled:)]) {
        collectionView.prefetchingEnabled = NO;
    }
    
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    [self addSubview:collectionView];
    _collectionView = collectionView;
    
}

-(void)willMoveToSuperview:(UIView *)newSuperview{
    if (!newSuperview) {
        [self removeTimer];
    }else {
        [self removeTimer];
        if (_autoScrollInterval > 0) {
            [self addTimer];
        }
    }
}

#pragma mark - 定时器
-(void)addTimer{
    if (_timer) {
        return;
    }
    _timer = [NSTimer timerWithTimeInterval:_autoScrollInterval target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    
    
}

-(void)removeTimer{
    if (!_timer) {
        return;
    }
    [_timer invalidate];
    _timer = nil;
}


-(void)timerFired:(NSTimer *)timer{
    if (!self.superview || !self.window || _numberOfItems == 0 || self.tracking) {
        return;
    }
    [self scrollToNearlyIndexAtDirection:PagerScrollDirectionRight animate:YES];//自动右滑
}


#pragma mark - getter
-(CyrclePagerViewLayout *)layout {
    if (!_layout) {
        if (_dataSourceFlags.layoutForPagerView) {
            _layout = [_dataSoure layoutForPagerView:self];
            _layout.isInfiniteLoop = _isInfiniteLoop;
        }
        if (_layout.itemSize.width <= 0 || _layout.itemSize.height <= 0) {
            _layout = nil;
        }
    }
    return _layout;
}

-(NSInteger)curIndex{
    return _indexSection.index;
}

-(CGPoint)contentOffset{
    return  _collectionView.contentOffset;
}

-(BOOL)tracking{
    return _collectionView.tracking;
}

-(BOOL)dragging{
    return  _collectionView.dragging;
}

-(BOOL)decelerating{
    return  _collectionView.decelerating;
}

- (UIView *)backgroundView {
    return _collectionView.backgroundView;
}

- (__kindof UICollectionViewCell *)curIndexCell {
    return [_collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:_indexSection.index inSection:_indexSection.section]];
}

- (NSArray<__kindof UICollectionViewCell *> *)visibleCells {
    return _collectionView.visibleCells;
}

- (NSArray *)visibleIndexs {
    NSMutableArray *indexs = [NSMutableArray array];
    for (NSIndexPath *indexPath in _collectionView.indexPathsForVisibleItems) {
        [indexs addObject:@(indexPath.item)];
    }
    return [indexs copy];
}

#pragma mark - setter

-(void)setBackgroudView:(UIView *)backgroudView{
    [_collectionView setBackgroundView:backgroudView];
}

-(void)setAutoScrollInterval:(CGFloat)autoScrollInterval{
    _autoScrollInterval = autoScrollInterval;
    [self removeTimer];
    if (autoScrollInterval > 0 && self.superview) {
        [self addTimer];
    }
}

- (void)setDelegate:(id<CyrclePagerViewDelegate>)delegate{
    _delegate = delegate;
    _delegateFlags.pagerViewDidScroll = [delegate respondsToSelector:@selector(pagerViewDidScroll:)];
    _delegateFlags.didScrollFromIndexToNewIndex = [delegate respondsToSelector:@selector(pagerView:didScrollFromIndex:toIndex:)];
    _delegateFlags.initializeTransformAttributes = [delegate respondsToSelector:@selector(pagerView:initializeTransformAttributes:)];
    
    _delegateFlags.applyTransformToAttributes = [delegate respondsToSelector:@selector(pagerView:applyTransformToAttributes:)];
    
    if (self.collectionView && self.collectionView.collectionViewLayout) {
        ((CyrclePagerTransformLayout *)self.collectionView.collectionViewLayout).delegate = _delegateFlags.applyTransformToAttributes ? self : nil;
    }
}

-(void)setDataSoure:(id<CyrclePagerViewDataSource>)dataSoure{
    _dataSoure = dataSoure;
    _dataSourceFlags.cellForItemAtIndex = [dataSoure respondsToSelector:@selector(pageView:cellForItemAtIndex:)];
    
    _dataSourceFlags.layoutForPagerView = [dataSoure respondsToSelector:@selector(layoutForPagerView:)];
}

#pragma mark - public

- (void)reloadData {
    _didReloadData = YES;
    [self setNeedClearLayout];
//    [self clearLayout];
    [self updateData];
}

-(void)updateData{
//    [self updateLayout];/
    _numberOfItems = [_dataSoure numberOfItemsInpagerView:self];
    [_collectionView reloadData];
    
    if (!_didLayout && !CGRectIsEmpty(self.frame) && _indexSection.index < 0) {
        _didLayout = YES;
    }
//    [self resetPagerViewAtIndex:_indexSection.index < 0 && !CGRectIsEmpty(self.frame) ? 0 : _indexSection.index];
}

-(void)scrollToNearlyIndexAtDirection:(PagerScrollDirection)direction animate:(BOOL)animate{
//    IndexSection indexSection = [self nearlyIndexPathAtDirection:direction];
//     [self scrollToItemAtIndexSection:indexSection animate:animate];
}





























@end
