 //
//  productDetailController.m
//  vitagou
//
//  Created by Mac on 2017/7/26.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import "productDetailController.h"
#import <WebKit/WebKit.h>
#import "ProductHeadView.h"
#import "DCLIRLButton.h"
#import "DCDetailShufflingHeadView.h"
#import "DCDetailGoodReferralCell.h"
#import "productDes.h"
#import "DCDetailPartCommentCell.h"
#import "DCDetailOverFooterView.h"

@interface productDetailContaroller ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,WKNavigationDelegate>

@property (strong, nonatomic) UIScrollView *scrollerView;

@property (strong, nonatomic) UICollectionView *collectionView;

@property (strong, nonatomic) WKWebView *webView;

/* 选择地址弹框 */
//@property (strong , nonatomic)AddressPickerView *adPickerView;
/* 已选组Cell */
//@property (weak ,nonatomic)DCShowTypeOneCell *cell;
/* 滚回顶部按钮 */
@property (strong , nonatomic)UIButton *backTopButton;
/* 通知 */
@property (weak ,nonatomic) id dcObj;

@property(nonatomic,strong) product *product;

@property(nonatomic, strong) zxb_product_data *proData;

@property(nonatomic, strong) zxb_Result *result;
@end

//header
static NSString *DCDetailShufflingHeadViewID = @"DCDetailShufflingHeadView";
static NSString *DCDeatilCustomHeadViewID = @"DCDeatilCustomHeadView";
static NSString *DCDetailGoodReferralCellID = @"DCDetailGoodReferralCell";
static NSString *productHeadViewId = @"productHeadViewId";
static NSString *productDetailId = @"productDetailId";
static NSString *DCDetailPartCommentCellId = @"DCDetailPartCommentCellId";
static NSString *DCDetailOverFooterViewID = @"DCDetailOverFooterView";


static NSInteger lastNum_;
static NSMutableArray *lastSeleArray_;

@implementation productDetailContaroller

-(instancetype)initWithProductId:(NSString *)ProductId{
    self = [super init];
    if (self) {
        _productId = ProductId;
    }

    return self;
}

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self getData];
    
    [self setUpInit];
    
    [self setUpViewScroller];
    
    [self setUpGoodsWKWebView];
    
    [self setUpSuspendView];
    
//    [self acceptanceNote];
    
}

-(void)getData{

    
    [product getProductDetail:(NSString *) _productId
     
                      success:^(zxb_Result *result, zxb_product_data *data) {
                          NSLog(@"详情相关数据 %@",data.name);
                           NSLog(@"详情相关数据.count %lu",data.photo.count);
                          
                          self.proData = data;
                          self.result = result;
                          
                          //完整图片URL 商品轮播
                          lastSeleArray_ = [NSMutableArray array];
                              [data.photo enumerateObjectsUsingBlock:^(zxb_product_data *obj,NSUInteger idx, BOOL * _Nonnull stop)
                               {
                                   [lastSeleArray_ addObject:[VITAGOUURL stringByAppendingString:obj.img]];
                               }];
                          if (data.comment.data.count > 0) {
                              _commentData = [data.comment.data objectAtIndex:0];
                          }
                          
                          
                          NSLog(@"_comentData>>>>  %@" , _commentData.username);
        
                          _collectionView.delegate = self;
                          _collectionView.dataSource = self;
                      }
     
                      failure:^(NSError *error) {
                          NSLog(@"getHomeData is on failure");
                      }];
}


