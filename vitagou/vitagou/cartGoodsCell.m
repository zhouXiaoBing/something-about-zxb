//
//  cartGoodsCell.m
//  vitagou
//
//  Created by Mac on 2017/9/8.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cartGoodsCell.h"
#import "disCountPriceViewUpToDown.h"
#import "PPNumberButton.h"

@interface cartGoodsCell ()<PPNumberButtonDelegate>

@property (nonatomic, strong) UIButton *selectedBtn;

@property (nonatomic, assign) BOOL *isSeclted;

@property (nonatomic, strong) UIImageView *productImageView;

@property (nonatomic, strong) UILabel *productName;

@property (nonatomic, strong) disCountPriceViewUpToDown *productPrice;

@property (nonatomic, strong) PPNumberButton *NumEditButton;

@property (nonatomic, weak) UIButton *deleBtn;

@property (nonatomic, weak) UIView *containerView;

@property (nonatomic, strong) UIView *underView;

@property (nonatomic, assign) BOOL isOpenLeft;
@end



@implementation cartGoodsCell




//+(instancetype)cellWithTableView:(UITableView *)tableview{
//    static NSString *ID = @"cell";
//    cartGoodsCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
//    if (!cell) {
//        cell = [[cartGoodsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
//    }
//    return cell;
//}

//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
//    
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
//        [self createUI];
//    }
//    
//    return self;
//}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}


-(void)createUI{
    
    UIView *containerView = [[UIView alloc]init];
    [self addSubview:containerView];
    _containerView = containerView;
    _containerView.size = CGSizeMake(Width, Width/3);
    _containerView.backgroundColor = [UIColor whiteColor];
    
    
    self.backgroundColor = [UIColor whiteColor];
    _selectedBtn = [[UIButton alloc]init];
//    _selectedBtn.selected = YES;
    [_selectedBtn setImage:[UIImage imageNamed:@"check_none"] forState:UIControlStateNormal];
    [_selectedBtn setImage:[UIImage imageNamed:@"check_on"] forState:UIControlStateSelected];
//    [_selectedBtn addTarget:self action:@selector(shoppingSelectedClick:) forControlEvents:UIControlEventTouchUpOutside|UIControlEventTouchUpInside|UIControlEventTouchCancel];
        [_selectedBtn addTarget:self action:@selector(shoppingSelectedClick:) forControlEvents:UIControlEventTouchUpInside];
//    [_selectedBtn s]

    _productImageView = [[UIImageView alloc]init];
    
    _productName = [[UILabel alloc]init];
    _productName.font = [UIFont systemFontOfSize:12];
    _productName.textColor = [UIColor blackColor];
    [_productName setNumberOfLines:0];
    _productName.lineBreakMode = NSLineBreakByWordWrapping;
    
    _productPrice = [[disCountPriceViewUpToDown alloc]init];
    
    _NumEditButton = [[PPNumberButton alloc]init];
//    _NumEditButton.size = CGSizeMake(100, 30);
    // 开启抖动动画
   _NumEditButton.shakeAnimation = YES;
    // 设置最小值
    _NumEditButton.minValue = 1;
    // 设置最大值
   _NumEditButton.maxValue = 100;
    _NumEditButton.borderColor = [UIColor grayColor];
    // 设置输入框中的字体大小
    _NumEditButton.inputFieldFont = 13;
    _NumEditButton.increaseTitle = @"＋";
    _NumEditButton.decreaseTitle = @"－";
//    _NumEditButton.currentNumber = 1;
    _NumEditButton.delegate = self;
    _NumEditButton.longPressSpaceTime = CGFLOAT_MAX;
    
    _NumEditButton.resultBlock = ^(NSInteger num ,BOOL increaseStatus){
        NSLog(@"%ld",num);
    };

    _underView = [[UIView alloc]init];
    _underView.backgroundColor = [UIColor grayColor];
    
    [_containerView addSubview:_productImageView];
    [_containerView addSubview:_selectedBtn];
    [_containerView addSubview:_productName];
    [_containerView addSubview:_productPrice];
    [_containerView addSubview:_NumEditButton];
    [_containerView addSubview:_underView];//分割线
    
    [_selectedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_containerView).offset(10);
        make.centerY.mas_equalTo(_containerView);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(20);
    }];
    
    [_productImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_containerView).offset(40);
        make.width.mas_equalTo(Width/3);
        make.height.mas_equalTo(Width/3-1);
    }];
    
    [_productName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_containerView).offset(Width/3+50);
        make.top.mas_equalTo(_containerView).offset(5);
        make.height.mas_equalTo(Width/6-5);
        make.width.mas_equalTo(Width*2/3-50);
    }];
    [_productPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_containerView).offset(Width/3+50);
        make.bottom.mas_equalTo(_containerView).offset(-5);
        make.width.mas_equalTo(Width/6-25);
        make.height.mas_equalTo(Width/6-5);
    }];
    
    [_NumEditButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_containerView).offset(-10);
        make.bottom.mas_equalTo(_containerView).offset(-13);
        make.width.mas_equalTo(Width/3-20);
        make.height.mas_equalTo(20);
    }];              
    
