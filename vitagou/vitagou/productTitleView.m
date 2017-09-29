//
//  productTitleView.m
//  vitagou
//
//  Created by Mac on 2017/7/27.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import "productTitleView.h"
#import "productMainController.h"

@interface productTitleView ()

@property (nonatomic, weak) UIButton *selectedButton;//选中按钮

@end

@implementation productTitleView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        [self addButtons];
    //监听页面的滚动位置
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeSelectedButton:) name:SCCurrentPageDidChangeNotification object:nil];
        [self clickButton:self.subviews[0]];  //默认选中第0个
    }
    return self;
}



-(instancetype)init{
    
    CGFloat width = Width/3;
    CGFloat heght = 44;
    
    CGRect frame = CGRectMake(0, 0, width, heght);
    
    return [self initWithFrame:frame];
}

-(void)addButtons{
    
    [self addButtonWithTitle:@"商品" target:self action:@selector(clickButton:)];
    
    [self addButtonWithTitle:@"详情" target:self action:@selector(clickButton:)];
    
    
}

-(void)addButtonWithTitle:(NSString *)title
                   target:(id)target
                   action:(SEL)action{

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    
    [button setBackgroundImage:[UIImage imageNamed:@"bg_navi_button"] forState:UIControlStateSelected];
    button.adjustsImageWhenHighlighted = NO;
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    button.tag = self.subviews.count;
    
    [self addSubview:button];
    
}

- (void)layoutSubviews {
    NSUInteger count = self.subviews.count;
    CGFloat x = 0;
    CGFloat y = 0;
//    CGFloat width = self.frameWidth / count;
//    CGFloat height = self.frameHeight;
    
//    CGFloat width = Width / count;
    CGFloat width = 60;
    CGFloat height = 44;
    
    for (int i = 0; i < count; i++) {
        x = width * i;
        
        [self.subviews[i] setFrame:CGRectMake(x, y, width, height)];
    }
}

- (void)clickButton:(UIButton *)button {
    //取消原来的选中按钮
    _selectedButton.selected = NO;
    _selectedButton.titleLabel.font = [UIFont systemFontOfSize:13];   // 改变字体大小
    // 设置新的选中按钮
    button.selected = YES;
    _selectedButton = button;
    button.titleLabel.font = [UIFont systemFontOfSize:16];  // 改变字体大小
    
    if ([_delegate respondsToSelector:@selector(titleView:didClickButtonAtIndex:)]) {
        
        [_delegate titleView:self didClickButtonAtIndex:button.tag];
    }
}

@end
