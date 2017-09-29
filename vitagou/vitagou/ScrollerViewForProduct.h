//
//  ScrollerViewForProduct.h
//  vitagou
//
//  Created by Mac on 2017/7/18.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ScrollerViewForProduct : UIView

@property (nonatomic, copy) ClikedCallback clikeCall;

+ (instancetype)pageScroller:(NSArray <NSString *>*)images placeHolderImage:(UIImage *)placeHolderImage;



@end
