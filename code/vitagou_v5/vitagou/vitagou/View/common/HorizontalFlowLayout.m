//
//  HorizontalFlowLayout.m
//  vitagou
//
//  Created by Mac on 2018/8/30.
//  Copyright © 2018年 vitagou. All rights reserved.
//

#import "HorizontalFlowLayout.h"

#define XX(x) floorf(x)
#define XS(s) ceilf(s)

static const NSInteger Lines_ = 3;
static const CGFloat XMargin_ = 10;
static const CGFloat YMargin_ = 10;
static const UIEdgeInsets EdgeInsets_ = {10,10,10,10};

@interface HorizontalFlowLayout()

/**
 所有cell的attrbts
 */
@property (nonatomic,strong) NSMutableArray<UICollectionViewLayoutAttributes *> *AtrbsArray;

/** 每一列最后的高度 */
@property (nonatomic,strong) NSMutableArray<NSNumber *> *LinesWidthArray;

- (NSInteger)lines;

- (CGFloat)xMarginAtIndexPath:(NSIndexPath *)indexPath;

- (CGFloat)yMargin;

- (UIEdgeInsets)edgeInsets;

@end

@implementation HorizontalFlowLayout

- (instancetype)initWithDelegate:(id<HorizontalFlowLayoutDelegate>)delegate{
    if (self = [self init]) {
        
    }
    return self;
}

- (UIEdgeInsets)edgeInsets{
    if ([self.delegate respondsToSelector:@selector(waterflowLayout:edgeInsetsInCollectionView:)]) {
        return [self.delegate waterflowLayout:self edgeInsetsInCollectionView:self.collectionView];
    }
    else{
        return EdgeInsets_;
    }
}

- (id<HorizontalFlowLayoutDelegate>)delegate{

    return (id<HorizontalFlowLayoutDelegate>)self.collectionView.dataSource;
}

+ (instancetype)flowLayoutWithDelegate:(id<HorizontalFlowLayoutDelegate>)delegate{
    return [[self alloc] initWithDelegate:delegate];
}

/**
 刷新布局的时候重新调用
 */

- (void)prepareLayout{
    [super prepareLayout];
    //如果重新刷新就需要移除之前存储的高度
    [self.LinesWidthArray removeAllObjects];
    
    //赋值以顶部的高度，并且根据行数
    for (NSInteger i = 0; i < self.lines; i++) {
        [self.LinesWidthArray addObject:@(self.edgeInsets.left)];
    }
    // 移除以前计算的 cells 的 attrbs
    [self.AtrbsArray removeAllObjects];
    // 并且重新计算， 每个 cell 对应的 atrbs， 保存到数组
    for (NSInteger i = 0; i < [self.collectionView numberOfItemsInSection:0]; i++) {
        [self.AtrbsArray addObject:[self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]]];
    }
}

/**
 *在这里边所处每个cell对应的位置和大小
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *atrbs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGFloat h = 1.0 *(self.collectionView.frame.size.height - self.edgeInsets.top - self.edgeInsets.bottom -self.yMargin * (self.lines -1))/self.lines;
    h = XX(h);
    
    //宽度由外接决定，外界必须实现这个方法的
    CGFloat w = [self.delegate waterflowLayout:self collectionView:self.collectionView widthForItemAtIndexPath:indexPath itemHeight:h];
    
    // 拿到最后的高度最小的那一列， 假设第0列最小
    __block NSInteger indexLine = 0;
    __block CGFloat minLineW = [self.LinesWidthArray[indexLine] doubleValue];
    
    [self.LinesWidthArray enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat  lineW = obj.doubleValue;
        if (minLineW > lineW) {
            minLineW = lineW;
            indexLine = idx;
        }
    }];
    CGFloat x =  [self xMarginAtIndexPath:indexPath] + minLineW;
    
    if (minLineW == self.edgeInsets.left) {
        x = self.edgeInsets.left;
    }
    
    CGFloat y = self.edgeInsets.top + (self.yMargin + h)*indexLine;
    // 赋值 frame
    
    atrbs.frame = CGRectMake(x,y, w, h);
    
    self.LinesWidthArray[indexLine] = @(CGRectGetMaxX(atrbs.frame));
    
    return atrbs;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.AtrbsArray;
}

- (CGSize)collectionViewContentSize{
    __block CGFloat maxColW = [self.LinesWidthArray[0] doubleValue];
    
    [self.LinesWidthArray enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (maxColW < [obj doubleValue]) {
            maxColW = [obj doubleValue];
        }
    }];
    
    return  CGSizeMake(maxColW + self.edgeInsets.right, self.collectionView.frame.size.height);
    
}

- (NSMutableArray *)AtrbsArray{
    
    if (_AtrbsArray == nil) {
        _AtrbsArray = [NSMutableArray array];
        
    }
    return  _AtrbsArray;
}

- (NSMutableArray *)LinesWidthArray{
    if (_LinesWidthArray == nil) {
        _LinesWidthArray = [NSMutableArray array];
    }
    return _LinesWidthArray;
}

- (NSInteger)lines{
    if ([self.delegate respondsToSelector:@selector(waterflowLayout:linesInCollectionView:)]) {
        return  [self.delegate waterflowLayout:self linesInCollectionView:self.collectionView];
    }
    else{
        return Lines_;
    }
}

- (CGFloat)xMarginAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(waterflowLayout:collectionView:columnsMarginForItemAtIndexPath:)]) {
        return [self.delegate waterflowLayout:self collectionView:self.collectionView columnsMarginForItemAtIndexPath:indexPath];
    }
    else{
        return XMargin_;
    }
}

- (CGFloat)yMargin{
    
    if([self.delegate respondsToSelector:@selector(waterflowLayout:linesMarginInCollectionView:)])
    {
        return [self.delegate waterflowLayout:self linesMarginInCollectionView:self.collectionView];
    }else
    {
        return YMargin_;
    }
}
@end

























