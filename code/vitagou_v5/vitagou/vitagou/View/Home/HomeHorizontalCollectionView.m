
//
//  HomeHorizontalCollectionView.m
//  vitagou
//
//  Created by Mac on 2018/8/28.
//  Copyright © 2018年 vitagou. All rights reserved.
//

#import "HomeHorizontalCollectionView.h"
#import "HorizontalFlowLayout.h"
#import "HomeHorizontalGoodItem.h"
@interface HomeHorizontalCollectionView()<UICollectionViewDelegate,UICollectionViewDataSource,HomeHorizontalDataSource,HorizontalFlowLayoutDelegate>

@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) special_pic *special_a;

@end

@implementation HomeHorizontalCollectionView

static  NSString *specialGoodId = @"specialGoodId";

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"homeHorizontal_init");

        [self.collectionView registerClass:[HomeHorizontalGoodItem class] forCellWithReuseIdentifier:specialGoodId];
        
        UICollectionViewLayout *myLayout = [self collectionViewController:self
 layoutForColletionView:self.collectionView];
        self.collectionView.collectionViewLayout = myLayout;
        self.collectionView.backgroundColor = [UIColor whiteColor];
        self.collectionView.contentInset = UIEdgeInsetsZero;
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        
        [self addSubview:self.collectionView];

    }
    return self;
}

- (void)setSpecial:(special_pic *)special{

    _special_a = special;
    
}
#pragma mark - HomeHorizontalDataSource

- (UICollectionViewLayout *)collectionViewController:(HomeHorizontalCollectionView *)collectionViewController layoutForColletionView:(UICollectionView *)collectionView{
    HorizontalFlowLayout *layout = [[HorizontalFlowLayout alloc]initWithDelegate:self];//id 类型：horizontal
    
    return layout;
}

#pragma mark - horizontalFlowLayoutDelegate

- (CGFloat)waterflowLayout:(HorizontalFlowLayout *)waterflowLayout collectionView:(UICollectionView *)collectionView widthForItemAtIndexPath:(NSIndexPath *)indexPath itemHeight:(CGFloat)itemHeight{
    return itemHeight-40;
}

- (NSInteger)waterflowLayout:(HorizontalFlowLayout *)waterflowLayout linesInCollectionView:(UICollectionView *)collectionView{
    return 1; //只显示一排
}


#pragma mark - delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _special_a.item.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    HomeHorizontalGoodItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:specialGoodId forIndexPath:indexPath];
    cell.contentView.clipsToBounds = YES;
    
    cell.special = _special_a.item[indexPath.row];
    
    return cell;
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    special_pic_item *item = _special_a.item[indexPath.row];
    NSLog(@"shouldSelectItemAtIndexpath %@",item.goods_id);
    return YES;
}

#pragma mark - scrollDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    UIEdgeInsets contentInset = self.collectionView.contentInset;
    contentInset.bottom -= self.collectionView.mj_footer.height;
    self.collectionView.scrollIndicatorInsets = contentInset;
    [self endEditing:YES];
}

#pragma mark - getter
- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:[UICollectionViewLayout new]];
        _collectionView = collectionView;
        collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return _collectionView;
}

@end

