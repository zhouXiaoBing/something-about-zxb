//
//  ProductController.m
//  vitagou
//
//  Created by Mac on 2017/7/11.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import "ProductController.h"


/*
 将headview里面的内容做相应的调整就好
 */
@interface ProductController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{



}



@end

@implementation ProductController


//get goods_id
-(instancetype)initWithProductId:(NSString *)product_id{
    self.hidesBottomBarWhenPushed = YES;//隐藏底部导航栏
    _goods_id = product_id;
    

    
    return self;
}

-(void)viewDidLoad{
   NSLog(@"进入商品详情");
//    NSLog(@"initWithProductId");
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    self.navigationItem.leftBarButtonItem.title = @"返回";
//    self.navigationItem.title = @"商品详情";
    
    [self addNotification];
    [self buildCollectionView];
    [self getProductData];
    
}

- (void)addNotification{

    [AJNotification addObserver:self
                       selector:@selector(productHeadViewHeightDidChange:)
                           name:ProductHeadViewHeightDidChange object:nil];
}

-(void)productHeadViewHeightDidChange:(NSNotification *)notification{
    
    
    NSLog(@"height = %lf",[notification.object floatValue]);
    CGFloat height = [notification.object floatValue];
    self.collectionView.mj_header.ignoredScrollViewContentInsetTop = height;
    self.proView.frame = CGRectMake(0, -height, Width, height);
    self.collectionView.contentInset = UIEdgeInsetsMake(height, 0, 0, 0);
    self.collectionView.contentOffset = CGPointMake(0, -height);
    
}

-(void)getProductData{

    [product getProductDetail:(NSString *) _goods_id
     
    success:^(zxb_Result *result, zxb_product_data *data) {
        NSLog(@"详情相关数据 %@",data.name);
        
        self.proData = data;
        self.result = result;
        
        self.proView = [[ProductHeadView alloc]initWithData:data];
        
        [self.collectionView addSubview:self.proView];
        
        
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    }
     
    failure:^(NSError *error) {
        NSLog(@"getHomeData is on failure");
    }];
    
}

-(void)buildCollectionView{

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
    
    
    [self.view addSubview:self.collectionView];//将CollectionView添加到UIView
    //定位
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.edges.equalTo(self.view);
    }];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return nil;
}


@end
