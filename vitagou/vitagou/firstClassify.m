//
//  firstClassify.m
//  vitagou
//
//  Created by Mac on 2017/8/7.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

/*
 1.navbar:替换titleVIew
 
 */
#import <Foundation/Foundation.h>
#import "firstClassify.h"
#import "secondClassifyCellPurpose.h"
#import "secondClassifyCellFlag.h"
#import "secondClassifyCellHeader.h"
#import "secondClassifyCellNutrilon.h"
#import "productList.h"


@interface firstClassify()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>


@property (nonatomic, strong) UIView *searchBar;

@property(nonatomic, strong) NSMutableArray *categoryArray;//二级数据

@end

@implementation firstClassify


static NSString *classifyCellId = @"classifyCellId";//右视图
static NSString *classifyCellTwo = @"classifyCellTwo";//左视图

static NSString *secondClassifyCellPurposeId = @"secondClassifyCellPurposeId";//目的功能的cell

static NSString *secondClassifyCellNutrilonId = @"secondClassifyCellNutrilonId";//营养属性的cell

static NSString *secondClassifyCellFlagId = @"secondClassifyCellFlagId";//国家地区和品牌的cell

static NSString *secondClassifyCellHeaderId = @"secondClassifyCellHeaderId";//属性介绍的头

static NSString *categoryId;
-(instancetype)initWithCategoryId:(NSString *)CategoryId{
    NSLog(@"firstClassify-initWithCategoryId");
//    [self.secondVc initWithCategoryId:CategoryId
//initWithCategoryName:@""];
    _Category_id = CategoryId;
    
    return self;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.frame = CGRectMake(0, 0, 70, Height-NavH-50);//100 是item的高度  50 是底部导航
        
        _tableView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_tableView];
        _tableView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
        [_tableView registerClass:[fisrtClassifyCell class] forCellReuseIdentifier:classifyCellId];
    }
    return _tableView;
}

/*
 cell根据图片的形状选择不同的imageview的宽高
 */
- (UICollectionView *)collectionView
{
    
    
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.minimumInteritemSpacing = 3; //X
        layout.minimumLineSpacing = 5;  //Y
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
//        _collectionView.delegate = self;
//        _collectionView.dataSource = self;
        [self.view addSubview:_collectionView];
        NSLog(@"- (UICollectionView *)collectionView------------");
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.frame = CGRectMake(70, 0, Width - 70, Height-NavH-50);
        //注册Cell
        [_collectionView registerClass:[secondClassifyCellPurpose class] forCellWithReuseIdentifier:secondClassifyCellPurposeId];
         [_collectionView registerClass:[secondClassifyCellNutrilon class] forCellWithReuseIdentifier:secondClassifyCellNutrilonId];
         [_collectionView registerClass:[secondClassifyCellFlag class] forCellWithReuseIdentifier:secondClassifyCellFlagId];
        //注册Header  secondClassifyCellHeaderId
        [_collectionView registerClass:[secondClassifyCellHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:secondClassifyCellHeaderId];
    }
    return _collectionView;
}


-(void)viewDidLoad{

    [super viewDidLoad];
//    self.hidesBottomBarWhenPushed = YES;//隐藏底部导航栏
       NSLog(@"viewDidLoad");
    [self tableView];
    [self collectionView];
    [self addNotification];
    [self setSearch];
    [self getClassifyData];
    [self buildCollectionView];
    [self initSecondVc];
    
    
    
    //调一级数据接口
}


-(void)addNotification{//回传数据是categoryid 和 categoryname
    
    [AJNotification addObserver:self selector:@selector(secondClassify:) name:ClassifyNotification object:nil];
    
}

-(void)secondClassify:(NSNotification *)notification{
    NSString *categoryId = notification.object;
    NSLog(@"secondClassify notification %@",categoryId);
    [self.secondVc initWithCategoryId:categoryId
                 initWithCategoryName:@"目的功能"
     ];
}

