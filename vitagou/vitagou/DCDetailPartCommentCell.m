
//  DCDetailPartCommentCell.m
//  CDDMall
//
//  Created by apple on 2017/6/21.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCDetailPartCommentCell.h"

#import "DCCommentContentCellWithoutPic.h"

// Controllers

// Models

// Views
#import "DCCommentHeaderCell.h"
#import "DCCommentFooterCell.h"
#import "DCCommentContentCell.h"

// Vendors

// Categories

// Others

@interface DCDetailPartCommentCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

/* collectionView */
@property (strong , nonatomic)UICollectionView *collectionView;

@property (strong , nonatomic)DCLIRLButton *commentFootButton;

@end//DCCommentContentCellWithoutPic

static NSString *const DCCommentHeaderCellID = @"DCCommentHeaderCell";
static NSString *const DCCommentFooterCellID = @"DCCommentFooterCell";
static NSString *const DCCommentContentCellID = @"DCCommentContentCell";
static NSString *const DCCommentContentCellWithoutPicID = @"DCCommentContentCellWithoutPic";
static NSString *const DCLIRLButtonId = @"DCLIRLButton";

@implementation DCDetailPartCommentCell

#pragma mark - LoadLazy
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.minimumLineSpacing = layout.minimumInteritemSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        //注册
        [_collectionView registerClass:[DCCommentHeaderCell class] forCellWithReuseIdentifier:DCCommentHeaderCellID];
        [_collectionView registerClass:[DCCommentFooterCell class] forCellWithReuseIdentifier:DCCommentFooterCellID];
        [_collectionView registerClass:[DCCommentContentCell class] forCellWithReuseIdentifier:DCCommentContentCellID];
        [_collectionView registerClass:[DCCommentContentCellWithoutPic class]  forCellWithReuseIdentifier:DCCommentContentCellWithoutPicID];
        
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

-(void)setCommentData:(zxb_comment_data *)CommentData{
    
    _CommentData = CommentData;
}
- (void)setUpUI
{
    self.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = self.backgroundColor;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}


#pragma mark - <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return (section == 0 || section == 1) ? 1 : 1;
//    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *gridcell = nil;
    if (indexPath.section == 0) {//头部
        DCCommentHeaderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCCommentHeaderCellID forIndexPath:indexPath];
        cell.comNum = @"100";
        cell.wellPer = @"100%";
        gridcell = cell;
    }else if (indexPath.section == 1){//中间
        
        //存在有图和无图的情况，最好的方式是，用有图和无图的cell，根据图片的数组的count判断
        if (_CommentData.images.count == 0) {
            DCCommentContentCellWithoutPic *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCCommentContentCellWithoutPicID forIndexPath:indexPath];
            cell.backgroundColor = [UIColor whiteColor];
            cell.commentData = _CommentData;
            gridcell = cell;
        }else{
        DCCommentContentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCCommentContentCellID forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        cell.commentData = _CommentData;
        gridcell = cell;
        }
    }else if (indexPath.section == 2){ //底部 换成查看全部评论的button 跳转到评论页
        DCCommentFooterCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCCommentFooterCellID forIndexPath:indexPath];

        NSArray *titles = @[@"查看全部评论"];

        [cell.commentFootButton setTitle:titles[indexPath.row] forState:UIControlStateNormal];
        
        

        gridcell = cell;
    }
    return gridcell;
}


#pragma mark - <UICollectionViewDelegate>
#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return (indexPath.section == 0) ? CGSizeMake(Width, 30)  : (indexPath.section == 1) ? (_CommentData.images.count == 0)?CGSizeMake(Width , 150):CGSizeMake(Width , 250)  : CGSizeMake(Width, 40);
}
/*

 */

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        [[NSNotificationCenter defaultCenter]postNotificationName:@"scrollToCommentsPage" object:nil];
    });
}

#pragma mark - Setter Getter Methods


@end
