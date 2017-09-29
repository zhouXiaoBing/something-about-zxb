//
//  productTitleView.h
//  vitagou
//
//  Created by Mac on 2017/7/27.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import <UIKit/UIKit.h>

@class productTitleView;//@class是放在interface中的，只是为了在interface中引用这个类，把这个类作为一个类型来用的

@protocol productTitleViewDelegate  <NSObject>


@optional

- (void)titleView:(productTitleView *)titleView didClickButtonAtIndex:(NSUInteger)index;

@end

@interface productTitleView : UIView

@property (nonatomic, weak)  id <productTitleViewDelegate> delegate;

@end

