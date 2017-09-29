//
//  secondClassify.h
//  vitagou
//
//  Created by Mac on 2017/8/7.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import "zxb_classify_two.h"
#import "zxb_classify_two_data.h"
#import "secondClassifyCell.h"
@interface secondClassify : UIViewController

@property(nonatomic, strong) NSString *CategoryId;

@property(nonatomic, strong) NSMutableArray *categoryArray;

@property(nonatomic,strong) UICollectionView *collectionView;

@property(nonatomic, strong) secondClassifyCell *classifyCell;

-(void)initWithCategoryId:(NSString *)CategoryId
                    initWithCategoryName:(NSString *)CategoryName;

@end