[_underView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.width.mas_equalTo(Width);
make.height.mas_equalTo(0.5);
        make.leading.mas_equalTo(_containerView);
        make.bottom.mas_equalTo(_containerView).offset(-0.5);
    }];
    
    
    //_________________左滑出来的界面
    UIButton *deleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:deleBtn];
    self.deleBtn = deleBtn;
    deleBtn.backgroundColor = [UIColor redColor];
    [deleBtn setTitle:@"删除" forState:UIControlStateNormal];
    [deleBtn setTintColor:[UIColor blackColor]];
    [deleBtn addTarget:self action:@selector(deleteCell:) forControlEvents:UIControlEventTouchUpInside];

    //手势
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe:)];
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;//左滑
    [_containerView addGestureRecognizer:leftSwipe];
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe:)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [_containerView addGestureRecognizer:rightSwipe];
//    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    [self.contentView bringSubviewToFront:_containerView];//设置容器显示在最上层
    
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isKindOfClass:[UITextField class]])
    {
        return NO;
    }
    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
    if ([NSStringFromClass([touch.view class]) isEqualToString:@""]) {
        return NO;
    }
    return YES;
}

-(void)layoutSubviews{
    _containerView.frame =self.contentView.bounds;
    _deleBtn.frame = CGRectMake(Width*2/3, 0, Width/3, Width/3);
   // _underView.frame = CGRectMake(15, 59, self.frame.size.width - 15, 1);
}

- (void)deleteCell:(UIButton *)btn{
    
    if ([self.delegate respondsToSelector:@selector(deleteCell:)]) {
        [self.delegate deleteCell:self];
    }
    NSLog(@"cartGoodsCell————delete");
    
    [AJNotification postNotificationName:GoodsDelNotification object:self.goods_id];
}

- (void)swipe:(UISwipeGestureRecognizer*)swipe{
    NSLog(@"frame-before rect:%@", NSStringFromCGRect(self.containerView.frame));
    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft){
        
        if (self.isOpenLeft) return; //已经打开左滑，不再执行
        //开始左滑： 先调用代理关闭其他cell的左滑
        if ([self.delegate respondsToSelector:@selector(closeOtherCellLeftSwipe)])
            
            [self.delegate closeOtherCellLeftSwipe];
    
        [UIView animateWithDuration:0.5 animations:^{
            NSLog(@"animations-done");
                        swipe.view.center = CGPointMake(0, self.frame.size.height/2);
            self.containerView.frame=CGRectMake(-Width/3, 0, Width, Width/3);
        }];
        NSLog(@"frame-after rect:%@", NSStringFromCGRect(self.containerView.frame));
        self.isOpenLeft = YES;
        
    }
    else if (swipe.direction == UISwipeGestureRecognizerDirectionRight){
        
        [self closeSwipe]; //关闭左滑
    }
}

-(void)closeSwipe{
    if (!self.isOpenLeft) return; //还未打开左滑，不需要执行右滑
    
    [UIView animateWithDuration:0.5 animations:^{
        _containerView.center = CGPointMake(self.frame.size.width/2 , self.frame.size.height/2 );
    }];
    self.isOpenLeft = NO;
}

- (void)pp_numberButton:(__kindof UIView *)numberButton number:(NSInteger)number increaseStatus:(BOOL)increaseStatus
{
    NSLog(@"%@",increaseStatus ? @"加运算":@"减运算");
    NSLog(@"当前的商品数量 %ld",(long)number);
    NSDictionary *dic = [NSDictionary new];
    NSString *editNum = [NSString stringWithFormat:@"%ld",number];
    dic = [NSDictionary dictionaryWithObjectsAndKeys:
           editNum,@"editNum",self.goods_id,@"goods_id", nil];
//    [AJNotification postNotificationName:GoodsNumEditNotification object:nil];
    [AJNotification postNotificationName:GoodsNumEditNotification object:nil userInfo:dic];
//    NSLog(@"值 %@",dic);
//    NSLog(@"值 %@",[dic objectForKey:@"editNum"]);
}

//发被选择的通知 Bad receiver type 'NSInteger'(aka 'long')
- (void)shoppingSelectedClick:(UIButton *)btn{
    if (btn.selected) {
        btn.selected = NO;
        NSLog(@"btn.selected = NO");
        [AJNotification postNotificationName:GoodsBeChoosedNotNotification object:self.goods_id ];
    }else{
        NSLog(@"btn.selected = YES");
        btn.selected = YES;
        [AJNotification postNotificationName:GoodsBeChoosedNotification object:self.goods_id];
    }
    
//    [self.contentView bringSubviewToFront:_containerView];//布局的层级关系
    
//    NSLog(@"frame rect:%@", NSStringFromCGRect(self.containerView.frame));
    
}


-(void)setGoods:(zxb_cart_goods *)goods{
     NSLog(@"setGoods");
     [_productImageView sd_setImageWithURL:[NSURL URLWithString:[VITAGOUURL stringByAppendingString:goods.img]] placeholderImage:[UIImage imageNamed:@"place_holder"]];
    _productName.text = goods.goods_name;
    
    _productPrice.cartGoods = goods;
    
    _NumEditButton.currentNumber = [goods.goods_number intValue];
    
    if ([goods.in_settlement isEqualToString:@"0"]) {
        _selectedBtn.selected = NO;
    }else {
        _selectedBtn.selected = YES;
    }
    
    self.goods_id = goods.goods_id;
    self.goods_num = goods.goods_number;
    self.agency_id = goods.agency_id;
    self.seller_id = goods.seller_id;
    
}



@end
