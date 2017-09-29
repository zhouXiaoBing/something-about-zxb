//
//  ScrollerPageView.h
//  vitagou
//
//  Created by Mac on 2017/4/13.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ScrollerPageView : UIView

@property (nonatomic, copy) ClikedCallback clikeCall;

+ (instancetype)pageScroller:(NSArray <NSString *>*)images placeHolderImage:(UIImage *)placeHolderImage;

@end
