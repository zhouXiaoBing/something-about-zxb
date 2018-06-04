
//
//  TwoRootVC.m
//  collectionIos
//
//  Created by Mac on 2017/12/28.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import "TwoRootVC.h"

@interface TwoRootVC()

@property(nonatomic,strong) UIView *testView;

@end

@implementation TwoRootVC

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.title = @"TwoRootVC";
    _testView = [[UIView alloc]initWithFrame:self.view.bounds];
    _testView.backgroundColor = [UIColor greenColor];
}

@end
