//
//  CyrclePagerTransformLayout.m
//  collectionIos
//
//  Created by Mac on 2018/1/17.
//  Copyright © 2018年 Vitagou. All rights reserved.
//

#import "CyrclePagerTransformLayout.h"

typedef NS_ENUM(NSInteger, TransformLayoutItemDirection) {
    TransformLayoutItemLeft,
    TransformLayoutItemCenter,
    TransformLayoutItemRight,
};


@interface CyrclePagerTransformLayout(){
    struct{
        unsigned int applyTransformToAttributes  :1;
        unsigned int initializeTransformAttributes :1;
    }_delegateFlags;
}

@property(nonatomic, assign) BOOL applyTransformToAttributesDelegate;

@end

@interface CyrclePagerViewLayout()

@property(nonatomic, weak) UIView *pageView;

@end

@implementation CyrclePagerTransformLayout

- (instancetype)init {
    if (self = [super init]) {
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return self;
}

-(void)setDelegate:(id<CyrclePagerTransformLayoutDelegate>)delegate{
    _delegate = delegate;
    _delegateFlags.initializeTransformAttributes = [delegate respondsToSelector:@selector(pagerViewTransformLayout:initializeTransformAttributes:)];
    
    _delegateFlags.applyTransformToAttributes = [delegate respondsToSelector:@selector(pagerViewTransformLayout:applyTransformToAttributes:)];
    
}

-(void)setLayout:(CyrclePagerViewLayout *)layout{
    _layout = layout;
    _layout.pageView = self.collectionView;
    self.itemSize = _layout.itemSize;
    self.minimumInteritemSpacing = _layout.itemSpacing;
    self.minimumLineSpacing = _layout.itemSpacing;
}

-(CGSize)itemSize {
    if (!_layout) {
        return [super itemSize];
    }
    return _layout.itemSize;
}

- (CGFloat)minimumLineSpacing {
    if (!_layout) {
        return [super minimumLineSpacing];
    }
    return _layout.itemSpacing;
}

- (CGFloat)minimumInteritemSpacing {
    if (!_layout) {
        return [super minimumInteritemSpacing];
    }
    return _layout.itemSpacing;
}

//滑动后判断移动的方向
-(TransformLayoutItemDirection)directionWithCenterX:(CGFloat)centerX{
    
    TransformLayoutItemDirection direction = TransformLayoutItemRight;
    
    CGFloat contentCenterX = self.collectionView.contentOffset.x + CGRectGetWidth(self.collectionView.frame)/2;
    if (ABS(centerX - contentCenterX) < 0.5) {
        direction = TransformLayoutItemCenter;
    }//引入绝对值 小距离移动发生轮播事件
    else if (centerX - contentCenterX < 0){
        direction = TransformLayoutItemLeft;
    }
    return direction;
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return _layout.layoutType == CyrclePagerTransformLayoutNormal ? [super shouldInvalidateLayoutForBoundsChange:newBounds] : YES;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    if (_delegateFlags.applyTransformToAttributes || _layout.layoutType != CyrclePagerTransformLayoutNormal) {
        NSArray *attributesArray = [[NSArray alloc]initWithArray:[super layoutAttributesForElementsInRect:rect] copyItems:YES];
        //contentOffset 是CGpoint（struct）坐标 size ：CGSize strut 长宽 坐标和长宽决定了显示的位置和效果
        CGRect visibleRect = {self.collectionView.contentOffset,self.collectionView.bounds.size};
        
        for (UICollectionViewLayoutAttributes *attributes in attributesArray) {
            if (!CGRectIntersectsRect(visibleRect,attributes.frame)) {
                continue;
            }
            if(_delegateFlags.applyTransformToAttributes){
                [_delegate pagerViewTransformLayout:self applyTransformToAttributes:attributes];
            }else{
                [self applyTransformToAttributes:attributes layoutType:_layout.layoutType];
            }
        }
        return attributesArray;
    }
    return [super layoutAttributesForElementsInRect:rect];
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes * attributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    if (_delegateFlags.initializeTransformAttributes) {
        [_delegate pagerViewTransformLayout:self applyTransformToAttributes:attributes];
    }else if(_layout.layoutType != CyrclePagerTransformLayoutNormal){
        [self initializeTransformAttributes:attributes layoutType:_layout.layoutType];
    }
    return attributes;
}

-(void)initializeTransformAttributes:(UICollectionViewLayoutAttributes *)attributes layoutType:(CyrclePagerTransformLayoutType)layoutType{
    switch (layoutType) {
        case CyrclePagerTransformLayoutLiner:
            [self applyLinearTransformToAttributes:attributes scale:_layout.minimumScale alpha:_layout.minimumAlpha];
            break;
        case CyrclePagerTransformLayoutCoverflow:
        {
            [self applyCoverflowTransformToAttributes:attributes angle:_layout.maximumAngle alpha:_layout.minimumAlpha];
            break;
        }
        default:
            break;
    }
}

-(void)applyTransformToAttributes:(UICollectionViewLayoutAttributes *)attributes layoutType:(CyrclePagerTransformLayoutType)layoutType{
    switch (layoutType) {
        
        case CyrclePagerTransformLayoutLiner:
            [self applyLinearTransformToAttributes:attributes];
            break;
        case CyrclePagerTransformLayoutCoverflow:
            [self applyCoverflowTransformToAttributes:attributes];
            
            break;
        default:
            break;
    }
}

-(void)applyLinearTransformToAttributes:(UICollectionViewLayoutAttributes *)attributes{
    CGFloat collectionViewWidth = self.collectionView.frame.size.width;
    if (collectionViewWidth <= 0) {
        return;
    }
    CGFloat centerX = self.collectionView.contentOffset.x + collectionViewWidth/2;
    
    CGFloat delta = ABS(attributes.center.x - centerX);
    CGFloat scale = MAX(1 - delta/collectionViewWidth*_layout.rateOfChange, _layout.minimumScale);
    CGFloat alpha = MAX(1-delta/collectionViewWidth*_layout.rateOfChange, _layout.minimumAlpha);
    
     [self applyLinearTransformToAttributes:attributes scale:scale alpha:alpha];
}
     
 -(void)applyLinearTransformToAttributes:(UICollectionViewLayoutAttributes *)attributes scale:(CGFloat)scale alpha:(CGFloat)alpha{
     
     CGAffineTransform transform = CGAffineTransformMakeScale(scale, scale);
     if(_layout.adjustSpacingWhenScroling){
         TransformLayoutItemDirection direction = [self directionWithCenterX:attributes.center.x];
         CGFloat translate = 0;
         switch(direction){
             case TransformLayoutItemLeft:
                 translate = 1.15 * attributes.size.width*(1-scale)/2;
                 break;
             case TransformLayoutItemRight:
                 translate = -1.15 * attributes.size.width*(1-scale)/2;
                 break;
             default:
                 // center
                 scale = 1.0;
                 alpha = 1.0;
                 break;
         }
         transform = CGAffineTransformTranslate(transform,translate, 0);
     }
     attributes.transform = transform;
     attributes.alpha = alpha;
 }

- (void)applyCoverflowTransformToAttributes:(UICollectionViewLayoutAttributes *)attributes{
    CGFloat collectionViewWidth = self.collectionView.frame.size.width;
    if (collectionViewWidth <= 0) {
        return;
    }
    
    CGFloat centerX = self.collectionView.contentOffset.x + collectionViewWidth/2;
    
    CGFloat delta = ABS(attributes.center.x - centerX);
    CGFloat angle = MIN(delta/collectionViewWidth*(1-_layout.rateOfChange), _layout.maximumAngle);
    CGFloat alpha = MAX(1-delta/collectionViewWidth, _layout.minimumAlpha);
    [self applyCoverflowTransformToAttributes:attributes angle:angle alpha:alpha];
    
}

-(void)applyCoverflowTransformToAttributes:(UICollectionViewLayoutAttributes *)attributes angle:(CGFloat)angle alpha:(CGFloat)alpha{
    TransformLayoutItemDirection direction = [self directionWithCenterX:attributes.center.x];
    
    CATransform3D transform3D = CATransform3DIdentity;
    transform3D.m34 = -0.002;
    CGFloat translate = 0 ;
    
    switch (direction) {
            
        case TransformLayoutItemLeft:
            translate = (1-cos(angle*1.2*M_PI))*attributes.size.width;
            break;
        case TransformLayoutItemRight:
            translate = -(1-cos(angle*1.2*M_PI))*attributes.size.width;
            angle = -angle;
            break;
            
        default:
            angle = 0;
            alpha = 1;
            break;
    }
    
    transform3D = CATransform3DRotate(transform3D, M_PI*angle, 0, 1, 0);
    if (_layout.adjustSpacingWhenScroling) {
        transform3D = CATransform3DTranslate(transform3D, translate, 0, 0);
    }
    attributes.transform3D = transform3D;
    attributes.alpha = alpha;
}


@end

@implementation CyrclePagerViewLayout

-(instancetype)init{
    if (self = [super init]) {
        _itemVerticalCenter = YES;
        _minimumScale = 0.8;
        _minimumAlpha = 1.0;
        _maximumAngle = 0.2;
        _rateOfChange = 0.4;
        _adjustSpacingWhenScroling = YES;
    }
    return self;
}

-(UIEdgeInsets)onlyOneSectionInset{
    CGFloat leftSpace = _pageView && !_isInfiniteLoop && _itemHorizontalCenter ? (CGRectGetWidth(_pageView.frame) - _itemSize.width)/2 : _sectionInset.left;
    CGFloat rightSpace = _pageView && !_isInfiniteLoop && _itemHorizontalCenter ? (CGRectGetWidth(_pageView.frame) - _itemSize.width)/2 : _sectionInset.right;
    
    if (_itemVerticalCenter) {
        CGFloat verticalSpace = (CGRectGetHeight(_pageView.frame)-_itemSize.height)/2;
        return UIEdgeInsetsMake(verticalSpace, leftSpace, verticalSpace, rightSpace);
    }
    return UIEdgeInsetsMake(_sectionInset.top, leftSpace, _sectionInset.bottom, rightSpace);
}

- (UIEdgeInsets)firstSectionInset {
    if (_itemVerticalCenter) {
        CGFloat verticalSpace = (CGRectGetHeight(_pageView.frame) - _itemSize.height)/2;
        return UIEdgeInsetsMake(verticalSpace, _sectionInset.left, verticalSpace, _itemSpacing);
    }
    return UIEdgeInsetsMake(_sectionInset.top, _sectionInset.left, _sectionInset.bottom, _itemSpacing);
}

- (UIEdgeInsets)lastSectionInset {
    if (_itemVerticalCenter) {
        CGFloat verticalSpace = (CGRectGetHeight(_pageView.frame) - _itemSize.height)/2;
        return UIEdgeInsetsMake(verticalSpace, 0, verticalSpace, _sectionInset.right);
    }
    return UIEdgeInsetsMake(_sectionInset.top, 0, _sectionInset.bottom, _sectionInset.right);
}

- (UIEdgeInsets)middleSectionInset {
    if (_itemVerticalCenter) {
        CGFloat verticalSpace = (CGRectGetHeight(_pageView.frame) - _itemSize.height)/2;
        return UIEdgeInsetsMake(verticalSpace, 0, verticalSpace, _itemSpacing);
    }
    return _sectionInset;
}
@end

