//
//  CyrclePagerTransformLayout.h
//  collectionIos
//
//  Created by Mac on 2018/1/17.
//  Copyright © 2018年 Vitagou. All rights reserved.
//




NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,CyrclePagerTransformLayoutType) {
    CyrclePagerTransformLayoutNormal,
    CyrclePagerTransformLayoutLiner,
    CyrclePagerTransformLayoutCoverflow
};

@class CyrclePagerTransformLayout;

@protocol CyrclePagerTransformLayoutDelegate <NSObject>
//init
- (void)pagerViewTransformLayout:(CyrclePagerTransformLayout *)pagerViewTransformLayout initializeTransformAttributes:(UICollectionViewLayoutAttributes *)attributes;
//apply
-(void)pagerViewTransformLayout:(CyrclePagerTransformLayout *)pagerViewTransformLayout applyTransformToAttributes:(UICollectionViewLayoutAttributes *)attributes;

@end

@interface CyrclePagerViewLayout : NSObject

@property (nonatomic, assign) CGSize itemSize;

@property (nonatomic, assign) CGFloat itemSpacing;

@property (nonatomic, assign) UIEdgeInsets sectionInset;

@property (nonatomic, assign) CyrclePagerTransformLayoutType *layoutType;

@property (nonatomic, assign) CGFloat minimumScale; // sacle default 0.8

@property (nonatomic, assign) CGFloat minimumAlpha; // alpha default 1.0

@property (nonatomic, assign) CGFloat maximumAngle; // angle is % default 0.2

@property (nonatomic, assign) BOOL isInfiniteLoop;  // infinte scroll

@property (nonatomic, assign) CGFloat rateOfChange; // scale and angle change rate

@property (nonatomic, assign) BOOL adjustSpacingWhenScroling;

/**
 pageView cell item vertical centering
 */
@property (nonatomic, assign) BOOL itemVerticalCenter;

/**
 first and last item horizontalc enter, when isInfiniteLoop is NO
 */
@property (nonatomic, assign) BOOL itemHorizontalCenter;

// sectionInset
@property (nonatomic, assign, readonly) UIEdgeInsets onlyOneSectionInset;

@property (nonatomic, assign, readonly) UIEdgeInsets firstSectionInset;

@property (nonatomic, assign, readonly) UIEdgeInsets lastSectionInset;

@property (nonatomic, assign, readonly) UIEdgeInsets middleSectionInset;

@end

@interface CyrclePagerTransformLayout : UICollectionViewFlowLayout

@property (nonatomic, strong) CyrclePagerViewLayout *layout;

@property (nonatomic, weak, nullable) id<CyrclePagerTransformLayoutDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
