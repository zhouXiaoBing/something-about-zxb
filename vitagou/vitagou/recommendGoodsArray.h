//
//  recommendGoodsArray.h
//  vitagou
//
//  Created by Mac on 2017/6/12.
//  Copyright © 2017年 Vitagou. All rights reserved.
//NSMutableArray是动态数组，可以任意的添加和删除数据  NSArray是静态的一旦确定就不能更改

#import <UIKit/UIKit.h>
#import "zxb_home_data.h"
@interface recommendGoodsArray : UIView

@property (nonatomic,strong) zxb_home_data* data;
                    
@end



