//
//  HMSegmentControl.h
//  collectionIos
//
//  Created by Mac on 2018/1/8.
//  Copyright © 2018年 Vitagou. All rights reserved.
//

@class HMSegmentedControl;

typedef void (^IndexChangeBlock)(NSInteger index);

typedef NSAttributedString *(^HMTitleFormatterBlock)(HMSegmentedControl *segmentedControl, NSString *title, NSUInteger index, BOOL selected);

//切换tab的  选择风格
typedef NS_ENUM(NSInteger, HMSegmentedControlSelectionStyle) {
    HMSegmentedControlSelectionStyleTextWidthStripe, // Indicator width will only be as big as the text width 只有文字宽度的风格
    HMSegmentedControlSelectionStyleFullWidthStripe, // Indicator width will fill the whole segment  填满整个分割段的风格
    HMSegmentedControlSelectionStyleBox, // A rectangle that covers the whole segment 填满整个分割段的矩形风格
    HMSegmentedControlSelectionStyleArrow // An in the middle of the segment pointing up or down depending on `HMSegmentedControlSelectionIndicatorLocation`
};

//指示器的位置
typedef NS_ENUM(NSInteger, HMSegmentedControlSelectionIndicatorLocation) {
    HMSegmentedControlSelectionIndicatorLocationUp,
    HMSegmentedControlSelectionIndicatorLocationDown,
    HMSegmentedControlSelectionIndicatorLocationNone // No selection indicator
};

//指示器 tab的 宽度的设置
typedef NS_ENUM(NSInteger, HMSegmentedControlSegmentWidthStyle) {
    HMSegmentedControlSegmentWidthStyleFixed, // Segment width is fixed
    HMSegmentedControlSegmentWidthStyleDynamic, // Segment width will only be as big as the text width (including inset)
};

//边界类型
typedef NS_OPTIONS(NSInteger, HMSegmentedControlBorderType) {
    HMSegmentedControlBorderTypeNone = 0,
    HMSegmentedControlBorderTypeTop = (1 << 0),
    HMSegmentedControlBorderTypeLeft = (1 << 1),
    HMSegmentedControlBorderTypeBottom = (1 << 2),
    HMSegmentedControlBorderTypeRight = (1 << 3)
};

//没有选择的赋值
enum {
    HMSegmentedControlNoSegment = -1   // Segment index for no selected segment
};

//指示器的控制类型 图片 文字 多图
typedef NS_ENUM(NSInteger, HMSegmentedControlType) {
    HMSegmentedControlTypeText,
    HMSegmentedControlTypeImages,
    HMSegmentedControlTypeTextImages
};

//指示器中图片的位置
typedef NS_ENUM(NSInteger, HMSegmentedControlImagePosition) {
    HMSegmentedControlImagePositionBehindText,
    HMSegmentedControlImagePositionLeftOfText,
    HMSegmentedControlImagePositionRightOfText,
    HMSegmentedControlImagePositionAboveText,
    HMSegmentedControlImagePositionBelowText
};

@interface HMSegmentedControl : UIControl

//@property (nonatomic, readwrite) CGFloat segmentWidth;

//指示器 标题
@property (nonatomic, strong) NSArray<NSString *> *sectionTitles;

//指示器 标题图片
@property (nonatomic, strong) NSArray<UIImage *> *sectionImages;

//指示器 标题被选择的图片
@property (nonatomic, strong) NSArray<UIImage *> *sectionSelectedImages;

/**
 Provide a block to be executed when selected index is changed.
 Alternatively, you could use `addTarget:action:forControlEvents:
 指示器被选择时的位置
 */
@property (nonatomic, copy) IndexChangeBlock indexChangeBlock;

/**
 Used to apply custom text styling to titles when set.
 When this block is set, no additional styling is applied to the `NSAttributedString` object returned from this block.
 文字风格
 */
@property (nonatomic, copy) HMTitleFormatterBlock titleFormatter;

/**
 Text attributes to apply to item title text.
 标题文字属性
 */
@property (nonatomic, strong) NSDictionary *titleTextAttributes UI_APPEARANCE_SELECTOR;

/*
 Text attributes to apply to selected item title text.
 Attributes not set in this dictionary are inherited from `titleTextAttributes`.
 被选择标题文字属性
 */
@property (nonatomic, strong) NSDictionary *selectedTitleTextAttributes UI_APPEARANCE_SELECTOR;

/**
 Segmented control background color.
 Default is `[UIColor whiteColor]`
 “UI_APPEARANCE_SELECTOR” 苹果原生风格的UI
 */
@property (nonatomic, strong) UIColor *backgroundColor UI_APPEARANCE_SELECTOR;

/**
 Color for the selection indicator stripe
 Default is `R:52, G:181, B:229`
 默认被选择时候的背景色
 */
@property (nonatomic, strong) UIColor *selectionIndicatorColor UI_APPEARANCE_SELECTOR;

/**
 Color for the selection indicator box
 Default is selectionIndicatorColor
 指示器box默认被选择时候的背景色
 */
@property (nonatomic, strong) UIColor *selectionIndicatorBoxColor UI_APPEARANCE_SELECTOR;

/**
 Color for the vertical divider between segments.
 Default is `[UIColor blackColor]`
 竖直方向分割线的颜色
 */
@property (nonatomic, strong) UIColor *verticalDividerColor UI_APPEARANCE_SELECTOR;

/**
 Opacity for the seletion indicator box.
 Default is `0.2f`
 透明度设置
 */
@property (nonatomic) CGFloat selectionIndicatorBoxOpacity;

