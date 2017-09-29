//
//  DCCommentContentCell.m
//  CDDMall
//
//  Created by apple on 2017/6/27.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

//200
#import "DCCommentContentCell.h"

// Controllers

// Models
#import "DCCommentPicItem.h"
// Views
#import "DCCommentPicCell.h"
#import "DCPartCommentHeadView.h"
// Vendors

#import <MJExtension.h>
// Categories

// Others
#import "zxb_comment_images.h"

@interface DCCommentContentCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
//@interface DCCommentContentCell ()
/* collectionView */
@property (strong , nonatomic)UICollectionView *collectionView;
@property (strong , nonatomic)DCPartCommentHeadView *headView;
@property (strong , nonatomic)UIView *line;

/* 图片数组 */
@property (strong , nonatomic)NSMutableArray<NSString *> *picItem;
@end

static NSString *const DCCommentPicCellID = @"DCCommentPicCell";

@implementation DCCommentContentCell

#pragma mark - LoadLazy
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.minimumLineSpacing = layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.showsHorizontalScrollIndicator = YES;
        
        //注册
        [_collectionView registerClass:[DCCommentPicCell class] forCellWithReuseIdentifier:DCCommentPicCellID];
        [self addSubview:_collectionView];
    }
    return _collectionView;
}

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{
    self.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = self.backgroundColor;

    _userName = [[UILabel alloc]init];
    _userName.font = [UIFont systemFontOfSize:12];
    _userName.textColor = [UIColor blackColor];
    
    _productCommentContent = [[UILabel alloc]init];
    _productCommentContent.font = [UIFont systemFontOfSize:13];
    _productCommentContent.textColor = [UIColor blackColor];
    [_productCommentContent setNumberOfLines:0];
    _productCommentContent.lineBreakMode = NSLineBreakByWordWrapping;
    
    _productCommentTopic = [[UILabel alloc]init];
    _productCommentTopic.font = [UIFont systemFontOfSize:13];
    _productCommentTopic.textColor = [UIColor blackColor];
    _productCommentTopic.text = @"评价:";

    CGFloat barWidth = 200;
    CGFloat x = 20;
    _productRatingBar = [[RatingBar alloc]initWithFrame:CGRectMake(x, 100, barWidth, 50)];
    _productRatingBar.isIndicator = NO;
    
    [_productRatingBar setImageDeselected:@"iconfont-xingunselected" halfSelected:@"iconfont-banxing" fullSelected:@"iconfont-xing" andDelegate:nil];
    
    _productCommentDate = [[UILabel alloc]init];
    _productCommentDate.font = [UIFont systemFontOfSize:13];
    _productCommentDate.textColor = [UIColor blackColor];
    
    _line = [[UIView alloc]init];
    _line.backgroundColor = [UIColor grayColor];
    
    [self addSubview:_userName];
    [self addSubview:_productCommentContent];
    [self addSubview:_productCommentTopic];
    [self addSubview:_productRatingBar];
    [self addSubview:_productCommentDate];
    [self addSubview:_line];
    
    
    
//    _picItem = [DCCommentPicItem mj_objectArrayWithFilename:@"CommentPic.plist"];
    
//    [self setUpCommentCell];
}

- (void)setUpCommentCell
{
    _headView = [[DCPartCommentHeadView alloc] init];
    _headView.picNum = @"12";
    [self addSubview:_headView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
//    
//    [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(self);
//        make.left.mas_equalTo(self);
//        make.top.mas_equalTo(self);
//        make.height.mas_equalTo(100);
//    }];
//
//    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//        [make.top.mas_equalTo(self)setOffset:100];
//        make.left.mas_equalTo(self);
//        make.width.mas_equalTo(self);
//        make.height.mas_equalTo(100);
//    }];
    //width: 1/2
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(Width);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(self);
    }];
    
    [_userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self).offset(10);
//        make.width.mas_equalTo(Width/2);
        make.height.mas_equalTo(Width/12);
    }];
    
    [_productCommentContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_userName.mas_bottom);
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.width.mas_equalTo(Width-20);
        make.height.mas_equalTo(Width/6);
    }];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_productCommentContent.mas_bottom);
        make.width.mas_equalTo(Width);
        make.height.mas_equalTo(Width/3);
    }];
    
    
    [_productCommentTopic mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_productCommentContent.mas_bottom);
        make.bottom.equalTo(_productCommentDate.mas_top);
        make.left.equalTo(self).offset(10);
        //        make.width.mas_equalTo(Width/2);
        make.centerY.equalTo(_productCommentTopic.mas_centerY);
        make.height.mas_equalTo(Width/12);
    }];
    
    [_productRatingBar mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_productCommentContent.mas_bottom);
        make.bottom.equalTo(_productCommentDate.mas_top);
        make.left.equalTo(_productCommentTopic.mas_right).offset(10);
        //        make.width.mas_equalTo(Width/2);
        make.height.mas_equalTo(Width/12);
    }];
    
    [_productCommentDate mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_productRatingBar.mas_bottom);
        make.bottom.equalTo(self);
        make.left.equalTo(self).offset(10);
        make.width.mas_equalTo(Width/2);
        make.height.mas_equalTo(Width/12);
    }];
}

-(void)setCommentData:(zxb_comment_data *)commentData{
    _userName.text = commentData.username;
    _productCommentContent.text = commentData.contents;
    _productCommentTopic.text = @"评分:";
    _productCommentDate.text = commentData.comment_time;
    _productRatingBar.isIndicator = YES;
    [_productRatingBar displayRating:[commentData.point floatValue]];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _picItem = [NSMutableArray array];
    [commentData.images enumerateObjectsUsingBlock:^(zxb_comment_images *obj,NSUInteger idx,BOOL * _Nonnull stop)
     {
         [_picItem addObject:obj.img];
     }];
}

-(void)setContent:(goods_comment_data_content *)content{
    _userName.text = content.username;
    _productCommentContent.text = content.contents;
    _productCommentTopic.text = @"评分:";
    _productCommentDate.text = content.comment_time;
    _productRatingBar.isIndicator = YES;
    [_productRatingBar displayRating:[content.point floatValue]];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _picItem = [NSMutableArray array];
    [content.images enumerateObjectsUsingBlock:^(zxb_comment_images *obj,NSUInteger idx,BOOL * _Nonnull stop)
     {
         [_picItem addObject:obj.img];
     }];
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
//    NSLog(@"_picItem.count %lu",_picItem.count);
    return _picItem.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    DCCommentPicCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCCommentPicCellID forIndexPath:indexPath];
    cell.img = _picItem[indexPath.row];
    return cell;
}


#pragma mark - <UICollectionViewDelegate>
#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    return CGSizeMake(100, 100);

}


@end
