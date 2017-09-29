//
//  cartCollectionViewGoodsCell.m
//  vitagou
//
//  Created by Mac on 2017/9/7.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cartCollectionViewGoodsCell.h"
#import "cartCollectionViewFootCell.h"
#import "cartCollectionViewHeadCell.h"
#import "cartGoodsCell.h"
#import "PPNumberButton.h"
#import "DiscountPriceView.h"
@interface cartCollectionViewGoodsCell ()<UICollectionViewDelegate,UICollectionViewDataSource,CellButtonEventViewDelegate>

@property(nonatomic, strong) UICollectionView *collectionView;

@end

@implementation cartCollectionViewGoodsCell

static NSString *cartGoodsCellId = @"cartGoodsCellId"; //商品显示的item

static NSString *const cartCollectionViewHeadCellId = @"cartCollectionViewHeadCell";
static NSString *const cartCollectionViewFootCellId = @"cartCollectionViewFootCell";

//+(instancetype)cellWithTableView:(UICollectionView *)coleetionView{
//    cartCollectionViewGoodsCell *cell = [coleetionView dequeueReusableCellWithReuseIdentifier:cartGoodsCellId forIndexPath:nil];
//    
//    return cell;
//    
//}

-(instancetype)initWithFrame:(CGRect)frame{
    NSLog(@"footView__initWithFrame");
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;

    [_collectionView registerClass:[cartCollectionViewHeadCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:cartCollectionViewHeadCellId];
    
    [_collectionView registerClass:[cartCollectionViewFootCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:cartCollectionViewFootCellId];
    
    [_collectionView registerClass:[cartGoodsCell class] forCellWithReuseIdentifier:cartGoodsCellId];
    
    [self addSubview:self.collectionView];//将CollectionView添加到UIView
    //定位
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.edges.equalTo(self);
    }];

    return self;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _agencyDataGoods.goods.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(Width, Width/3);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
 
    cartGoodsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cartGoodsCellId forIndexPath:indexPath];
    cell.goods = _agencyDataGoods.goods[indexPath.row];
    
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    
    zxb_agency_data_goods *adg = _agencyDataGoods;

    double goods_count_price = 0;
    int goods_number = 0;
    if (kind == UICollectionElementKindSectionHeader) {
        cartCollectionViewHeadCell *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:cartCollectionViewHeadCellId forIndexPath:indexPath];
        headView.agencyDataGoods = _agencyDataGoods;
        return headView;
    }
    
    if (kind == UICollectionElementKindSectionFooter){
        cartCollectionViewFootCell *footView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:cartCollectionViewFootCellId forIndexPath:indexPath];
        
        //需要循环拿出 商品数量和计算总价
        for (int i = 0; i < adg.goods.count; i++) {
            zxb_cart_goods *goods = adg.goods[i];
            
            if ([goods.in_settlement isEqualToString:@"1"]) {
                goods_count_price += [goods.goods_count_price doubleValue];
                goods_number += [goods.goods_number intValue];
            }
        }
        
        NSLog(@" goods_count_price %f",goods_count_price);
        
        NSLog(@" goods_number %d",goods_number);
        
        footView.goodsNum = [NSString stringWithFormat:@"%d",goods_number];
        footView.totalPrice = [NSString stringWithFormat:@"%.2f",goods_count_price];
        
        //        footView.goodsNum = @"3";
        //        footView.totalPrice =@"600";
        return footView;
    }
    
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    return CGSizeMake(Width, 30);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    
    return CGSizeMake(Width, 30);
}

-(void)deleteCell:(cartCollectionViewGoodsCell *)cell{
    NSLog(@"deleteCell");
}

-(void)closeOtherCellLeftSwipe{
    for (cartGoodsCell *item in self.self.collectionView.visibleCells) {
        [item closeSwipe];
    }
}


@end
