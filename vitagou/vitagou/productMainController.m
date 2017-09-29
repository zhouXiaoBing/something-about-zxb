//
//  productMainController.m
//  vitagou
//
//  Created by Mac on 2017/7/26.
//  Copyright © 2017年 Vitagou. All rights reserved.
//需要通过通知来适配数据，进入相应的子controller

/*
 存在加入购物车的按钮，不能够准确定位的问题，，先做其他不用思考就可以搞定的部分 08-4-10：30
 */


#import "productMainController.h"
#import "productDetailController.h"//详情的webView
#import "ProductController.h"//商品规格
#import "ProductMainCell.h"
#import "productTitleView.h"
#import "UICollectionViewController+CurrentPage.h"
#import "UIBarButtonItem+product.h"
#import "UIImage+Image.h"
#import "productToolBar.h"
#import "TabHomeController.h"
#import "CommentController.h"


@interface productMainController ()<UIScrollViewDelegate,productTitleViewDelegate>


// 流水布局 ，用来切换商品规格的页面还有详情的页面  水平方向的
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

//子视图的控制器
@property(nonatomic, strong) productDetailContaroller *productDetailVC;
//
@property(nonatomic, strong) ProductController *productVC;

@property(nonatomic, strong) CommentController *cc;
//
@property(nonatomic, strong) productToolBar *toolBar;
// 当前所滚动到的页码
@property (nonatomic, assign) NSUInteger pageNumber;

@property(nonatomic, strong) UITabBarController *tabBar;

//----------第二个版本------------参数
@property (strong, nonatomic) UIScrollView *scrollerView;

@property (strong, nonatomic) UIView *bgView;

@property (nonatomic , weak) UIButton *selectBtn;

/* 标题按钮地下的指示器 */
@property (weak ,nonatomic) UIView *indicatorView;

/* 通知 */
@property (weak ,nonatomic) id dcObserve;

@end

@implementation productMainController



//get goods_id
-(instancetype)initWithProductId:(NSString *)product_id{
    
    self.hidesBottomBarWhenPushed = YES;//隐藏底部导航栏
    NSLog(@"productId %@",product_id);
    
    _goods_id = product_id;
    
    return self;
}

-(UIScrollView *)scrollerView{
    
    if (!_scrollerView) {
        _scrollerView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _scrollerView.frame = self.view.bounds;
        _scrollerView.showsVerticalScrollIndicator = NO;
        _scrollerView.showsHorizontalScrollIndicator = NO;
        _scrollerView.pagingEnabled = YES;
        _scrollerView.delegate = self;
        [self.view addSubview:_scrollerView];
    }
    return _scrollerView;
}


-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self setUpInit];
    
    [self setupChildViewControllers];
    
//    [self setNavBar];
    
    [self addChildViewController];
    
    [self setBottomButtom];
    
    [self setUpTopButtonView];
    
    [self adNotification];
    
    
}

- (void)setUpInit
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.scrollerView.backgroundColor = self.view.backgroundColor;
    self.scrollerView.contentSize = CGSizeMake(self.view.width * self.childViewControllers.count, 0);//子Controllers的数量乘以屏幕宽度
//    self.scrollerView.contentSize = CGSizeMake(Width, 0);
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

-(void)adNotification{
    
    
}