- (UIScrollView *)scrollerView
{
    if (!_scrollerView) {
        _scrollerView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _scrollerView.frame = self.view.bounds;
        _scrollerView.contentSize = CGSizeMake(Width, (Height - 50) * 2);
        _scrollerView.pagingEnabled = YES;
        _scrollerView.scrollEnabled = NO;
        [self.view addSubview:_scrollerView];
    }
    return _scrollerView;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.minimumLineSpacing = 0; //Y
        layout.minimumInteritemSpacing = 0; //X
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.frame = CGRectMake(0, 0, Width, Height - 50 -64);
        _collectionView.showsVerticalScrollIndicator = NO;
        [self.scrollerView addSubview:_collectionView];
    }
    
    [_collectionView registerClass:[DCDetailShufflingHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCDetailShufflingHeadViewID];
    
    [_collectionView registerClass:[DCDetailGoodReferralCell class] forCellWithReuseIdentifier:DCDetailGoodReferralCellID];
    
    [_collectionView registerClass:[productDes class] forCellWithReuseIdentifier:productDetailId];
        [_collectionView registerClass:[DCDetailPartCommentCell class] forCellWithReuseIdentifier:DCDetailPartCommentCellId];
    
     [_collectionView registerClass:[DCDetailOverFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DCDetailOverFooterViewID];
    
     [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionElementKindSectionFooter"]; //间隔
    
    return _collectionView;
}

- (WKWebView *)webView
{
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectZero];
        _webView.frame = CGRectMake(0,Height-64 , Width, Height - 50);
        _webView.scrollView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
        _webView.scrollView.scrollIndicatorInsets = _webView.scrollView.contentInset;
        [self.scrollerView addSubview:_webView];
    }
    return _webView;
}

- (void)setUpInit
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor colorWithRed:245 green:245 blue:245 alpha:0];
    self.collectionView.backgroundColor = self.view.backgroundColor;
    self.scrollerView.backgroundColor = self.view.backgroundColor;
    
    //初始化
//    lastSeleArray_ = [NSMutableArray array];
    lastNum_ = 0;
}

- (void)setUpSuspendView
{
    _backTopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_backTopButton];
    [_backTopButton addTarget:self action:@selector(ScrollToTop) forControlEvents:UIControlEventTouchUpInside];
    [_backTopButton setImage:[UIImage imageNamed:@"btn_UpToTop"] forState:UIControlStateNormal];
    _backTopButton.hidden = YES;
    _backTopButton.frame = CGRectMake(Width - 50, Height - 100, 40, 40);
}


- (void)ScrollToTop
{
    if (self.scrollerView.contentOffset.y > Height) {
        [self.collectionView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
    }else{
        __weak typeof(self)weakSelf = self;
        [UIView animateWithDuration:0.5 animations:^{
            weakSelf.scrollerView.contentOffset = CGPointMake(0, 0);
        } completion:^(BOOL finished) {
            [weakSelf.collectionView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
        }];
    }
    !_changeTitleBlock ? : _changeTitleBlock(NO);
}

- (void)setUpGoodsWKWebView
{
    NSString *str = @"http://www.vitagou.hk/site/products1/id/";
    NSString *URLString = [str stringByAppendingString:_productId];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URLString]];
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://weibo.com/u/5605532343"]];
    [self.webView loadRequest:request];
    
    //下拉返回商品详情View
    UIView *topHitView = [[UIView alloc] init];
    topHitView.frame = CGRectMake(0, -35, Width, 35);
    DCLIRLButton *topHitButton = [DCLIRLButton buttonWithType:UIButtonTypeCustom];
    topHitButton.imageView.transform = CGAffineTransformRotate(topHitButton.imageView.transform, M_PI); //旋转
    [topHitButton setImage:[UIImage imageNamed:@"Details_Btn_Up"] forState:UIControlStateNormal];
    [topHitButton setTitle:@"下拉返回商品详情" forState:UIControlStateNormal];
    topHitButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [topHitButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [topHitView addSubview:topHitButton];
    topHitButton.frame = topHitView.bounds;
    
    [self.webView.scrollView addSubview:topHitView];
}

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else if (section == 1){
        //有评论返回2 无评论返回1
        return 1;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
     UICollectionViewCell *gridcell = nil;
    if (indexPath.section == 0) {
        productDes *cell = [collectionView dequeueReusableCellWithReuseIdentifier:productDetailId forIndexPath:indexPath];
        cell.proData = _proData;
        gridcell = cell;
    }else if (indexPath.section == 1){//内容的item分为两个cell，有图返回两个cell，无图返回一个
        
        DCDetailPartCommentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCDetailPartCommentCellId forIndexPath:indexPath];
        cell.CommentData = _commentData;
        gridcell = cell;
    }
    
    return gridcell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableview = nil;
    NSLog(@"viewForSupplementaryElementOfKind");
    if (kind == UICollectionElementKindSectionHeader){
        if (indexPath.section == 0) {
            DCDetailShufflingHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCDetailShufflingHeadViewID forIndexPath:indexPath];
            headerView.shufflingArray = lastSeleArray_;//注意url连接
            NSLog(@"headerView.shufflingArray = _proData.photo %lu",(unsigned long)_proData.photo.count);
            reusableview = headerView;
        }
    }else if (kind == UICollectionElementKindSectionFooter){
            if (indexPath.section == 1) {
                DCDetailOverFooterView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DCDetailOverFooterViewID forIndexPath:indexPath];
                reusableview = footerView;
            }else{
                UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionElementKindSectionFooter" forIndexPath:indexPath];
                footerView.backgroundColor = [UIColor lightGrayColor];
                reusableview = footerView;
            }
        }

