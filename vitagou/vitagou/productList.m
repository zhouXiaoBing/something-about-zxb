//
//  productList.m
//  vitagou
//
//  Created by Mac on 2017/8/15.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import "productList.h"
#import "PYSearch.h"
#import "productListCell.h"
#import "DCCustionHeadView.h"
#import "productMainController.h"

@interface productList ()<UICollectionViewDataSource,UICollectionViewDelegate,PYSearchViewControllerDelegate>

@property(nonatomic, strong) NSString *CategoryOrBrandOrKeyword_id;

@property(nonatomic, strong) NSString *label;//识别搜索标签

@end

@implementation productList

static NSString  *productListCellId = @"productListCellId";
static NSString *const DCCustionHeadViewID = @"DCCustionHeadViewID";//筛选

-(instancetype)initWithCategoryOrBrandOrKeyword_id:(NSString *)
CategoryOrBrandOrKeyword_id
label:(NSString *)label{
    NSLog(@"initWithCategoryOrBrandOrKeyword_id %@",CategoryOrBrandOrKeyword_id);
     NSLog(@"initWithCategoryOrBrandOrKeyword_id %@",label);
    _CategoryOrBrandOrKeyword_id = CategoryOrBrandOrKeyword_id;
    
    _label = label;
//     [self getparamsData];
    return self;
}

-(void)viewDidLoad{
    
    [super viewDidLoad];
    self.hidesBottomBarWhenPushed =YES;
    NSLog(@"viewDidLoad");
    [self addNotification];
    [self getparamsData];
    [self setSearch];
    
}
-(void)setSearch{//要给searchbar设置的点击事件  做搜索的时候设置
    NSLog(@"setSearch__");
//    self.navigationController.navigationBarHidden = NO;
//    self.navigationController.navigationBar.translucent = NO;
//    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
//    _searchBar = [[UIView alloc]init];
//    _searchBar.size = CGSizeMake(Width*3/4, 30);
//    _searchBar = [[UIView alloc]initWithFrame:CGRectMake(Width/4, 0, Width*3/4, 30)];
//    _searchBar.backgroundColor = [UIColor greenColor];
    
//    [_searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(self);
//        make.width.mas_equalTo(Width*3/4);
//        make.right.mas_equalTo(self);
//    }];
    //search背景
    UIView *searchVIew = [[UIView alloc]initWithFrame:CGRectMake(Width/4, 0, Width*3/4, 30)];
//    searchVIew.size = CGSizeMake(Width*3/4, 30);
    searchVIew.backgroundColor = RGB(198, 198, 198);
    searchVIew.layer.masksToBounds = YES;
    searchVIew.layer.cornerRadius = 12;
//    [_searchBar addSubview:searchVIew];
//    [searchVIew mas_makeConstraints:^(MASConstraintMaker *make){
////        make.bottom.mas_equalTo(_searchBar.mas_bottom);
//        make.centerY.mas_equalTo(_searchBar.mas_centerY);
////        make.left.mas_offset(0);
////        make.right.mas_equalTo(_searchBar.mas_right).offset(Width/2);
//        //        make.right.mas_offset(20);//为了留给返回键空间
//        make.width.mas_equalTo(searchVIew.size);
//        make.height.mas_equalTo(30);
//    }];
    
    UITapGestureRecognizer *search_click = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(search_click)];
    [searchVIew addGestureRecognizer:search_click];
    
    UIImageView *searchImage = [UIImageView new];
    [searchImage setImage:[UIImage imageNamed:@"search"]];
    [searchVIew addSubview:searchImage];
    [searchImage mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerY.mas_equalTo(searchVIew.mas_centerY);
        make.left.mas_offset(5);
    }];
    
//    self.navigationItem.rightBarButtonItem.
    NSLog(@"self.navigation.titleView.width %f",self.navigationItem.titleView.width);
//    NSLog(@"_serarchbar.width %f",_searchBar.width);
//    NSLog(@"rect1: %@", NSStringFromCGRect(_searchBar.frame));
    NSLog(@"rect1: %@", NSStringFromCGRect(searchVIew.frame));
    
    
    self.navigationItem.title = @"商品列表";
}
-(void)addNotification{
    
    
    
}

-(void)setProductSort:(UIView *)productSort{
    
}

-(void)search_click{
    [self searchBar];
}

-(void)getparamsData{
    
    [zxb_product_list getProductListData:_CategoryOrBrandOrKeyword_id
                                   label:_label
                                 success:^(zxb_Result *result, NSMutableArray *data) {
                                     NSLog(@"getparams %lu",data.count);
                                     _listData = data; _collectionView.delegate = self;
                                     _collectionView.dataSource = self;
                                 } failure:^(NSError *error) {
                                     
                                 }];
    [self buildCollectionView];
}

