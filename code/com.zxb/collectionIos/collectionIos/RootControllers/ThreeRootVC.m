//
//  ThreeRootVC.m
//  collectionIos
//
//  Created by Mac on 2017/12/28.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import "ThreeRootVC.h"

@interface ThreeRootVC()

@property(nonatomic,strong) UIView *testView;

@end

@implementation ThreeRootVC

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.title = @"ThreeRootVC";
    _testView = [[UIView alloc]initWithFrame:self.view.bounds];
    _testView.backgroundColor = [UIColor greenColor];
}

@end

