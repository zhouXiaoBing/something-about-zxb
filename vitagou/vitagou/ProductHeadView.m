//
//  ProductHeadView.m
//  vitagou
//
//  Created by Mac on 2017/7/18.
//  Copyright © 2017年 Vitagou. All rights reserved.
//

#import "ProductHeadView.h"

@interface ProductHeadView ()<UIWebViewDelegate>



@end

@implementation ProductHeadView
NSString *goods_id;
CGFloat *documentHeight;

-(instancetype)initWithData:(zxb_product_data *)productData{
    
    self = [super init];
    if (!self) {
        return nil;
    }
    
    
    goods_id = productData.id;
    NSMutableArray *proImages = [NSMutableArray array];
    
    [productData.photo enumerateObjectsUsingBlock:^(zxb_photo* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [proImages addObject:[VITAGOUURL stringByAppendingString:obj.img]];
    }];
    
    _scrollerViewForPro = [ScrollerViewForProduct pageScroller:proImages
                                              placeHolderImage:
                           [UIImage imageNamed:@"palce_holder"]];
    
    _proDes = [[productDes alloc]init];
    
    
    _productComment = [[productComment alloc]init];
    
//    _productDetailWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, Width, Height-64)];
    
    
    [self setProData:productData];//在这里调用是因为开始没有在上个页面给Data数据。
    
    
    
    _lineView = [[UIView alloc]init];
    _lineView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
    
    
    
    
    [self addSubview:_scrollerViewForPro];
    [self addSubview:_proDes];
    [self addSubview:_lineView];
    [self addSubview:_productComment];
//    [self addSubview:_productDetailWebView];
    
    
    
    
    [_scrollerViewForPro layoutIfNeeded];
    [_proDes layoutIfNeeded];
    
    [_scrollerViewForPro mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.height.mas_equalTo(Width);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_scrollerViewForPro.mas_bottom);
        make.height.mas_equalTo(5);
        make.width.mas_equalTo(Width);
    }];
    
    [_proDes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_scrollerViewForPro.mas_bottom);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.height.mas_equalTo(Width*3/4);
    }];
    
    [_productComment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_proDes.mas_bottom);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.height.mas_equalTo(Width*3/4);
    }];
    
    [_productDetailWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_productComment.mas_bottom);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.height.mas_equalTo(Width*3);
    }];
    
//    NSString *str = @"http://www.vitagou.hk/site/products1/id/";
//    NSString *url = [str stringByAppendingString:@"579"];
//    NSLog(@"goods_id  url %@",url);
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
//    [_productDetailWebView loadRequest:request];
    
    return self;
}

/*
 1、- (void)webViewDidStartLoad:(UIWebView *)webView;开始加载的时候执行该方法。
 2、- (void)webViewDidFinishLoad:(UIWebView *)webView;加载完成的时候执行该方法。
 3、- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error;加载出错的时候执行该方法。
 */
-(void)webViewDidStartLoad:(UIWebView *)webView{
//NSLog(@"webViewDidStartLoad!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
//    NSString *str = @"http://www.vitagou.hk/site/products1/id/";
//    NSString *url = [str stringByAppendingString:@"579"];
//    NSLog(@"goods_id  url %@",url);
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
//    [webView loadRequest:request];
//    
//   
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
  CGFloat  documentHeight = [[_productDetailWebView stringByEvaluatingJavaScriptFromString:@"document.getElementById(\"content\").offsetHeight;"] floatValue];
    NSLog(@"网页高度---------------------------------------------：%f",documentHeight);
        CGRect frame = _productDetailWebView.frame;
        frame.size.height = documentHeight + 10;
        _productDetailWebView.frame = frame;
}



-(void)setProData:(zxb_product_data *)proData{
    
    _proDes.proData = proData;
    
    _productComment.producCommentData = proData;
    
}



-(void)setHeight:(CGFloat)height{
    NSLog(@"通知高度pro %f",height);
//    CGFloat documentHeight = [[_productDetailWebView stringByEvaluatingJavaScriptFromString:@"document.getElementById(\"content\").offsetHeight;"] floatValue];
//    CGRect frame = _productDetailWebView.frame;
//    frame.size.height = documentHeight + 10;

    
//    _productDetailWebView.frame = frame;
    
    
    [AJNotification postNotificationName:ProductHeadViewHeightDidChange object:[NSNumber numberWithFloat:Width*5/2]];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.height = CGRectGetMaxY(self.frame);
}

@end
