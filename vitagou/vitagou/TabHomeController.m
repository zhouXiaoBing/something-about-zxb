//
//  TabHomeController.m
//  vitagou
//
//  Created by Mac on 2017/3/29.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

/*
 1.顶部logo、搜索栏、点击按钮
 2.显示内容主体：轮播图、等
 3.底部导航栏不隐藏
 
 HomeHeadView：
 */
#import "TabHomeController.h"
#import "HomeNavBar.h"
#import <CoreLocation/CoreLocation.h>
#import "HttpClient.h"
#import "zxb_home.h"
#import "HomeHeadView.h"
#import "zxb_home_data.h"
#import "zxb_index_slide.h"
#import "AppConst.h"
#import "HomeCategoryCell.h"
#import "recommendgood.h"
#import "HomeHeaderCell.h"
#import "recommendCell.h"
#import "zxb_Result.h"
#import "recommendGoodsArray.h"
#import "brandCell.h"
#import "fitPeopleCell.h"
#import "goodsCell.h"
#import "ProductController.h"
#import "productMainController.h"
#import "firstClassify.h"
#import "PYSearch.h"
#import "productList.h"

@interface TabHomeController () <UICollectionViewDataSource,UICollectionViewDelegate,PYSearchViewControllerDelegate>

{
    NSNumber *_home_data_id;
    UITableView *_maintable;
    NSArray *_index;
 
}
@property (nonatomic, strong) zxb_home *homeData;
@property (nonatomic, strong) zxb_Result *result;

@property (nonatomic, strong) zxb_home_data *home_data;
@property(nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic, strong) HomeHeadView *homeheadView;
@property (nonatomic, strong) UIView *navBar;
@property (nonatomic,strong) NSArray<zxb_promotion *> *promotion;


@end




@implementation TabHomeController
/*
 1.每周特卖 listview显示形式，+ 倒计时
 2.热门品牌 就是一个imageview
 3.适用人群 圆形imageview+Textlabel
 4.新品上市 商品显示Grid 和gridItem
 5.小编推荐 商品显示Grid 和gridItem
 
 cell：共计有5个
    1.倒计时
    2.特卖 recommendCell  item1：每周特卖 item2：倒计时
    3.品牌 一个image 不用写cell
    4.适用人群 groupCell 
    5.新品和推荐 goodCell
 
 支付页面，订单详情 购物车 个人中心里面的订单状态
 项目svn地址：svn://192.168.1.218/sadoc/zxb/vitagou
 
 可以考虑把头标题和倒计时放在headview里面  然后再用 collectioncell
 */

static NSString  *homeCell = @"homeCell";//
static NSString  *recommendCelSub = @"recommendCellSub";//为了添加倒计时 对应recommendCell
static NSString  *recommendCel = @"recommendCell";  //对应recommendgoods
static NSString  *brandCellView = @"brandCell";//可以考虑直接用UIimage来代替
static NSString  *groupCell = @"fitPeopleCell";
static NSString  *goodCell = @"goodsCell";
static NSString  *footerCellId = @"footerCellId";//没有更多商品  我的应用里面没有这个
static NSString  *headerCellId = @"headerCellId";//分类显示的大标题

- (void)viewDidLoad{
    NSLog(@"进入到mainTab");
    [super viewDidLoad];
    //影藏tabbar
//   [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self addNotification];
    [self setNav];
    [self buildCollectionView];
    [self buildTableHeadView];
    [self bulidTableViewRefresh];
}
- (void)addNotification{
    [AJNotification addObserver:self selector:@selector(homeTableHeadViewHeightDidChange:) name:HomeTableHeadViewHeightDidChange object:nil];
    [AJNotification addObserver:self selector:@selector(productGoodsId:) name:ProductGoodsId object:nil];
    [AJNotification addObserver:self selector:@selector(TofirstClassify:) name:MenuViewNotification object:nil];
    [AJNotification addObserver:self selector:@selector(brandCategory:) name:BrandCategoryNotification object:nil];
    [AJNotification addObserver:self selector:@selector(fitPeopleGroup:) name:FitPeopleCellNotifacation object:nil];
}