return reusableview;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return CGSizeMake(Width, Width*0.55);
    }
    else if (indexPath.section == 1){
        if (_commentData == nil) {
            return CGSizeZero;
        }else if (_commentData.images.count == 0) {
            return CGSizeMake(Width, Width-100);//评论无图
        }else{
            
        return CGSizeMake(Width, Width);
            
        }
        
    }
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return CGSizeMake(Width, Height*0.55);
    }else if (section == 1){
        return CGSizeZero;
    }
    
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
//    return (section == 1) ? CGSizeMake(Width, 35) : CGSizeMake(Width, 10);
    if (section == 0) {
//        return CGSizeZero;
        return CGSizeMake(Width, 10);
    }else if (section == 1){
        return CGSizeMake(Width, 35);
    }
    
    return CGSizeZero;
}

- (void)setUpViewScroller{
    __weak typeof(self)weakSelf = self;
    self.collectionView.mj_footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            !weakSelf.changeTitleBlock ? : weakSelf.changeTitleBlock(YES);
            weakSelf.scrollerView.contentOffset = CGPointMake(0, Height);
        } completion:^(BOOL finished) {
            [weakSelf.collectionView.mj_footer endRefreshing];
        }];
    }];
    
    self.webView.scrollView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        [UIView animateWithDuration:0.8 animations:^{
            !weakSelf.changeTitleBlock ? : weakSelf.changeTitleBlock(NO);
            weakSelf.scrollerView.contentOffset = CGPointMake(0, 0);
        } completion:^(BOOL finished) {
            [weakSelf.webView.scrollView.mj_header endRefreshing];
        }];
        
    }];
}

    
    
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //判断回到顶部按钮是否隐藏
    _backTopButton.hidden = (scrollView.contentOffset.y > Height) ? NO : YES;
}


- (void)scrollToDetailsPage
{
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        [[NSNotificationCenter defaultCenter]postNotificationName:@"scrollToDetailsPage" object:nil];
    });
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:_dcObj];
}


//
//-(void)viewDidLoad{
//    
//    [super viewDidLoad];
//    
//    self.view.backgroundColor = [UIColor whiteColor];
//    
//    NSLog(@"进入productDetailController");
//    // 1. 创建webView, 展示详情页面
//    UIWebView *detailWebView = [[UIWebView alloc] initWithFrame:self.view.bounds];
//    
//    // 根据屏幕大小自动调整页面尺寸
//    detailWebView.scalesPageToFit = YES;
//    
//    [self.view addSubview:detailWebView];
//    
//    // 2. 设置请求URL
//    NSString *str = @"http://www.vitagou.hk/site/products1/id/";
//    
//   NSString *URLString = [str stringByAppendingString:_productId];
//    
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URLString]];
//    
//    // 加载页面
//    [detailWebView loadRequest:request];
//}

@end