/**
 Width the vertical divider between segments that is added when `verticalDividerEnabled` is set to YES.
 Default is `1.0f`
 透明度设置
 */
@property (nonatomic, assign) CGFloat verticalDividerWidth;

/**
 Specifies the style of the control
 Default is `HMSegmentedControlTypeText`
 指示器类型
 */
@property (nonatomic, assign) HMSegmentedControlType type;

/**
 Specifies the style of the selection indicator.
 Default is `HMSegmentedControlSelectionStyleTextWidthStripe`
 被选中是的类型
 */
@property (nonatomic, assign) HMSegmentedControlSelectionStyle selectionStyle;

/**
 Specifies the style of the segment's width.
 Default is `HMSegmentedControlSegmentWidthStyleFixed`
 指定宽度
 */
@property (nonatomic, assign) HMSegmentedControlSegmentWidthStyle segmentWidthStyle;

/**
 Specifies the location of the selection indicator.
 Default is `HMSegmentedControlSelectionIndicatorLocationUp`
 指定位置 默认是在屏幕上方
 */
@property (nonatomic, assign) HMSegmentedControlSelectionIndicatorLocation selectionIndicatorLocation;

/*
 Specifies the border type.
 Default is `HMSegmentedControlBorderTypeNone`
 分割线类型  默认是没有分割线
 */
@property (nonatomic, assign) HMSegmentedControlBorderType borderType;

/**
 Specifies the image position relative to the text. Only applicable for HMSegmentedControlTypeTextImages
 图片的位置 默认是在文字之后
 Default is `HMSegmentedControlImagePositionBehindText`
 */
@property (nonatomic) HMSegmentedControlImagePosition imagePosition;

/**
 Specifies the distance between the text and the image. Only applicable for HMSegmentedControlTypeTextImages
 指定图片和文字的距离 只有在图片和文字都在的时候才有效
 Default is `0,0`
 */
@property (nonatomic) CGFloat textImageSpacing;

/**
 Specifies the border color.
 分割线的颜色 默认 black
 Default is `[UIColor blackColor]`
 */
@property (nonatomic, strong) UIColor *borderColor;

/**
 Specifies the border width.
 分割线宽度 默认 1.0
 Default is `1.0f`
 */
@property (nonatomic, assign) CGFloat borderWidth;

/**
 Default is YES. Set to NO to deny scrolling by dragging the scrollView by the user. 是否支持拖曳滑动 默认否
 */
@property(nonatomic, getter = isUserDraggable) BOOL userDraggable;

/**
 Default is YES. Set to NO to deny any touch events by the user.
 是否支持触摸事件 默认否
 */
@property(nonatomic, getter = isTouchEnabled) BOOL touchEnabled;

/**
 Default is NO. Set to YES to show a vertical divider between the segments.
 是否显示分割线 默认否
 */
@property(nonatomic, getter = isVerticalDividerEnabled) BOOL verticalDividerEnabled;

//是否适应屏幕
@property (nonatomic, getter=shouldStretchSegmentsToScreenSize) BOOL stretchSegmentsToScreenSize;

/**
 Index of the currently selected segment.当前index
 */
@property (nonatomic, assign) NSInteger selectedSegmentIndex;

/**
 Height of the selection indicator. Only effective when `HMSegmentedControlSelectionStyle` is either `HMSegmentedControlSelectionStyleTextWidthStripe` or `HMSegmentedControlSelectionStyleFullWidthStripe`.
 那条在上或者在下的默认的 横条的高度
 Default is 5.0
 */
@property (nonatomic, readwrite) CGFloat selectionIndicatorHeight;

/**
 Edge insets for the selection indicator.
 NOTE: This does not affect the bounding box of HMSegmentedControlSelectionStyleBox
 When HMSegmentedControlSelectionIndicatorLocationUp is selected, bottom edge insets are not used
 When HMSegmentedControlSelectionIndicatorLocationDown is selected, top edge insets are not used
 边缘内边距 只在 stylebox 的时候支持这个属性
 Defaults are top: 0.0f
 left: 0.0f
 bottom: 0.0f
 right: 0.0f
 */
@property (nonatomic, readwrite) UIEdgeInsets selectionIndicatorEdgeInsets;

/**
 Inset left and right edges of segments.
 左右边距
 Default is UIEdgeInsetsMake(0, 5, 0, 5)
 */
@property (nonatomic, readwrite) UIEdgeInsets segmentEdgeInset;

@property (nonatomic, readwrite) UIEdgeInsets enlargeEdgeInset;

/**
 Default is YES. Set to NO to disable animation during user selection.
 切换动画
 */
@property (nonatomic) BOOL shouldAnimateUserSelection;

- (id)initWithSectionTitles:(NSArray<NSString *> *)sectiontitles;//初始化标题

- (id)initWithSectionImages:(NSArray<UIImage *> *)sectionImages sectionSelectedImages:(NSArray<UIImage *> *)sectionSelectedImages;//初始化图片 未选中 和 选中的 状态

- (instancetype)initWithSectionImages:(NSArray<UIImage *> *)sectionImages sectionSelectedImages:(NSArray<UIImage *> *)sectionSelectedImages titlesForSections:(NSArray<NSString *> *)sectiontitles;//根据index 的位置设置图片数组用来显示 不同位置的 不同图片

- (void)setSelectedSegmentIndex:(NSUInteger)index animated:(BOOL)animated;//设置索引值

- (void)setIndexChangeBlock:(IndexChangeBlock)indexChangeBlock;//代码块声明

- (void)setTitleFormatter:(HMTitleFormatterBlock)titleFormatter;//代码块声明

@end