-(void)setSearch{//要给searchbar设置的点击事件  做搜索的时候设置
    
NSLog(@"setSearch");
    _searchBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Width*3/4, 30)];
    _searchBar.backgroundColor = [UIColor whiteColor];
    
    //search背景
    UIView *searchVIew = [UIView new ];
    searchVIew.backgroundColor = RGB(198, 198, 198);
    searchVIew.layer.masksToBounds = YES;
    searchVIew.layer.cornerRadius = 12;
    [_searchBar addSubview:searchVIew];
    [searchVIew mas_makeConstraints:^(MASConstraintMaker *make){
        make.bottom.mas_equalTo(_searchBar.mas_bottom);
        make.right.mas_offset(0);
//        make.right.mas_offset(20);//为了留给返回键空间
        make.width.mas_equalTo(Width*3/4);
        make.height.mas_equalTo(30);
    }];
    
    UIImageView *searchImage = [UIImageView new];
    [searchImage setImage:[UIImage imageNamed:@"search"]];
    [searchVIew addSubview:searchImage];
    [searchImage mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerY.mas_equalTo(_searchBar.mas_centerY);
        make.left.mas_offset(5);
    }];
    
//    UISearchBar *search = [[UISearchBar alloc]initWithFrame:CGRectMake(Width/4, 0, Width*3/4, 30)];
//    search.backgroundColor = [UIColor greenColor];
    self.navigationItem.title = @"属性列表";
//    self.navigationItem.titleView = search;
//    self.navigationItem.leftBarButtonItem;
}

-(void)getClassifyData{
    [zxb_classify getClassifyData:^(zxb_Result *result, zxb_classify_data *data) {
        NSLog(@"getClassifyData");
        _classify_data = data;
        NSLog(@"_classify.data %lu",(unsigned long)data.CategoryNo1.count);
        //result
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
       
        
        [self initWithDataForColletionView:@"110"];
        
//        _collectionView.delegate = self;
//        _collectionView.dataSource = self;
      
        
        
        
        
    } failure:^(NSError *error) {
        //弹出对话框提示网络问题
    }];
}

-(void)buildCollectionView{
   
}



/*
 进入的入口有好几个  品牌  然后是默认的目的功能  从品牌进入的时候给一个判断的标识  这里写if else 循环
 */
-(void)initSecondVc{
//    if (YES) {//判断依据由首页传过来
//        [self.secondVc initWithCategoryId:@"9999"
//                     initWithCategoryName:@"品牌"
//         ];
//    }
//    [self.secondVc initWithCategoryId:_Category_id
//                 initWithCategoryName:@"目的功能"
//     ];
}


#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _classify_data.CategoryNo1.count;//左标题数量
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"cellForRowAtIndexPath<<<<<<<<<<<<<<®");
    fisrtClassifyCell *cell = [tableView dequeueReusableCellWithIdentifier: classifyCellId forIndexPath:indexPath];
    cell.category = self.classify_data.CategoryNo1[indexPath.row];
    return cell;
}

#pragma mark - <UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

//一行被选择后加载二级数据
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    zxb_category *category = self.classify_data.CategoryNo1[indexPath.row];
    
    categoryId = category.category_id;
    
    NSLog(@"catwgoryId %@",categoryId);
    
     [self initWithDataForColletionView:categoryId];
    
    
}



-(void)initWithDataForColletionView:(NSString *)categoryId{
    [zxb_classify_two getClassifyTwoData:categoryId
                                 success:
     ^(zxb_Result *result, NSMutableArray *data) {
         NSLog(@"NSMutableArray *data count %li",data.count );
         NSLog(@"NSMutableArray *result count %@",result.msg );
         _categoryArray = data;
         _collectionView.delegate = self;
         _collectionView.dataSource = self;
         
         [self.collectionView reloadData];
     } failure:
     
     ^(NSError *error) {
         
     }];
}

-(NSInteger)
numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    NSLog(@"numberOfSectionsInCollectionView");
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return  _categoryArray.count;//返回一级分类数量
    
}

