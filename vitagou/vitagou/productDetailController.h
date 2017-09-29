//
//  productDetailController.h
//  vitagou
//
//  Created by Mac on 2017/7/26.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "product.h"
#import "ProductHeadView.h"
#import "ScrollerViewForProduct.h"
#import "zxb_photo.h"
#import "zxb_comment_data.h"

@interface productDetailContaroller : UIViewController

@property (nonatomic, copy) NSString *productId;

@property(nonatomic,strong) NSString * goods_id;



//@property(nonatomic, strong) UICollectionView *collectionView;

@property(nonatomic, strong) ProductHeadView *proView;

@property(nonatomic, strong) NSArray<zxb_photo *> *photoArray;

@property(nonatomic, strong) zxb_comment_data *commentData;
//更改标题
@property (nonatomic , copy) void(^changeTitleBlock)(BOOL isChange);

- (instancetype)initWithProductId:(NSString *)ProductId;


@end
