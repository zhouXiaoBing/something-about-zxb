//
//  CommentController.m
//  vitagou
//
//  Created by Mac on 2017/9/22.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import "CommentController.h"
#import "zxb_goods_comment.h"
#import "goods_comment_data.h"
#import "goods_comment_data_content.h"
#import "DCCommentPicCell.h"
#import "DCCommentContentCell.h"
#import "DCCommentContentCellWithoutPic.h"

@interface CommentController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong) goods_comment_data *goods_comment;

@property(nonatomic,strong) DCCommentContentCell *contentCell;

@property(nonatomic,strong) DCCommentContentCellWithoutPic *contentCellWithoutPic;

@property(nonatomic,strong) UICollectionView *collectionView;

@end

static NSString *DCCommentContentCellID = @"DCCommentContentCellID";

static NSString *DCCommentContentCellWithoutPicID = @"DCCommentContentCellWithoutPicID";

@implementation CommentController

-(instancetype)initWithProductId:(NSString *)ProductId{
    self = [super init];
    if (self) {
        NSLog(@"commentController init");
        _goods_id = ProductId;
        NSLog(@"_goods_id %@",_goods_id);
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
     [self buildcollectionView];
    [self getCommentData];
   
}

-(void)buildcollectionView{
    NSLog(@"CommentController_colletionView");
    if (!_collectionView) {
        if (!_collectionView) {
            UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
            layout.minimumLineSpacing = 0; //Y
            layout.minimumInteritemSpacing = 0; //X
            _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
            _collectionView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
            [self.view addSubview:_collectionView];
        }
//        _collectionView.delegate = self;
//        _collectionView.dataSource = self;
        
        [_collectionView registerClass:[DCCommentContentCell class] forCellWithReuseIdentifier:DCCommentContentCellID];
        
        [_collectionView registerClass:[DCCommentContentCellWithoutPic class] forCellWithReuseIdentifier:DCCommentContentCellWithoutPicID];
        
    }
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.edges.equalTo(self.view);
    }];
    
//    return  _collectionView;
}

-(void)getCommentData{
     NSLog(@"CommentController_getCommentData");
    [zxb_goods_comment getGoodsComment:_goods_id
                                  type:@"2"//好像给1或者2 都没有影响
                               success:^(zxb_Result *result, goods_comment_data *data) {
                                   _goods_comment = data;
                                   NSLog(@"_goods_comment.count %lu",_goods_comment.content.count);
                                   
                                   _collectionView.delegate = self;
                                   _collectionView.dataSource = self;
                                   
                                 } failure:^(NSError *error) {
                                      
                                  }];
}


- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    NSLog(@"numberOfSectionsInCollectionView");
    return 1;
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSLog(@"numberOfItemsInSection");
    return _goods_comment.content.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"cellForItemAtIndexPath");
  UICollectionViewCell *gridcell = nil;
    goods_comment_data_content  *content = _goods_comment.content[indexPath.row];
//    NSLog(@"cellForItemAtIndexPath_something %@",content.username);
    if (content.images.count == 0) {//无图评价
        DCCommentContentCellWithoutPic *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCCommentContentCellWithoutPicID forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        cell.content = content;
        gridcell = cell;

    }else{
        //有图评价
        DCCommentContentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCCommentContentCellID forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        cell.content = content;
        gridcell = cell;
    }
    
    return gridcell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"sizeForItemAtIndexPath");
    goods_comment_data_content  *content = _goods_comment.content[indexPath.row];
    
    return (content.images.count == 0)?CGSizeMake(Width, 150):CGSizeMake(Width, 250);
//    return CGSizeMake(Width, 250);

}


































@end
