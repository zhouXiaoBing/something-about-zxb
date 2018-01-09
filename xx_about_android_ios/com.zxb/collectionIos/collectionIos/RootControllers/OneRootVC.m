//
//  OneRootVC.m
//  collectionIos
//
//  Created by Mac on 2017/12/28.
//  Copyright © 2017年 Vitagou. All rights reserved.
//网易效果的Segment切换

#import "OneRootVC.h"
#import "HMSegmentedControl.h"

@interface OneRootVC() <UIScrollViewDelegate>

@property(nonatomic,strong) UIView *testView;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) HMSegmentedControl *segmentedControl;

@end

@implementation OneRootVC

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.title = @"索引";
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
//    _testView = [[UIView alloc]initWithFrame:self.view.bounds];
//    _testView.backgroundColor = [UIColor greenColor];
    
    [self SegmentToScrollView];

}

-(void)SegmentToScrollView{
//    这里的 Segment 和 scrollView 是两个分开初始化的部分
//    根据滑动 scrollView 的位置的判断来更改 Segment 的对应的位置的选项
//    今日头条是可以动态添加的效果 这里没有实现 是写死的数据
    CGFloat viewWidth = CGRectGetWidth(self.view.frame);
    // Tying up the segmented control to a scroll view
    self.segmentedControl = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(0, 0, viewWidth, 30)];//指定 Segment 的frame 初始化
    self.segmentedControl.sectionTitles = @[@"第一页", @"第二页", @"第三页", @"第四页", @"第五页"];
//    self.segmentedControl.segmentWidthStyle = HMSegmentedControlSegmentWidthStyleDynamic;
//    self.segmentedControl.segmentWidth = 100.0f;
    self.segmentedControl.selectedSegmentIndex = 0;//首次显示的页面的index
    self.segmentedControl.backgroundColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1];
    //选中和未选中的时候 Segment 的 属性设置 如字体颜色 背景变化啥的
    self.segmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    self.segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1]};
    self.segmentedControl.selectionIndicatorColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1];
    self.segmentedControl.selectionStyle = HMSegmentedControlNoSegment;
    self.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationNone;//指示的横条出现在 Segment 上面
    
    
    __weak typeof(self) weakSelf = self;
    //在第三方的头文件里面有声明未实现的方法 暂未弄清作用
    [self.segmentedControl setIndexChangeBlock:^(NSInteger index) {
        [weakSelf.scrollView scrollRectToVisible:CGRectMake(viewWidth * index, 0, viewWidth, 200) animated:YES];
    }];
    
    [self.view addSubview:self.segmentedControl];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 30, viewWidth, kScreen_Height)];//高度未详细的计算
    self.scrollView.backgroundColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1];// scrollView 的背景色
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;//不显示侧边的导航条
    self.scrollView.contentSize = CGSizeMake(viewWidth * 5, kScreen_Height);// scrollView 中内容的高度
    self.scrollView.delegate = self;
    [self.scrollView scrollRectToVisible:CGRectMake(0, 0, viewWidth, 200) animated:NO];//决定了 scrollVIew 首次显示的是哪一个 对应的label
    [self.view addSubview:self.scrollView];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, viewWidth, 310)];
    [self setApperanceForLabel:label1];
    label1.text = @"label1";
    [self.scrollView addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(viewWidth, 0, viewWidth, 110)];
    [self setApperanceForLabel:label2];
    label2.text = @"label2";
    [self.scrollView addSubview:label2];
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(viewWidth * 2, 0, viewWidth, 210)];
    [self setApperanceForLabel:label3];
    label3.text = @"label3";
    [self.scrollView addSubview:label3];
    
    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(viewWidth * 3, 0, viewWidth, 210)];
    [self setApperanceForLabel:label4];
    label4.text = @"label3";
    [self.scrollView addSubview:label4];
    
    UILabel *label5 = [[UILabel alloc] initWithFrame:CGRectMake(viewWidth * 4, 0, viewWidth, 210)];
    [self setApperanceForLabel:label5];
    label5.text = @"label3";
    [self.scrollView addSubview:label5];

    
}
// 随机生成 label 的颜色
- (void)setApperanceForLabel:(UILabel *)label {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    label.backgroundColor = color;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:21.0f];
    label.textAlignment = NSTextAlignmentCenter;
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger page = scrollView.contentOffset.x / pageWidth;
    
    [self.segmentedControl setSelectedSegmentIndex:page animated:YES];
}


@end