-(void)setUpTopButtonView{
    
//    NSArray *titles = @[@"商品"];
    NSArray *titles = @[@"商品",@"评价"];
    CGFloat margin = 5;
    _bgView = [[UIView alloc] init];
    _bgView.centerX = Width * 0.5;
    _bgView.height = 44;//???????
    _bgView.width = (_bgView.height + margin) * titles.count;
    _bgView.y = 0;
    self.navigationItem.titleView = _bgView;
    
    CGFloat buttonW = _bgView.height;
    CGFloat buttonH = _bgView.height;
    CGFloat buttonY = _bgView.y;
    for (NSInteger i = 0; i < titles.count; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:titles[i] forState:0];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.tag = i;
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button addTarget:self action:@selector(topBottonClick:) forControlEvents:UIControlEventTouchUpInside];
        CGFloat buttonX = i * (buttonW + margin);
        
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        [_bgView addSubview:button];
        
    }
    
    UIButton *firstButton = _bgView.subviews[0];
    [self topBottonClick:firstButton]; //默认选择第一个
    
    UIView *indicatorView = [[UIView alloc]init];
    self.indicatorView = indicatorView;
    indicatorView.backgroundColor = [firstButton titleColorForState:UIControlStateSelected];
    
    indicatorView.height = 2;
    indicatorView.y = _bgView.height - indicatorView.height;
    
    [firstButton.titleLabel sizeToFit];
    indicatorView.width = firstButton.titleLabel.width;
    indicatorView.centerX = firstButton.centerX;
    
    [_bgView addSubview:indicatorView];
    
    UIBarButtonItem *moreButtonItem
    = [UIBarButtonItem barButtonItemWithBackgroundImage:[UIImage stretchableImageNamed:@"goCart"]
                                       highlightedImage:nil
                                                 target:self
                                                 action:@selector(goCart_)
                                       forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *footprintButtonItem
    = [UIBarButtonItem barButtonItemWithBackgroundImage:[UIImage stretchableImageNamed:@"share"]
                                       highlightedImage:nil
                                                 target:self
                                                 action:@selector(share_)
                                       forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItems = @[moreButtonItem, footprintButtonItem];
}

- (void)topBottonClick:(UIButton *)button
{
    button.selected = !button.selected;
    [_selectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    _selectBtn = button;
    
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        weakSelf.indicatorView.width = button.titleLabel.width;
        weakSelf.indicatorView.centerX = button.centerX;
    }];
    NSLog(@"button.tag %ld",(long)button.tag);
    CGPoint offset = _scrollerView.contentOffset;
    offset.x = _scrollerView.width * button.tag;
    [_scrollerView setContentOffset:offset animated:YES];
    if (button.tag == 1) {
//  _cc = [[CommentController alloc]initWithProductId:_goods_id];
//        [self.navigationController pushViewController:cc animated:YES];
    }
}


-(void)addChildViewController
{
    NSInteger index = _scrollerView.contentOffset.x / _scrollerView.width;
    UIViewController *childVc = self.childViewControllers[index];
    
    if (childVc.view.superview) return; //判断添加就不用再添加了
    childVc.view.frame = CGRectMake(index * _scrollerView.width, 0, _scrollerView.width, _scrollerView.height);
    NSLog(@"_scrollerView.height %f",_scrollerView.height);
    [_scrollerView addSubview:childVc.view];
    
}

-(void)setupChildViewControllers{
    
    __weak typeof(self)weakSelf = self;
    productDetailContaroller *provc = [[productDetailContaroller alloc]initWithProductId:_goods_id];
    provc.changeTitleBlock = ^(BOOL isChange){
        if (isChange) {
            weakSelf.title = @"图文详情";
            weakSelf.navigationItem.titleView = nil;
            self.scrollerView.contentSize = CGSizeMake(self.view.width, 0);
        }else{
            weakSelf.title = nil;
            weakSelf.navigationItem.titleView = weakSelf.bgView;
            self.scrollerView.contentSize = CGSizeMake(self.view.width * self.childViewControllers.count, 0);
        }
    };
    [self addChildViewController:provc];
    
    CommentController *cc = [[CommentController alloc]initWithProductId:_goods_id];
    
    [self addChildViewController:cc];
    
}


-(void)setBottomButtom{
    NSLog(@"setBottomButtom");
    [self setUpLeftTwoButton];//收藏 购物车
    
    [self setUpRightTwoButton];//加入购物车 立即购买
}


- (void)setUpLeftTwoButton
{
    NSArray *imagesNor = @[@"favorite_no",@"counsel"];
    NSArray *imagesSel = @[@"favorite_yes",@"counsel"];
    CGFloat buttonW = Width * 0.2;
    CGFloat buttonH = 50;
    CGFloat buttonY = Height - buttonH -64;
    
    for (NSInteger i = 0; i < imagesNor.count; i++) {
        NSLog(@"for (NSInteger i = 0; i < imagesNor.count; i++) {");
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:imagesNor[i]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:imagesSel[i]] forState:UIControlStateSelected];
        button.tag = i;
        [button addTarget:self action:@selector(bottomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        CGFloat buttonX = (buttonW * i);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        [self.view addSubview:button];
    }
}

