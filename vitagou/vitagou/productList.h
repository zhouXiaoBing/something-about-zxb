//
//  productList.h
//  vitagou
//
//  Created by Mac on 2017/8/15.
//  Copyright © 2017年 Vitagou. All rights reserved.
//


#import "productList.h"
#import "zxb_product_list.h"
#import "zxb_list_data.h"
@interface productList : UIViewController

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIView *productSort;

@property (nonatomic, strong) UIView *searchBar;

@property (nonatomic, strong) zxb_product_list *producctList;

@property(nonatomic, strong) NSMutableArray *listData;

-(instancetype)initWithCategoryOrBrandOrKeyword_id:(NSString *)CategoryOrBrandOrKeyword_id
label:(NSString *)label;

@end
