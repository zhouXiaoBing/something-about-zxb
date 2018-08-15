//
//  HomeController.m
//  vitagou
//
//  Created by Mac on 2018/7/20.
//  Copyright © 2018年 vitagou. All rights reserved.
//
/**
 *
 *1.collectionView 带下拉刷新，无上拉加载
 *2.导航栏改logo，加搜索 ：自定义的navigationBar不在下拉刷新内部
 *3.item1：轮播图 __ adv_list
 item2：跳转Button __ 不需要数据源
 item3：轮播做活动的商品 __ goods1
 item4：新品上架listView显示 __ week_new
 item5：valley形式展示年中折扣 __ special_pic
 item6：Grid展示全球精选商品 __ goods
 item7：grad展示品牌 __ brand
 */
#import "HomeController.h"
#import "SearchNavView.h"
#import "homeData.h"
#import "adv_list.h"
#import "adv_list_item.h"
#import "HomeScrollView.h"
#import "HomeHeaderCell.h"
#import "HomeBtnView.h"

//第一层cell是基本的布局结构，
@interface HomeController () <UICollectionViewDelegate,UICollectionViewDataSource,SearchViewDelegate
>
@property (assign,nonatomic) SearchNavView *searchView;

@property (assign,nonatomic) UICollectionView *tableView;

@property (assign,nonatomic) adv_list *advList;

@property (assign,nonatomic) NSMutableArray *advListItem;

@property (strong,nonatomic) UICollectionView *collectionView;

@property (assign,nonatomic) HomeScrollView *homeScrollView;

@property (strong,nonatomic) HomeBtnView *homeBtnView;



//轮播图的数组 image: 图片地址 type：类型 data：根据类型来的 可能是跳转地址
@property (assign,nonatomic) NSMutableArray *imageArray;
@property (assign,nonatomic) NSMutableArray *typeArray;
@property (assign,nonatomic) NSMutableArray *dataArray;


@end

@implementation HomeController

#pragma -mark conllectionViewCell
static NSString *pageScroller = @"pageScroller";
static NSString *footerCellId = @"footerCellId";
static NSString *headerCellId = @"headerCellId";
static NSString *homeBtnViewId = @"homeBtnView";

NSMutableArray *imageArr;
NSMutableArray *typeArr;
NSMutableArray *dataArr;

- (void)viewDidLoad{
    NSLog(@"HomeController_viewDidLoad");
    [super viewDidLoad];
    [self getHomeData];
    [self buildCollectionView];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (@available(iOS 11.0, *)){
            [[UIScrollView appearanceWhenContainedInInstancesOfClasses:@[[BaseViewController class]]] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
        }
    });
    //添加 tableView

    self.searchView.searchDelegate = self;//委托运行的基础

}

-(void)buildCollectionView{
    NSLog(@"enter_buildConllectionView");
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(5, 0, 0, 5);
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
    //---------------------------------------------------//
    [self.collectionView registerClass:[HomeScrollView class] forCellWithReuseIdentifier:pageScroller];
    [self.collectionView registerClass:[HomeBtnView class] forCellWithReuseIdentifier:homeBtnViewId];
    [self.collectionView registerClass:[HomeFooterCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerCellId];
    [self.collectionView registerClass:[HomeHeaderCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerCellId];
    
    [self.view addSubview:self.collectionView];
    //location
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view);
            make.edges.equalTo(self.view);
        }];
    }];
    
}

-(void)getHomeData{
    [homeData getHomeData:^(NSString *code, homeData *data) {
//        NSLog(@"code %@",code);
        NSLog(@"homeData——code %@",data.code);//地址值
        
         imageArr = [NSMutableArray array];
         typeArr = [NSMutableArray array];
         dataArr = [NSMutableArray array];
        if (data.datas != nil) {
//            self.imageArray = [NSMutableArray arrayWithCapacity:10];
                    for (int i = 0; i < data.datas.count; i++) {
                        NSArray *key = [data.datas[i] allKeys];
                        for (int j = 0; j < key.count; j++) {
                            if ([key[j] isEqualToString:@"adv_list"]) {
                                NSLog(@"识别出来了");
                                //将item里面的字典转为模型
                               NSArray *dic = [[data.datas[i] objectForKey:key[j]] objectForKey:@"item"];
                                for (int h = 0; h < dic.count; h++) {
                                    NSLog(@"image %@",[dic[h] objectForKey:@"image"]);//可以输出
                                    NSLog(@"image %@",[dic[h] objectForKey:@"type"]);
                                    NSLog(@"image %@",[dic[h] objectForKey:@"data"]);
                                    [imageArr addObject:[dic[h] objectForKey:@"image"]];
                                    [typeArr addObject:[dic[h] objectForKey:@"type"]];
                                    [dataArr addObject:[dic[h] objectForKey:@"data"]];
                                }
                            }
                        }
                    }
                }
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark - searchView
- (SearchNavView *)searchView{
    NSLog(@"HomeController_searchView");
        SearchNavView *searchView = [[SearchNavView alloc]initWithFrame:CGRectMake(0, 20, CGRectGetWidth(self.view.frame), 44)];
        [self.view addSubview:searchView];
    _searchView = searchView;
    return _searchView;
}

- (void)searchViewEvent:(UIView *)sender search:(SearchNavView *)searchBar{
    //用于跳转到搜索的页面
    NSLog(@"HomeController_searchViewEvent");
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSLog(@"cellForItemAtIndexPath...");
    if (indexPath.section == 0) {
        HomeScrollView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:pageScroller forIndexPath:indexPath];
        //数据
        cell.imageArray = imageArr;
        NSLog(@"imageArr %lu",(unsigned long)imageArr.count);
      return cell;
    }else if(indexPath.section == 1){
        HomeBtnView *btn = [collectionView dequeueReusableCellWithReuseIdentifier:homeBtnViewId forIndexPath:indexPath];
        [btn init];
        return btn;
    }
    return  nil;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {//轮播图
        return 1;
    }else if(section == 1){
        return 1;
    }
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize itemSize = CGSizeZero;
    if (indexPath.section == 0) {
        itemSize = CGSizeMake(kScreen_Width, kScreen_Width*13/32);
    }else if (indexPath.section == 1){
        itemSize = CGSizeMake(kScreen_Width, 80);
    }
    return itemSize;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return  CGSizeZero;
    }else  if (section == 1) {
        return  CGSizeMake(kScreen_Width, 40);
    }
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return  CGSizeZero;
    }else  if (section == 1) {
        return CGSizeZero;
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
        }else if (indexPath.section == 1) {
            [cell showTitleLable:NO];
        }

       
        return cell;
    }
    if([kind isEqualToString:UICollectionElementKindSectionFooter]){
        HomeFooterCell *cell = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerCellId forIndexPath:indexPath];
        
        if (indexPath.section == 5) {
            [cell setHidden:YES];
        }else{
            [cell setHidden:NO];
        }
        
        return cell;
    }
    
    return nil;
}



- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
    
}

- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection {
    
}

- (void)preferredContentSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
    
}

- (CGSize)sizeForChildContentContainer:(nonnull id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize {
    return CGSizeZero;
}

- (void)systemLayoutFittingSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
    
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
    
}

- (void)willTransitionToTraitCollection:(nonnull UITraitCollection *)newCollection withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
    
}

- (void)didUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context withAnimationCoordinator:(nonnull UIFocusAnimationCoordinator *)coordinator {
    
}

- (void)setNeedsFocusUpdate {
    
}

- (BOOL)shouldUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context {
    return true;
}

- (void)updateFocusIfNeeded {
    
}

@end