-(void)fitPeopleGroup:(NSNotification *)notification{
    productList *list = [[productList alloc]initWithCategoryOrBrandOrKeyword_id:notification.object label:@"category_id"];
    [self.navigationController pushViewController:list animated:YES];
}

-(void)brandCategory:(NSNotification *)notification{//
    NSLog(@"brand_id %@",notification.object);
    productList *list = [[productList alloc]initWithCategoryOrBrandOrKeyword_id:notification.object label:@"bid"];
    [self.navigationController pushViewController:list animated:YES];
}
- (void)homeTableHeadViewHeightDidChange:(NSNotification *)notification{
    
    NSLog(@"height = %lf",[notification.object floatValue]);
    CGFloat height = [notification.object floatValue];

    self.collectionView.mj_header.ignoredScrollViewContentInsetTop = height;
    self.homeheadView.frame = CGRectMake(0, -height, Width, height);
    self.collectionView.contentInset = UIEdgeInsetsMake(height, 0, 0, 0);
    self.collectionView.contentOffset = CGPointMake(0, -height);
}

-(void)productGoodsId:(NSNotification *)notification{
    NSLog(@"goods_id %@",notification.object);
    productMainController *product = [[productMainController alloc]initWithProductId:notification.object];
    [self.navigationController pushViewController:product animated:YES];
}
-(void)TofirstClassify:(NSNotification *)notification{
    [self pushTofirstClassify:notification.object];
//    searchViewController * vc = [[searchViewController alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)searchBar{
    // 1. 创建热门搜索
    NSArray *hotSeaches = @[@"蔓越莓", @"减肥", @"胶原蛋白", @"氨糖", @"葡萄籽", @"抗衰老", @"补肾", @"鱼油"];
    // 2. 创建控制器
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:NSLocalizedString(@"商品搜索", @"搜索商品") didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        productList *list = [[productList alloc]initWithCategoryOrBrandOrKeyword_id:searchText label:@"keyword"];
//          [searchViewController dismissViewControllerAnimated:true completion:nil];//关闭搜索页面
        [searchViewController.navigationController pushViewController:list animated:YES];
        
      
//        [searchViewController
    }];
    // 3. 设置风格
    searchViewController.hotSearchStyle = PYHotSearchStyleColorfulTag; // 热门搜索风格为默认
    searchViewController.searchHistoryStyle = PYSearchHistoryStyleDefault; // 搜索历史风
    // 4. 设置代理
    searchViewController.delegate = self;
    // 5. 跳转到搜索控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)dealloc//释放内存
{
    [AJNotification removeObserver:self];
}

-(void)setNav{//_navBar替换titleview
    NSLog(@"导航栏设置");
    
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    
    _navBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 30)];
    _navBar.backgroundColor = [UIColor whiteColor];
    
    UIImageView *image_logo =[ UIImageView new];
    image_logo.image = [UIImage imageNamed:@"home_logo"];
    [_navBar addSubview:image_logo];
    
    [image_logo mas_makeConstraints:^(MASConstraintMaker *make){
//        make.bottom.mas_equalTo(_navBar.mas_bottom);
        make.centerY.mas_equalTo(_navBar.mas_centerY);
        make.left.mas_offset(-5);
        make.height.mas_equalTo(30);
    }];
    
    UIImageView *categray_goto = [UIImageView new ];
    [categray_goto setImage:[UIImage imageNamed:@"categray"]];
    [_navBar addSubview:categray_goto];
    [categray_goto mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerY.mas_equalTo(_navBar.mas_centerY);
        make.right.mas_offset(5);
    }];
    //点击事件
    categray_goto.userInteractionEnabled = YES;
    UITapGestureRecognizer *categray_click = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(categray_click)];
    [categray_goto addGestureRecognizer:categray_click];
    
    
    UIView *searchVIew = [UIView new ];
    searchVIew.backgroundColor = RGB(198, 198, 198);
    searchVIew.layer.masksToBounds = YES;
    searchVIew.layer.cornerRadius = 12;
    [_navBar addSubview:searchVIew];
    [searchVIew mas_makeConstraints:^(MASConstraintMaker *make){
        make.bottom.mas_equalTo(_navBar.mas_bottom);
          make.centerY.mas_equalTo(_navBar.mas_centerY);
        make.left.equalTo(image_logo.mas_right).offset(5);
        make.right.equalTo(categray_goto.mas_left).offset(-5);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(Width*2/3);
    }];
    UITapGestureRecognizer *search_click = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(search_click)];
    [searchVIew addGestureRecognizer:search_click];
    
    
    
    UIImageView *searchImage = [UIImageView new];
    [searchImage setImage:[UIImage imageNamed:@"search"]];
    [searchVIew addSubview:searchImage];
    [searchImage mas_makeConstraints:^(MASConstraintMaker *make){
       make.centerY.mas_equalTo(_navBar.mas_centerY);
        make.left.mas_offset(5);
    }];
    
   self.navigationItem.titleView = _navBar;
 
}

