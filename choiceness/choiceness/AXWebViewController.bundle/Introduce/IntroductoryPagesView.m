//
//  IntroductoryPagesView.m
//  lvdouyi
//
//  Created by Mac on 2018/9/7.
//  Copyright © 2018年 vitagou. All rights reserved.
//

#import "IntroductoryPagesView.h"


@interface IntroductoryPagesView() <UIScrollViewDelegate>

@property (nonatomic, strong) NSArray<NSString *> *imagesArray;

@property (nonatomic,strong) UIPageControl *pageControl;

@property (nonatomic, strong) UIButton *countBtn;

@property (nonatomic, strong) dispatch_source_t gcdTimer;

/** <#digest#> */
@property (weak, nonatomic) UIScrollView *scrollView;

@end

@implementation IntroductoryPagesView

+ (instancetype)pagesViewWithFrame:(CGRect)frame images:(NSArray<NSString *> *)images{
    IntroductoryPagesView *pagesView = [[self alloc]initWithFrame:frame];
    
    pagesView.imagesArray = images;
    
    return  pagesView;
}

- (void)setupUIOnce{
    self.backgroundColor = [UIColor clearColor];
    
    //添加手势
    UITapGestureRecognizer *singleRecognizer;
    singleRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleSingleTapFrom)];
    singleRecognizer.numberOfTapsRequired = 1;
    [self.scrollView addGestureRecognizer:singleRecognizer];
}
- (void)setImagesArray:(NSArray<NSString *> *)imagesArray {
    _imagesArray = imagesArray;
    [self loadPageView];
}

- (void)loadPageView
{
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.scrollView.contentSize = CGSizeMake((self.imagesArray.count + 1) * ScreenWidth, ScreenHeight);
    self.pageControl.numberOfPages = self.imagesArray.count;
    
    [self.imagesArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        YYAnimatedImageView *imageView = [[YYAnimatedImageView alloc]init];
        
        imageView.frame = CGRectMake(idx * ScreenWidth, 0, ScreenWidth, ScreenHeight);
        
        YYImage *image = [YYImage imageNamed:obj];
        
        [imageView setImage:image];
        
        [self.scrollView addSubview:imageView];
    }];
}

-(void)handleSingleTapFrom
{
    if (_pageControl.currentPage == self.imagesArray.count-1) {
        [self removeFromSuperview];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint offSet = scrollView.contentOffset;
    NSInteger page = (offSet.x / (self.bounds.size.width) + 0.5);
    self.pageControl.currentPage = page;//计算当前的页码
    self.pageControl.hidden = (page > self.imagesArray.count - 1);
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x >= (_imagesArray.count) * ScreenWidth) {
        [self removeFromSuperview];
    }
}

- (UIScrollView *)scrollView
{
    if(!_scrollView)
    {
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        [self addSubview:scrollView];
        scrollView.backgroundColor = [UIColor clearColor];
        scrollView.pagingEnabled = YES;//设置分页
        scrollView.bounces = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.delegate = self;
        _scrollView = scrollView;
    }
    return _scrollView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupUIOnce];
        CGFloat btnW = 60;
        CGFloat btnH = 30;
        _countBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - btnW - 24, [UIApplication sharedApplication].statusBarFrame.size.height + btnH, btnW, btnH)];
        [_countBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [_countBtn setTitle:@"进入" forState:UIControlStateNormal];
        _countBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_countBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _countBtn.backgroundColor = [UIColor colorWithRed:38 /255.0 green:38 /255.0 blue:38 /255.0 alpha:0.6];
        _countBtn.layer.cornerRadius = 4;
        [self addSubview:_countBtn];
        
        UIPageControl *pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(ScreenWidth/2, ScreenHeight - 60, 0, 40)];
        pageControl.backgroundColor = [UIColor clearColor];
        pageControl.pageIndicatorTintColor = [UIColor grayColor];
        pageControl.currentPageIndicatorTintColor = [UIColor greenColor];
        _pageControl = pageControl;
        [self addSubview:_pageControl];
        
    }
    return self;
}
- (void)dismiss
{
    if (_gcdTimer) {
        dispatch_cancel(_gcdTimer);
    }
    _gcdTimer = nil;
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.3f animations:^{
            self.alpha = 0.f;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
        
    });
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupUIOnce];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}
@end