//
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"cellForItemAtIndexPath");
    UICollectionViewCell *gridcell = nil;
    zxb_classify_two_data *data = _categoryArray[indexPath.row];
    NSLog(@"data.parent_id %@",data.parent_id);
    if ([data.parent_id isEqualToString:@"110"]) {//目的功能
        secondClassifyCellPurpose *cell = [collectionView dequeueReusableCellWithReuseIdentifier:secondClassifyCellPurposeId forIndexPath:indexPath];
        cell.classify_two_data = data;
        gridcell = cell;
    }else if ([data.parent_id isEqualToString:@"126"]){//营养属性+使用人群
        secondClassifyCellNutrilon *cell = [collectionView dequeueReusableCellWithReuseIdentifier:secondClassifyCellNutrilonId forIndexPath:indexPath];
        cell.classify_two_data = data;
        gridcell = cell;
    }else if ([data.parent_id isEqualToString:@"140"]){//营养属性+使用人群
        secondClassifyCellNutrilon *cell = [collectionView dequeueReusableCellWithReuseIdentifier:secondClassifyCellNutrilonId forIndexPath:indexPath];
        cell.classify_two_data = data;
        gridcell = cell;
    }else if ([data.parent_id isEqualToString:@"76"]){//营养属性+使用人群
        secondClassifyCellNutrilon *cell = [collectionView dequeueReusableCellWithReuseIdentifier:secondClassifyCellNutrilonId forIndexPath:indexPath];
        cell.classify_two_data = data;
        gridcell = cell;
    }
    else
//        if([data.parent_id isEqualToString:@"140"])
    {//国别地区+品牌
        secondClassifyCellFlag *cell = [collectionView dequeueReusableCellWithReuseIdentifier:secondClassifyCellFlagId forIndexPath:indexPath];
        cell.classify_two_data = data;
        gridcell = cell;
    }
    
    return gridcell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    NSLog(@"sizeForItemAtIndexPath");
    CGSize itemSize = CGSizeZero;
    zxb_classify_two_data *data = _categoryArray[indexPath.row];
    
    if ([data.parent_id isEqualToString:@"110"]) {//目的功能
      itemSize = CGSizeMake((Width-70)/2-2, Width/2+30);
    }else if ([data.parent_id isEqualToString:@"126"]){//营养属性+使用人群
      itemSize = CGSizeMake((Width-70)/2-2 , (Width-70)/2-2+30);
    }else if ([data.parent_id isEqualToString:@"140"]){//国别地区+品牌
      itemSize = CGSizeMake((Width-70)/2-2, (Width-70)/2-2+30);
    }else if ([data.parent_id isEqualToString:@"76"]){//国别地区+品牌
        itemSize = CGSizeMake((Width-70)/2-2, (Width-70)/2-2+30);
    }
    else{
      itemSize = CGSizeMake((Width-70)/2-2, (Width-70)/2-2-20);
    }
    
    return itemSize;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableview = nil;
     zxb_classify_two_data *data = _categoryArray[indexPath.row];
    if (kind == UICollectionElementKindSectionHeader){
        
        secondClassifyCellHeader *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:secondClassifyCellHeaderId forIndexPath:indexPath];
        if ([data.parent_id isEqualToString:@"110"]) {//目的功能
            headerView.keyWord = @"目的功能";
        }else if ([data.parent_id isEqualToString:@"126"]){//营养属性+使用人群
             headerView.keyWord = @"营养属性";
        }else if ([data.parent_id isEqualToString:@"140"]){//国别地区+品牌
             headerView.keyWord = @"国别地区";
        }else if ([data.parent_id isEqualToString:@"76"]){//国别地区+品牌
             headerView.keyWord = @"适用人群";
        }
        else{
             headerView.keyWord = @"品牌";
        }
        
        reusableview = headerView;
    }
    return reusableview;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(_collectionView.width, 25);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    zxb_classify_two_data *data = _categoryArray[indexPath.row];
    
    if (data.parent_id != nil) {
//         NSLog(@"点击了个第分组第几个Item %@",data.category_id);
        productList *list = [[productList alloc]initWithCategoryOrBrandOrKeyword_id:data.category_id label:@"category_id"];
        [self.navigationController pushViewController:list animated:YES];
    }else{
//         NSLog(@"没有categoryID  %@", data.brand_id);
        productList *list = [[productList alloc]initWithCategoryOrBrandOrKeyword_id:data.brand_id label:@"bid"];
        [self.navigationController pushViewController:list animated:YES];
    }
}

@end
