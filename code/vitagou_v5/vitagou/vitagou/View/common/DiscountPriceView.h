//
//  DiscountPriceView.h
//  vitagou
//
//  Created by Mac on 2018/8/21.
//  Copyright © 2018年 vitagou. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface DiscountPriceView : UIView

//@property (strong,nonatomic) NSString *sellPrice;
//
//@property (strong,nonatomic) NSString *marketPrice;

- (void)sell_market_Price:(NSString *)sellPrice
                      marketPrice:(NSString *)marketPrice;

@end
