//
//  TabCartController.m
//  vitagou
//
//  Created by Mac on 2017/3/30.
//  Copyright © 2017年 Vitagou. All rights reserved.
//
/**
1.调取购物车接口时，验证登陆 user_token  未登录直接跳转到登陆页面
2.接口参数就是token值一个
http://www.vitagou.hk/mobile/app_query_joincart?user_token=2ab3d289e3e40ef2845bcff636f9eaef
3.页面结构：collectionView 嵌套
 
 头部：店名 发货仓 
 content：商品信息 数量编辑
 尾部：总价计算
 
 4.通知：
*/
#import "TabCartController.h"

#import "cartCollectionViewGoodsCell.h"

#import "zxb_cart_goods.h"
#import "zxb_agency_data_goods.h"


@interface TabCartController ()<UICollectionViewDataSource, UICollectionViewDelegate,CellButtonEventViewDelegate>

@property (strong , nonatomic)UICollectionView *collectionView;

@property (nonatomic, strong)zxb_cart_goods *goods;

@property (strong , nonatomic) UIRefreshControl *refresh;
@end


@implementation TabCartController


static NSString *const cartCollectionViewGoodsCellId = @"cartCollectionViewGoodsCell";


static NSString *user_token = @"afe33cffe8d4e91d5cf9235cdb20704d";

- (void)viewDidLoad{

    self.navigationItem.leftBarButtonItem = nil;
    self.title = @"购物车";
    
    
    //验证token的存在  是否跳转到登陆页面
    [self checkUserToken];
    
    
//    [self buildCollectionView];
    
    
    [self addnotification];
    
    
   _refresh = [[UIRefreshControl alloc] init];
    _refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
    [_refresh addTarget:self action:@selector(startRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.collectionView addSubview:_refresh];
    self.collectionView.alwaysBounceVertical = YES;
    
    
}

- (void) startRefresh: (UIRefreshControl *) refresh
{
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"刷新......"];
    [_collectionView reloadData];
    [refresh endRefreshing];
}


//调用相应的接口，重新刷新数据
-(void)addnotification{
    
    //商品是否被选择的通知
    [AJNotification addObserver:self selector:@selector(goodsBeNotChoose:) name:GoodsBeChoosedNotNotification object:nil];
    
    [AJNotification addObserver:self selector:@selector(goodsBeChoose:) name:GoodsBeChoosedNotification object:nil];
    //单个商品数量编辑的通知
    [AJNotification addObserver:self selector:@selector(goodsNumEdit:) name:GoodsNumEditNotification object:nil];
    //结算的通知
    [AJNotification addObserver:self selector:@selector(goodsSettlement:) name:GoodsSettlementNotification object:nil];
    //删除商品的通知
    [AJNotification addObserver:self selector:@selector(goodsDel:) name:GoodsDelNotification object:nil];
}

-(void)goodsDel:(NSNotification *)notification{
    [zxb_cart_data goodsDel:user_token
                   goods_id:notification.object
                    success:^(zxb_Result *result) {
                        if ([result.msg isEqualToString:@"success"]) {
                            
                            [self getCartDataAgain];
                            
                        }
                    } failure:^(NSError *error) {
                        
                    }];
}

-(void)goodsSettlement:(NSNotification *)notification{
    
}

-(void)goodsNumEdit:(NSNotification *)notification{
    NSDictionary *dic = notification.userInfo;
    
    [zxb_cart_data goodsEdit:user_token
                    goods_id:[dic objectForKey:@"goods_id"]
                   goods_num:[dic objectForKey:@"editNum"]
                     success:^(zxb_Result *result) {
                         if ([result.msg isEqualToString:@"success"]) {
                             
                             [self getCartDataAgain];
                             
                         }
                     } failure:^(NSError *error) {
                         
                     }];
}

