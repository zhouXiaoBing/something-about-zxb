//
//  countDownView.h
//  vitagou
//
//  Created by Mac on 2017/6/14.
//  Copyright © 2017年 Vitagou. All rights reserved.
//
#import <UIKit/UIKit.h>




@interface countDownView : UIView

@property(nonatomic, strong) NSString *endTime;

-(instancetype)initWithEndTime:(NSString *)endTime;

@end