-(void)buildCollectionView{
    NSLog(@"buildCollectionView");
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
    [self.collectionView registerClass:[productListCell class] forCellWithReuseIdentifier:productListCellId];
    [self.view addSubview:self.collectionView];
    
    [_collectionView registerClass:[DCCustionHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCCustionHeadViewID];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.edges.equalTo(self.view);
    }];
    }

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

    return _listData.count;
}

- (NSInteger)numberOfSecionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    productListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:productListCellId forIndexPath:indexPath];
    NSLog(@"cellForItemAtIndexPath");
    cell.listData = _listData[indexPath.row];
    
    return cell;

}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
 CGSize itemSize = CGSizeZero;
    itemSize.width=Width;
    itemSize.height = Width/3+10;
    
    return itemSize;
}

//跳转到详情页
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    zxb_list_data *data = _listData[indexPath.row];
    NSString *goodsId = data.goods_id;
    NSLog(@"goodsId %@",goodsId);
    
    productMainController *product = [[productMainController alloc]initWithProductId:goodsId];
    [self.navigationController pushViewController:product animated:YES];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader){
        
        DCCustionHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCCustionHeadViewID forIndexPath:indexPath];
        __weak typeof(self)weakSelf = self;
        headerView.filtrateClickBlock = ^{//点击了筛选
            [weakSelf filtrateButtonClick];
        };
        headerView.priceDownClickBlock =^{
            [weakSelf priceDownClickBlock];
        };
        
        headerView.compositeClickBlock =^{
            [weakSelf compositeClickBlock];
        };
        headerView.priceUpClickBlock =^{
            [weakSelf priceUpClickBlock];
        };
        reusableview = headerView;
    }
    return reusableview;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(Width, 40); //头部
}


//存以下在问题，需要两次点击才能显示正确的排序结果。。。。9/5
- (void)filtrateButtonClick
{
    NSLog(@"点击了销量（原筛选）。。。。");
    [zxb_product_list getProductListDataByOrder:_CategoryOrBrandOrKeyword_id label:_label order:@"sale_toggle" success:^(zxb_Result *result, NSMutableArray *data) {
        _listData = data; _collectionView.delegate = self;
        _collectionView.dataSource = self;
    } failure:^(NSError *error) {
        
    }];
    
    [_collectionView reloadData];
}


//参数说明 两个参数 bid / cat / keyword 对应的参数值 ，  order 请求的类型 price / price_toggle / sale_toggle
- (void)priceDownClickBlock
{
    NSLog(@"点击了价格降序。。。。");
    [zxb_product_list getProductListDataByOrder:_CategoryOrBrandOrKeyword_id label:_label order:@"price_toggle" success:^(zxb_Result *result, NSMutableArray *data) {
        _listData = data; _collectionView.delegate = self;
        _collectionView.dataSource = self;
    } failure:^(NSError *error) {
        
    }];
    
    [_collectionView reloadData];
//    [self buildCollectionView];
}

- (void)priceUpClickBlock
{
    NSLog(@"点击了价格升序。。。。");
    [zxb_product_list getProductListDataByOrder:_CategoryOrBrandOrKeyword_id label:_label order:@"price" success:^(zxb_Result *result, NSMutableArray *data) {
        _listData = data; _collectionView.delegate = self;
        _collectionView.dataSource = self;
    } failure:^(NSError *error) {
        
    }];
    
    [_collectionView reloadData];
}

- (void)compositeClickBlock
{
    //就是品牌 分类 关键字 在搜索一次
    NSLog(@"点击了综合。。。。");
    [zxb_product_list getProductListData:_CategoryOrBrandOrKeyword_id
                                   label:_label
                                 success:^(zxb_Result *result, NSMutableArray *data) {
                                     NSLog(@"getparams %lu",data.count);
                                     _listData = data; _collectionView.delegate = self;
                                     _collectionView.dataSource = self;
                                 } failure:^(NSError *error) {
                                
                                 }];
    [_collectionView reloadData];
}




-(void)searchBar{//后期应该将共用的方法放在基本类和工具类中
    // 1. 创建热门搜索
    NSArray *hotSeaches = @[@"蔓越莓", @"减肥", @"胶原蛋白", @"氨糖", @"葡萄籽", @"抗衰老", @"补肾", @"鱼油"];
    // 2. 创建控制器
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:NSLocalizedString(@"商品搜索", @"搜索商品") didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        productList *list = [[productList alloc]initWithCategoryOrBrandOrKeyword_id:searchText label:@"keyword"];
        [self.navigationController pushViewController:list animated:YES];
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

@end
