//
//  OneRootVC.m
//  collectionIos
//
//  Created by Mac on 2017/12/28.
//  Copyright © 2017年 Vitagou. All rights reserved.
//网易效果的Segment切换
//索引显示的tableview

#import "OneRootVC.h"
#import "HMSegmentedControl.h"
#import "AddressBookIndexController.h"//侧边显示通讯录



@interface OneRootVC() <UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UIView *testView;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) HMSegmentedControl *segmentedControl;

@property (nonatomic, strong) NSArray * IndexDataSource;
@end

@implementation OneRootVC

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.title = @"索引";
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //后期可以从jsondata里面获取
    _IndexDataSource = @[@"字母索引形式的通讯录",@"图片上传",@"待定2",@"待定3",@"待定4"];

    
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
    
//    显示各种项目的入口目录
//    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, viewWidth, 310)];
//    [self setApperanceForLabel:label1];
//    label1.text = @"label1";
//    [self.scrollView addSubview:label1];
    
    [self initIndexTable];
    
    
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

//索引-start-----------------------------------------
-(void)initIndexTable{
    
     UITableView *tableView = [[UITableView alloc]initWithFrame:self.scrollView.bounds style:UITableViewStylePlain];//UITableViewStyleGrouped 会在上面有个空白显示分组
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.scrollView addSubview:tableView];
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _IndexDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = _IndexDataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.row == 0)
    {
//        [self alertMessage:@"字母索引形式的通讯录"];
        AddressBookIndexController *controller = [[AddressBookIndexController alloc]init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if(indexPath.row == 1)
    {
        [self alertMessage:@"图片上传"];
    }
    else if(indexPath.row == 2)
    {
        [self alertMessage:@"待定2"];
    }
    else if(indexPath.row == 3)
    {
        [self alertMessage:@"待定3"];
    }
    else if(indexPath.row == 4)
    {
        [self alertMessage:@"待定4"];
    }
//    [self.navigationController pushViewController:VC animated:YES];
}
//索引-end-------------------------------------------

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

//切换页
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger page = scrollView.contentOffset.x / pageWidth;
    
    [self.segmentedControl setSelectedSegmentIndex:page animated:YES];
}

-(void)alertMessage:(NSString *)str{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.mode = MBProgressHUDModeText;//文字模式
    //        hud.label.text = NSLocalizedString(@"Message here!", nil);//NSLocalizedString: 本地化 键值对 第一个是当前语言环境的默认值 第二个参数是对这个“键值对”的注释
    hud.label.text =str;
    // Move to bottm center.
    //        hud.offset = CGPointMake(kScreen_Width/2, 200);//调整坐标
    [hud hideAnimated:YES afterDelay:1.f];
}

@end
