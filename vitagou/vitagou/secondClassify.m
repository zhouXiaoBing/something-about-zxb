//
//  secondClassify.m
//  vitagou
//
//  Created by Mac on 2017/8/7.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import "secondClassify.h"
#import <Foundation/Foundation.h>

@interface secondClassify()<UICollectionViewDataSource,UICollectionViewDelegate>{
    
}

@end

@implementation secondClassify

static NSString  *secondCell = @"secondCell";

//调分类二级接口 设置主标题  判断是否出现重复加载数据的情况
-(void)initWithCategoryId:(NSString *)CategoryId initWithCategoryName:(NSString *)CategoryName{
    NSLog(@"initWithCategoryId %@",CategoryId);
    
[zxb_classify_two getClassifyTwoData:CategoryId
                                 success:
     ^(zxb_Result *result, NSMutableArray *data) {
         NSLog(@"NSMutableArray *data count %li",data.count );
         NSLog(@"NSMutableArray *result count %@",result.msg );
         _categoryArray = data;
         
         _collectionView.delegate = self;
         _collectionView.dataSource = self;
     } failure:
     
    ^(NSError *error) {
        
    }];
    
    [self buildCollectionView];
}

-(void)viewDidLoad{
    NSLog(@"viewDidLoad");
//    [self buildCollectionView];
}

-(void)buildCollectionView{
    NSLog(@"buildCollectionView");
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
    
    [self.collectionView registerClass:[secondClassifyCell class] forCellWithReuseIdentifier:secondCell];
    
    [self.view addSubview:self.collectionView];//将CollectionView添加到UIView
    //重要代码
    self.view.width = Width*3/4;
    //定位
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.edges.equalTo(self.view);
    }];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _categoryArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    secondClassifyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:secondCell forIndexPath:indexPath];
    cell.classify_two_data = self.categoryArray[indexPath.row];
    return  cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize itemSize = CGSizeZero;
NSLog(@"sizeForItemAtIndexPath");
    
    
    itemSize.width = Width*3/8;
    itemSize.height = Width*1/2+30;
    return itemSize;
}




@end
