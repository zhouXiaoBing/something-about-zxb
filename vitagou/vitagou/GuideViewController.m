//
//  GuideViewController.m
//  vitagou
//
//  Created by Mac on 2017/6/28.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import "GuideViewController.h"
#import "GuideCell.h"

@interface GuideViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong) NSArray *guideImages;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UIPageControl *pageControl;
@end

static NSString *cellId = @"cellId";

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.guideImages = @[@"small_one",@"small_two",@"small_three",@"small_four"];
    [self setupCollectionView];
    [self setupPageControl];
    
}

- (void)setupCollectionView {
    self.collectionView = ({
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        layout.itemSize = [UIScreen mainScreen].bounds.size;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:layout];
        collectionView.pagingEnabled = YES;
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.bounces = NO;
        collectionView.showsHorizontalScrollIndicator = false;
        collectionView.showsVerticalScrollIndicator = false;
        collectionView;
    });
    [self.collectionView registerClass:[GuideCell class] forCellWithReuseIdentifier:cellId];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
- (void)setupPageControl {
    self.pageControl = [[UIPageControl alloc]init];
    self.pageControl.numberOfPages = self.guideImages.count;
    self.pageControl.currentPage = 0;
    [self.view addSubview:self.pageControl];
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.height.mas_equalTo(20);
        make.leading.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-50);
    }];
}

#pragma uicollectionview datasourse

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.guideImages.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GuideCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.image = [UIImage imageNamed:self.guideImages[indexPath.row]];
    if (indexPath.row == self.guideImages.count - 1) {
        [cell setNextButtonHidden:false];
    }else{
        [cell setNextButtonHidden:true];
    }
    return cell;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger index = (scrollView.contentOffset.x + self.view.frame.size.width * 0.5)/ self.view.frame.size.width;
    self.pageControl.currentPage = index;
}
@end