-(void)goodsBeChoose:(NSNotification *)notification{
    [zxb_cart_data goodsBeChoose:user_token
                        goods_id:notification.object
                         isCheck:@"1"
                         success:^(zxb_Result *result) {
                             if ([result.msg isEqualToString:@"success"]) {
                                 
                                 NSLog(@"goodsBeChoose");

                                [self getCartDataAgain];

                             }
    }
     failure:^(NSError *error) {
         
     }];
}

-(void)goodsBeNotChoose:(NSNotification *)notification{
    [zxb_cart_data goodsBeChoose:user_token
                        goods_id:notification.object
                         isCheck:@"0"
                         success:^(zxb_Result *result) {
                             if ([result.msg isEqualToString:@"success"]) {
                                 
                                 NSLog(@"goodsBeNotChoose");
                
                                 [self getCartDataAgain];
   
                                 
//                                 [_collectionView performSelectorOnMainThread:@selector(reloadData) withObject:_cartData waitUntilDone:YES];
                             }
                         }
                         failure:^(NSError *error) {
                             
                         }];
}


-(void)checkUserToken{
    
    //存在有效token 获取数据
    [self getCartData];
    
}

-(void)reload{
    [self.collectionView reloadData];
}

-(void)getCartData{
    //临时的user_token
    [zxb_cart_data getCartData:user_token
                       success:^(zxb_Result *result, NSMutableArray *data) {
                           NSLog(@"data.count %lu",data.count);
                           _cartData = data;
                           _collectionView.delegate = self;
                           _collectionView.dataSource = self;
                       } failure:^(NSError *error) {
                           
                       } ];
}

-(void)getCartDataAgain{
    //临时的user_token
    [zxb_cart_data getCartData:user_token
                       success:^(zxb_Result *result, NSMutableArray *data) {
                           NSLog(@"data.count %lu",data.count);
                           if (_cartData!=nil) {
                               NSLog(@"_cartData != nil");
                               [_cartData removeAllObjects];
                               NSLog(@"_cartData count %lu",_cartData.count);
                           }
                           _cartData = data;
                           if ([result.msg isEqualToString:@"success"]) {
//                               [_collectionView performSelectorOnMainThread:@selector(reloadData) withObject:_cartData waitUntilDone:NO];
                               [_collectionView reloadData];
                           }
                       } failure:^(NSError *error) {
                           
                       } ];
}

- (UICollectionView *)collectionView
{
    
    
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        self.collectionView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
        
        
        
        [self.view addSubview:self.collectionView];//将CollectionView添加到UIView
        
        
        [_collectionView registerClass:[cartCollectionViewGoodsCell class] forCellWithReuseIdentifier:cartCollectionViewGoodsCellId];
        
        
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view);
            make.edges.equalTo(self.view);
        }];
        
    }
    return _collectionView;
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
     NSLog(@"numberOfItemsInSection _cartData.count %lu",_cartData.count);
    return _cartData.count;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    UICollectionViewCell *gridcell = nil;
    cartCollectionViewGoodsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cartCollectionViewGoodsCellId forIndexPath:indexPath];
    
    cell.agencyDataGoods = _cartData[indexPath.row];
    [cell init];//莫名的解决了，重新调用接口reloadData之后，footView 不刷新的问题
        
//property access result unused - getters should not be used for side effects
    NSLog(@"cellForItemAtIndexPath agencyDataGoods %@",cell.agencyDataGoods.true_name);
    gridcell = cell;
    
    return  gridcell;
}

//因为每个仓结算的时候，商品的不是单一的，多个商品对应不同的数量 所以每个item都是动态变化的值
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
        zxb_agency_data_goods *adg  =_cartData[indexPath.row];
        NSMutableArray *goods = adg.goods;
     NSLog(@"goods.count_sizeForItemAtIndexPath %lu",goods.count);
//    NSLog(@"frame rect:%@", NSStringFromCGRect(self.containerView.frame));
    //for循环里面包含return 会导致for循环结束 ，collectionView里面本身就是一个循环
        return CGSizeMake(Width,goods.count*Width/3+60);
    
    
    
}




@end