- (void)setUpRightTwoButton
{
    NSArray *titles = @[@"加入购物车",@"立即购买"];
    CGFloat buttonW = Width * 0.6 * 0.5;
    CGFloat buttonH = 50;
    CGFloat buttonY = Height - buttonH-64;
//    CGFloat buttonY = 200;
    for (NSInteger i = 0; i < titles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.tag = i + 2;
        [button setTitle:titles[i] forState:UIControlStateNormal];
        button.backgroundColor = (i == 0) ? [UIColor redColor] : RGB(249, 125, 10);
        [button addTarget:self action:@selector(bottomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        CGFloat buttonX = Width * 0.4 + (buttonW * i);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        [self.view addSubview:button];
    }
}

- (void)bottomButtonClick:(UIButton *)button
{
    if (button.tag == 0) {
        NSLog(@"收藏");
        button.selected = !button.selected;
    }else if(button.tag == 1){
        NSLog(@"购物车");
//        DCMyTrolleyViewController *shopCarVc = [[DCMyTrolleyViewController alloc] init];
//        shopCarVc.isTabBar = YES;
//        shopCarVc.title = @"购物车";
//        [self.navigationController pushViewController:shopCarVc animated:YES];
        
    }else  if (button.tag == 2 || button.tag == 3) { //父控制器的加入购物车和立即购买
        //异步发通知
        dispatch_sync(dispatch_get_global_queue(0, 0), ^{
            NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%zd",button.tag],@"buttonTag", nil];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"ClikAddOrBuy" object:nil    userInfo:dict];
        });
    }
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self addChildViewController];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    UIButton *button = _bgView.subviews[index];
    
    [self topBottonClick:button];
    
    [self addChildViewController];
}


-(void)goCart_{
    
}

-(void)share_{
    
}






/**
 
static NSString * const reuseIdentifier = @"Cell";// 用于替换的简单布局
static NSString * const collectionFoot = @"collectionFoot";

//get goods_id
-(instancetype)initWithProductId:(NSString *)product_id{

    self.hidesBottomBarWhenPushed = YES;//隐藏底部导航栏
    
    _goods_id = product_id;
    
    self = [self initWithCollectionViewLayout:self.flowLayout];
    
    return self;
}

- (productDetailContaroller *)productDetailVC{
    NSLog(@"productDetailVC");
    if (_productDetailVC == nil) {
        _productDetailVC = [[productDetailContaroller alloc]initWithProductId:_goods_id];
    }
    return _productDetailVC;
}

- (ProductController *)productVC{
    NSLog(@"productVC");
    if (_productVC == nil) {
        _productVC = [[ProductController alloc]initWithProductId:_goods_id];
    }
    return _productVC;
}

- (UICollectionViewFlowLayout *)flowLayout {//手势滑动的操作  商品信息显示的位置  用来切换详情还有商品的规格的介绍
    
    if (_flowLayout == nil) {
//        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
       _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        // 设置cell的尺寸
        CGFloat Y = 64;//CGRectGetMaxY(self.navigationController.navigationBar.frame);
        _flowLayout.itemSize = CGSizeMake(Width,
                                         Height- Y -50);//这个50是购买按钮的高度
        // 清空行距
        _flowLayout.minimumLineSpacing = 0;
        // 设置滚动方向:水平
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//        _flowLayout = flowLayout;
    }
    
    return _flowLayout;
}

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
//    self.clearsSelectionOnViewWillAppear = NO;

    self.view.backgroundColor = [UIColor grayColor];
    
    self.collectionView.frameHeight -= 50;
    
    [self productVC];
    
    [self productDetailVC];
    
    [self buildCollectionView];
    
    [self setNavigationBar];
    
    [self setToolbar];
    
    [self addNotification];
    
}

-(void)buildCollectionView{
 
//    [self.view addSubview:self.collectionView];
//    [self.collectionView addSubview:self.flowLayout];
//    [self initWithCollectionViewLayout:self.flowLayout];
    //注册cell 替换布局
    [ self.collectionView registerClass:[ProductMainCell class] forCellWithReuseIdentifier:reuseIdentifier];
//    [self.collectionView registerClass:[productToolBar class] forCellWithReuseIdentifier:collectionFoot];
    
//    [self.collectionView registerClass:[productToolBar class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:collectionFoot];
    
    // 以下的属性都是继承自UIScrollView
     self.collectionView.pagingEnabled = YES;                 // 按页翻转
     self.collectionView.bounces = NO;                        // 拉到底无反弹效果
     self.collectionView.showsHorizontalScrollIndicator = NO; //不显示滚动条
}


-(void)addNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setProductInfo:) name:ProductInfoDidRecievedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeSelectionCount:) name:SelectedProductCountDidChangeNotification object:nil];
}

-(void)setProductInfo:(NSNotification *)notification{
    
}

-(void)changeSelectionCount:(NSNotification *)notifacation{
    
}

-(void)setToolbar{
    
   _toolBar = [[productToolBar alloc]initWithFrame:CGRectMake(25, -50, Width, 48)];
//    _toolBar = [[productToolBar alloc]init];
    
//    [_toolBar setY:300];
//    _toolBar = toolBar;
//    [_toolBar set]
//    _tabBar = [[UITabBarController alloc]init];
//    _tabBar.b
//    _toolBar = self.tabBarItem;
    [super.self.view addSubview:_toolBar];
    
//    [self.view addSubview:_toolBar];
    
    
//    [self.view addSubview:self.collectionView];
//    [_toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.view.mas_bottom);
//    }];
//    [_toolBar setY:518];
//    [_flowLayout set]
//    [_toolBar setX:160];
}

-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"(void)viewWillAppear:(BOOL)animated");
    [super viewWillAppear:animated];
//    _toolBar.y = self.view.height-50;
//    _toolBar.bottom=self.view.bottom;
}


-(void)setNavigationBar{
    NSLog(@"setNavigationBar");
    productTitleView *titleView = [[productTitleView alloc]init];
    titleView.delegate = self;
    self.navigationItem.titleView = titleView;//标题切换
    
    
     // 3. 左侧返回
//     self.navigationItem.leftBarButtonItem
//     = [UIBarButtonItem barButtonItemWithBackgroundImage:[UIImage imageNamed:@"back_bt"]
//     highlightedImage:nil
//     target:self
//     action:@selector(back)
//     forControlEvents:UIControlEventTouchUpInside];
    
     // 5. 右侧按钮 两个
     UIBarButtonItem *moreButtonItem
     = [UIBarButtonItem barButtonItemWithBackgroundImage:[UIImage stretchableImageNamed:@"goCart"]
     highlightedImage:nil
     target:self
     action:@selector(goCart)
     forControlEvents:UIControlEventTouchUpInside];
     UIBarButtonItem *footprintButtonItem
     = [UIBarButtonItem barButtonItemWithBackgroundImage:[UIImage stretchableImageNamed:@"share"]
     highlightedImage:nil
     target:self
     action:@selector(share)
     forControlEvents:UIControlEventTouchUpInside];
     self.navigationItem.rightBarButtonItems = @[moreButtonItem, footprintButtonItem];
}




-(void)goCart{
    
}

-(void)share{
    
}

// 有几组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

// 每组有几个
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"cellForItemAtIndexPath");
    ProductMainCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        NSLog(@"(indexPath.row == 0) ");
        _productVC.view.frame = cell.bounds;
        cell.contentSubview = _productVC.view;
        
    } else if (indexPath.row == 1) {
        NSLog(@"(indexPath.row == 1) ");
        _productDetailVC.view.frame = cell.bounds;
        cell.contentSubview = _productDetailVC.view;
    }
    
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
     NSLog(@"scrollViewDidScroll");
    CGFloat offset = scrollView.contentOffset.x;
    
    NSUInteger currentPageNuber = [self setCurrentPageNumberWithLastPageNumber:_pageNumber totalCount:2 offset:offset];
    
    //发出通知
    if (_pageNumber != currentPageNuber) {
        NSString *num = [NSString stringWithFormat:@"%li",currentPageNuber];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:CurrentPageDidChangeNotification object:num];
        
        _pageNumber = currentPageNuber;
    }

}


-(void)titleView:(productTitleView *)titleView didClickButtonAtIndex:(NSUInteger)index{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
//    NSLog(@"referenceSizeForFooterInsection");//foot没有更多商品的显示
//    if (section == 4) {
//        return CGSizeMake(Width,50);
//    }
//    return CGSizeZero;
//}

//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//    
//    if([kind isEqualToString:UICollectionElementKindSectionFooter]){
//        productToolBar *cell = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:collectionFoot forIndexPath:indexPath];
//        
//        
//            [cell setHidden:NO];
//       
//        
//        return cell;
//    }
//    
//    return nil;
//}

 
*/
@end
