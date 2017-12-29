//
//  OneRootVC.m
//  collectionIos
//
//  Created by Mac on 2017/12/28.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import "OneRootVC.h"

@interface OneRootVC()

@property(nonatomic,strong) UIView *testView;

@end

@implementation OneRootVC

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.title = @"OneRootVC";
    _testView = [[UIView alloc]initWithFrame:self.view.bounds];
    _testView.backgroundColor = [UIColor greenColor];
}

@end