-(void)search_click{
    [self searchBar];
}

-(void)categray_click{//不用带任何参数，只需要跳转到分类页就好
    NSLog(@"categray_click点击事件生效");
    /*
     productMainController *product = [[productMainController alloc]initWithProductId:notification.object];
     
     [self.navigationController pushViewController:product animated:YES];
     */
    [self pushTofirstClassify:@"110"];
}

-(void)pushTofirstClassify:(NSString *)catagoryId{
    firstClassify *classify = [[firstClassify alloc]initWithCategoryId:catagoryId];
    
    [self.navigationController pushViewController:classify animated:YES];
}

-(void)buildTableHeadView{

        //数据如何进行缓存
  //  __weak typeof (self) weakSelf = self; //后期再考虑是否用__weak
    
    
    [zxb_home getHomeData:^(zxb_Result *result,zxb_home_data *data){//其实result已经包含到data中
        
        self.home_data = data;
        self.result = result;
        
        self.homeheadView =[[HomeHeadView alloc]initWithHeadData:_home_data];//直接拿homeData来进行的数据解析，没有进行分类处理
        [self.collectionView addSubview:self.homeheadView];
        //  [self.collectionView reloadData];
        //设置数据和这只代理  放在buildCollectionView中 没有作用，示例代码放在buildCollectionView中可以
        _collectionView.delegate = self;
        _collectionView.dataSource = self;

        
    } failure:^(NSError *error) {
        NSLog(@"getHomeData is on failure");
    }];
    
    
    
    
}

-(void)buildCollectionView{
    NSLog(@"buildCollectionView");
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
    
    [self.collectionView registerClass:[HomeFooterCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerCellId];//尾介绍 比如没有更多商品
    
    [self.collectionView registerClass:[HomeHeaderCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerCellId];//头介绍
    
    [self.collectionView registerClass:[recommendCell class] forCellWithReuseIdentifier:recommendCelSub];
    //品牌的注册
    [self.collectionView registerClass:[brandCell class]  forCellWithReuseIdentifier:brandCellView];
    //适用人群注册
    [self.collectionView registerClass:[fitPeopleCell class] forCellWithReuseIdentifier:groupCell];
    
    //新品和小编推荐
    [self.collectionView registerClass:[goodsCell class] forCellWithReuseIdentifier:goodCell];
    
    [self.view addSubview:self.collectionView];//将CollectionView添加到UIView
    //定位
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.edges.equalTo(self.view);
    }];
    
}


- (void)bulidTableViewRefresh{//刷新
    AJAnimationRefreshHeader *header = [AJAnimationRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefeshData)];
    header.gifView.frame = CGRectMake(0, 30, 100, 100);
    _collectionView.mj_header = header;
    //[_collectionView.mj_header beginRefreshing];//一进入就支持刷新
}

