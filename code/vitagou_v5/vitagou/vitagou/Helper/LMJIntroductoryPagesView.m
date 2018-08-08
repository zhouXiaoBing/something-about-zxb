//
//  LMJIntroductoryPagesView.m
//  vitagou
//
//  Created by Mac on 2018/7/12.
//  Copyright © 2018年 vitagou. All rights reserved.
//

#import "LMJIntroductoryPagesView.h"
#import <YYKit/YYAnimatedImageView.h>
#import <YYKit/YYImage.h>

@interface LMJIntroductoryPagesView()<UIScrollViewDelegate>

@property (nonatomic, strong) NSArray<NSString *> *imagesArray;

@property (nonatomic,strong) UIPageControl *pageControl;

@property (weak, nonatomic) UIScrollView *scrollView;

@end

@implementation LMJIntroductoryPagesView

+ (instancetype)pagesViewWithFrame:(CGRect)frame images:(NSArray<NSString *> *)images{
    
    LMJIntroductoryPagesView *pageView = [[self alloc]initWithFrame:frame];
    pageView.imagesArray = images;
    return pageView;
}

- (void)setupUIOnce{
    self.backgroundColor = [UIColor clearColor];
    
    //添加手势
    UITapGestureRecognizer *singleRecognizer;
    singleRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleSingleTapFrom)];
    
    
}

- (void)setImagesArray:(NSArray<NSString *> *)imagesArray{
    _imagesArray = imagesArray;
    [self loadPageView];
}

- (void)loadPageView{
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.scrollView.contentSize = CGSizeMake((self.imagesArray.count+1)*kScreen_Width,kScreen_Height);
    self.pageControl.numberOfPages = self.imagesArray.count;
    
    [self.imagesArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj,NSUInteger idx, BOOL * _Nonnull stop){
        YYAnimatedImageView *imageView = [[YYAnimatedImageView alloc]init];
        imageView.frame = CGRectMake(idx * kScreen_Width, 0, kScreen_Width, kScreen_Height);
        
        YYImage *image = [YYImage imageNamed:obj];
        
        [imageView setImage:image];
        
        [self.scrollView addSubview:imageView];
    }];
}

- (void)handleSingleTapFrom{
    if (_pageControl.currentPage == self.imagesArray.count-1) {
        [self removeFromSuperview];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint offset = scrollView.contentOffset;
    NSInteger page = (offset.x / (self.bounds.size.width) + 0.5);
    self.pageControl.currentPage = page;
    self.pageControl.hidden = (page > self.imagesArray.count - 1);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //滑到最后移除了整个控件
    if (scrollView.contentOffset.x >= (_imagesArray.count)*kScreen_Width) {
        [self removeFromSuperview];
    }
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        [self addSubview:scrollView];
        scrollView.backgroundColor = [UIColor clearColor];
        scrollView.pagingEnabled = YES;
        scrollView.bounces = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.delegate = self;
        _scrollView = scrollView;
    }
    return _scrollView;
}

- (UIPageControl *)pageControl{
    if (_pageControl) {
        UIPageControl *pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(kScreen_Width/2, kScreen_Height-60, 0, 40)];
        pageControl.backgroundColor = [UIColor clearColor];
        pageControl.pageIndicatorTintColor = [UIColor grayColor];
        pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        [self addSubview:pageControl];
        _pageControl = pageControl;
    }
    return _pageControl;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUIOnce];
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setupUIOnce];
}

- (void)layoutSubviews{
    [super layoutSubviews];
}








@end
