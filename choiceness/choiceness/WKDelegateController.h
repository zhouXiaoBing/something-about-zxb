//
//  WKDelegateController.h
//  vitagou
//
//  Created by 周小兵 on 2017/11/28.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
@protocol WKDelegate <NSObject>

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message;

@end

@interface WKDelegateController : UIViewController <WKScriptMessageHandler>

@property (weak , nonatomic) id<WKDelegate> delegate;

@end