- (void)headerRefeshData{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_collectionView.mj_header endRefreshing];
    });
}
//没有点击操作不会触发这个方法
- (void)showActityDetail:(HeadViewItemType)type tag:(NSInteger)tag{
  
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return 5;//推荐 + 品牌 + 适用人群 + 新品 + 小编推荐
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
   if (section==0) {
       return 1;
    }
    if(section == 1){
    
        return self.home_data.hot_brand.count;
    }
    if (section == 2) {
        return self.home_data.objGroup.count;
    }
    if (section == 3) {
        return self.home_data.newgoods.count;//跟json有出入：the_
    }
    if(section == 4){
        return self.home_data.recommend_goods.count;
    }
   
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //这里要返回的array 但是产品里的设计是非数组的形式
    if (indexPath.section == 0) {
        recommendCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:recommendCelSub forIndexPath:indexPath];
    cell.data =self.home_data;
        return cell;
    }else if (indexPath.section == 1){//推荐品牌
        brandCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:brandCellView forIndexPath:indexPath];
        cell.brand = self.home_data.hot_brand[indexPath.row];
        return cell;
    }else if (indexPath.section == 2){//推荐品牌
        fitPeopleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:groupCell forIndexPath:indexPath];
        NSLog(@"cellForItemAtIndexPath is indexPath.section == 2 ");
        cell.groupData = self.home_data.objGroup[indexPath.row];
        return cell;
    }
    else if (indexPath.section == 3){//新品出不来的原因是
        goodsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:goodCell forIndexPath:indexPath];
        NSLog(@"cellForItemAtIndexPath is indexPath.section == 3");
        cell.goodsNew = self.home_data.newgoods[indexPath.row];
        return cell;
    }
    else if (indexPath.section == 4){//推荐品牌
        goodsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:goodCell forIndexPath:indexPath];
        NSLog(@"cellForItemAtIndexPath is indexPath.section == 4");
        cell.goodsRecommend = self.home_data.recommend_goods[indexPath.row];
        return cell;
    }
   return nil;//不要忘记在每个if里面return cell
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
   NSLog(@"sizeForItemAtIndexPath is doing ");
    CGSize itemSize = CGSizeZero;
   if (indexPath.section == 0) {
        NSLog(@"sizeForItemAtIndexPath is doing 330");
//        itemSize = CGSizeMake(Width, 0);//cellitem的高度
       itemSize.width=Width;
       itemSize.height = Width;//85是“每周特卖”+倒计时的高度加余量
    }
   else if (indexPath.section == 1){
       itemSize = CGSizeMake(Width/3 , Width/5);
   }else if (indexPath.section == 2){
       itemSize = CGSizeMake(Width/3 , Width/3);
   }else{
       itemSize = CGSizeMake(Width/2-2.5 , Width*4/5);
   }
    
    return itemSize;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    NSLog(@"referenceSizeForHeadderInSection");//指头间距
    if (section == 0) {
        return CGSizeMake(Width, HomeCollectionViewCellMargin);
    }else if(section == 1){
        return CGSizeMake(Width, HomeCollectionViewCellMargin*3);
    }else if(section == 2){
        return CGSizeMake(Width, HomeCollectionViewCellMargin*3);
    }else if(section == 3){
        return CGSizeMake(Width, HomeCollectionViewCellMargin*3);
    }else if(section == 4){
        return CGSizeMake(Width, HomeCollectionViewCellMargin*3);
    }
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    NSLog(@"referenceSizeForFooterInsection");//foot没有更多商品的显示
    if (section == 4) {
        return CGSizeMake(Width,50);
    }
    return CGSizeZero;
}

//显示标题
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"viewForSupplementaryElemetOfKind");
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        HomeHeaderCell *cell = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerCellId forIndexPath:indexPath];
        if (indexPath.section == 0) {
            [cell showTitleLable:NO];
        }else if(indexPath.section == 1){
            [cell showTitleLable:YES];
            [cell setTitle:@"热门品牌"];
        }else if(indexPath.section == 2){
            [cell showTitleLable:YES];
            [cell setTitle:@"适用人群"];
        }else if(indexPath.section == 3){
            [cell showTitleLable:YES];
            [cell setTitle:@"新品上市"];
        }else if(indexPath.section == 4){
            [cell showTitleLable:YES];
            [cell setTitle:@"小编推荐"];
        }
        return cell;
    }
    if([kind isEqualToString:UICollectionElementKindSectionFooter]){
        HomeFooterCell *cell = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerCellId forIndexPath:indexPath];
        
        if (indexPath.section == 4) {
            [cell setHidden:YES];
        }else{
            [cell setHidden:NO];
        }
        
        return cell;
    }
    
    return nil;
    
}

@end
