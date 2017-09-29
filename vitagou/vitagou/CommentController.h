//
//  CommentController.h
//  vitagou
//
//  Created by Mac on 2017/9/22.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentController : UIViewController

@property(nonatomic,strong) NSString * goods_id;

@property (nonatomic , copy) void(^changeTitleBlock)(BOOL isChange);

- (instancetype)initWithProductId:(NSString *)ProductId;

@end
