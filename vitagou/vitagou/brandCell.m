//
//  brandCell.m
//  vitagou
//
//  Created by Mac on 2017/7/6.
//  Copyright © 2017年 Vitagou. All rights reserved.
//
//这里面只有一个图片需要来展示，然后设置这个图片的点击事件，跳转到该品牌下的商品列表页
#import "brandCell.h"

@interface brandCell()



@end
/*
 1、initWithFrame只适用纯代码创建时调用，不涉及xib或storyboard。
 
 2、initWithCoder、awakeFromNib是从xib、storyboard中创建时会调用。
 
 3、所以一般来说，为了安全起见，初始化控件的代码我们写在一个方法里面（类似我上面的initViews方法），然后我们分别在initWithFrame和initWithCoder中都调用一下，这样就保证了无论你是通过什么方式创建的控件，代码都能起到作用。
 */
@implementation brandCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    self.backgroundColor = [UIColor whiteColor];
    
    _brandView = [[UIImageView alloc]init];
    
    [_brandView setImage:[UIImage imageNamed:@"place_holder"]];//默认图片
    
    
    [self addSubview:_brandView];
    
    //考虑是否给内边距
    [_brandView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(3);
        make.left.equalTo(self).offset(3);
        make.bottom.equalTo(self).offset(-3);
        make.right.equalTo(self).offset(-3);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click)];
    _brandView.userInteractionEnabled = YES;
    [_brandView addGestureRecognizer:tap];
    return self;
}
-(void)setBrand:(zxb_hot_brand *)brand{
    NSLog(@"brand.数据 %@",brand.logo);
    
[_brandView sd_setImageWithURL:[NSURL URLWithString:
    [VITAGOUURL stringByAppendingString:brand.logo]] placeholderImage:[UIImage imageNamed:@"place_holder"]];
    _bid = brand.brand_id;
}

-(void)click{
    NSLog(@"品牌点击");
    [AJNotification postNotificationName:BrandCategoryNotification object:_bid];
}

@end
