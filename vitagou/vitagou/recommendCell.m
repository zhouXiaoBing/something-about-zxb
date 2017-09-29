//
//  recommendCell.m
//  vitagou
//
//  Created by Mac on 2017/6/8.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import "recommendCell.h"
#import "UIView+ArrangeSubview.h"
#import "recommendgood.h"
#import "recommendGoodsArray.h"
#import "countDownView.h"


@interface recommendCell ()
@property (strong, nonatomic)  recommendgood *goodsView;
@property (strong, nonatomic)  recommendgood *goodsView_;
@property (strong, nonatomic)  UILabel *recommedTitle;
@property (strong, nonatomic)  recommendGoodsArray* recommendArray;
@property (strong, nonatomic)  countDownView *countdownview;
@property (nonatomic, strong)  UIView *lineView;
@property (nonatomic, strong)  UIView *lineView_;

@end

@implementation recommendCell

- (instancetype)initWithFrame:(CGRect)frame//几个组件的相对位置
{

    
    if (self = [super initWithFrame:frame]) {

        self.backgroundColor = [UIColor whiteColor];
        self.width=Width;
        self.height = Width*2/3+65;//85是“每周特卖”+倒计时的高度加余量
        _recommedTitle = [[UILabel alloc]init];
        _recommedTitle.text = @"每周特卖";
        _recommedTitle.font = [UIFont systemFontOfSize:15];
        _recommedTitle.textColor = [UIColor colorWithRed:150/255.0 green:150/255.0  blue:150/255.0  alpha:1.0];

        _countdownview = [[countDownView alloc]init];
        
        
        _goodsView = [[recommendgood alloc]init];
        _goodsView_ = [[recommendgood alloc]init];
        
        self.backgroundColor = [UIColor whiteColor];
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
        _lineView_ = [[UIView alloc]init];
        _lineView_.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
        [self addSubview:_lineView_];
        [self addSubview:_lineView];
        [self addSubview:_recommedTitle];
        [self addSubview:_countdownview];
        [self addSubview:_goodsView];
        [self addSubview:_goodsView_];


        [_recommedTitle mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(self.mas_top).offset(5);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(25);
            make.centerX.equalTo(_recommedTitle.mas_centerX);
            make.centerX.equalTo(self.mas_centerX);
        }];
        [_countdownview mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_recommedTitle.mas_bottom).offset(5);
            make.centerX.equalTo(self.mas_centerX);
            make.width.mas_equalTo(160);//这里的高度不确定也会导致未知的额不准确
            make.height.mas_equalTo(40);
        }];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_countdownview.mas_bottom).offset(5);
            make.height.mas_equalTo(5);
            make.width.mas_equalTo(Width);
        }];
        [_goodsView mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_lineView.mas_bottom);
            make.height.mas_equalTo(Width/3);
            make.width.mas_equalTo(Width);
        }];
        [_lineView_ mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_goodsView.mas_bottom);
            make.height.mas_equalTo(5);
            make.width.mas_equalTo(Width);
        }];
        [_goodsView_ mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_lineView_.mas_bottom);
            make.height.mas_equalTo(Width/3);
            make.width.mas_equalTo(Width);
        }];
         }
    return self;
}

-(void)setData:(zxb_home_data *)data{
    //传递当前时间
//    _countdownview = [[countDownView alloc]init];
    _countdownview.endTime = data.end_time;
//_countdownview.initW
    
    NSLog(@"endTime %@",data.end_time);
    for (int i =0; i < 2; i++) {
                if (i == 0) {
            _goodsView.goods = data.promotion[0];
        }else if (i == 1){
            _goodsView_.goods = data.promotion[1];
        }
    }
    
    
}

-(void)dealloc{
    NSLog(@"%s dealloc",object_getClassName(self));
}

- (void)didReceiveMemoryWarning {
    
}



@end
   

