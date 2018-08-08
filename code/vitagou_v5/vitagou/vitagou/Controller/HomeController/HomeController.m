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
#import <SDCycleScrollView/SDCycleScrollView.h>//轮播图
//第一层cell是基本的布局结构，
@interface HomeController () <UICollectionViewDelegate,UICollectionViewDataSource,SearchViewDelegate,SDCycleScrollViewDelegate
>
@property (assign,nonatomic) SearchNavView *searchView;

@property (assign,nonatomic) UICollectionView *tableView;

@property (assign,nonatomic) adv_list *advList;

@property (assign,nonatomic) adv_list_item *advListItem;

@property (assign,nonatomic) SDCycleScrollView *CyclePageView;

//轮播图的数组 image: 图片地址 type：类型 data：根据类型来的 可能是跳转地址
@property (assign,nonatomic) NSMutableArray *imageArray;
@property (assign,nonatomic) NSMutableArray *typeArray;
@property (assign,nonatomic) NSMutableArray *dataArray;


@end

@implementation HomeController


- (void)viewDidLoad{
    NSLog(@"HomeController_viewDidLoad");
    [super viewDidLoad];
    [self getHomeData];
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

-(void)getHomeData{
    [homeData getHomeData:^(NSString *code, homeData *data) {
//        NSLog(@"code %@",code);
        NSLog(@"homeData——code %@",data.code);//地址值
        if (data.datas != nil) {
//            id key = data.datas;
                    for (int i = 0; i < data.datas.count; i++) {
            
                        NSArray *key = [data.datas[i] allKeys];
                        for (int j = 0; j < key.count; j++) {
                            if ([key[j] isEqualToString:@"adv_list"]) {
                                NSLog(@"识别出来了");
                                self.advList = data.datas[i];
                                NSLog(@"data.datas[i] %@",data.datas[i]);
//                                NSDictionary *dt = data.datas[i];
//                                self.advList.item = [dt objectForKey:@"item"];
                                
                                NSLog(@"self.advList.item %lu", (unsigned long)self.advList.item.count);
                                
                            }
                        }
                    }
            
        }
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


- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return nil;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 0;
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

