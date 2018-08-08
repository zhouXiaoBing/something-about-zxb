
//
//  TextViewController.h
//  vitagou
//
//  Created by Mac on 2018/7/17.
//  Copyright © 2018年 vitagou. All rights reserved.
//

#import "NavUIBaseViewController.h"

@class TextViewController;

@protocol TextViewControllerDataSource <NSObject>

@optional

- (UIReturnKeyType)textViewControllerLastReturnKeyType:(TextViewController *)textViewController;

- (BOOL)textViewControllerEnableAutoToolbar:(TextViewController *)textViewController;

//  控制是否可以点击点击的按钮
- (NSArray <UIButton *> *)textViewControllerRelationButtons:(TextViewController *)textViewController;

@end

@protocol TextViewControllerDelegate<UITextViewDelegate,UITextFieldDelegate>

@optional

#pragma mark - 最后一个输入框点击键盘上的完成按钮时候的调用

- (void)textViewController:(TextViewController *)textViewController inputViewDone:(id)inputView;

@end

@interface TextViewController : NavUIBaseViewController<TextViewControllerDelegate,TextViewControllerDataSource>

- (BOOL)textFieldShouldClear:(UITextField *)textField NS_REQUIRES_SUPER;

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string NS_REQUIRES_SUPER;

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text NS_REQUIRES_SUPER;

- (BOOL)textViewShouldReturn:(UITextField *)textField NS_REQUIRES_SUPER;

@end


#pragma mark - design UITextField
IB_DESIGNABLE
@interface UITextField (TextViewController)

@property (assign, nonatomic) IBInspectable BOOL isEmptyAutoEnable;

@end

@interface TextViewControllerTextField : UITextField

@end





