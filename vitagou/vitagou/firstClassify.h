
//
//  firstClassify.h
//  vitagou
//
//  Created by Mac on 2017/8/7.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import "secondClassify.h"
#import "zxb_classify.h"
#import "zxb_classify_data.h"
#import "fisrtClassifyCell.h"
#import "secondClassifyCell.h"

@interface firstClassify : UIViewController

//-(void)didTableView:(UICollectionView *)tableView clickIndexPath:(NSIndexPath *)indexPath;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (strong , nonatomic)UITableView *tableView;

@property (nonatomic, strong) secondClassify *secondVc;

@property (nonatomic, strong) zxb_classify *classify;

@property (nonatomic, strong) zxb_classify_data *classify_data;

@property (nonatomic, strong) NSString *Category_id; //用来判断进入的事件是全部分类还是品牌  用yes 和 no 来标识 后面判断时转为bool

-(instancetype)initWithCategoryId:(NSString *)CategoryId;

@end
