//
//  ViewController.m
//  lvdouyi
//
//  Created by Mac on 2018/9/7.
//  Copyright © 2018年 vitagou. All rights reserved.
//

#import "ViewController.h"
#import "WKDelegateController.h"

#import "IntroductoryPagesHelper.h"
#import "WebViewJavascriptBridge.h"
#import <UShareUI/UShareUI.h>
#import "shareBean.h"
#import "AXWebViewController.h"

@interface ViewController ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler,WKURLSchemeHandler>

@property (nonatomic, strong) WKWebView *webView;

@property (nonatomic, strong) WKUserContentController* userContentController;

@property (nonatomic ,strong) shareBean *bean;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"ViewController_viewDidLoad");
//    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
//    [IntroductoryPagesHelper showIntroductoryPageView:@[@"introne.jpg",@"intrtwo.jpg",@"intrthree.jpg"]];
 //查看 HTTP 信息
//   [self loadString:@"http://httpbin.org/get"];
//    [self loadString:@"http://m.baidu.com"];
   
    [self loadString:@"http://s5-test.vitagou.com"];

   
    
}

- (void)loadString:(NSString *)str  {
    
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    _userContentController = [[WKUserContentController alloc] init];
    [_userContentController addScriptMessageHandler:self name:@"GetGoodsId"];
    configuration.userContentController = _userContentController;
    WKPreferences *preferences = [WKPreferences new];
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    //    preferences.minimumFontSize = 40.0; //导致自适应的效果显示问题
    configuration.preferences = preferences;

    _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
    
    _webView.navigationDelegate = self;
    
    _webView.UIDelegate = self;
    
    [self.view addSubview:_webView];
    
    // 1. URL 定位资源,需要资源的地址
    
    NSString *urlStr = str;
    if (![str hasPrefix:@"http://"]) {
        urlStr = [NSString stringWithFormat:@"http://m.baidu.com/s?word=%@", str];
    }
    
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    // 2. 把URL告诉给服务器,请求,从m.baidu.com请求数据
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //----------------
    NSMutableURLRequest *reques = [NSMutableURLRequest requestWithURL:url];
    NSArray *cookies = [NSHTTPCookieStorage sharedHTTPCookieStorage].cookies;
    //Cookies数组转换为requestHeaderFields
    NSDictionary *requestHeaderFields = [NSHTTPCookie requestHeaderFieldsWithCookies:cookies];
    //设置请求头
    reques.allHTTPHeaderFields = requestHeaderFields;
    //----------------
    // 3. 发送请求给服务器
    [_webView loadRequest:reques];
}
-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    
    if ([message.name isEqualToString:@"GetGoodsId"]) {
        [self ShareWithInformation:message.body];
        [_webView stopLoading];//拿到goods_id后不再进行网页跳转
        
    }
}

- (void)ShareWithInformation:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    NSString *goods_id = [dic objectForKey:@"goods_id"];
    //在这里写分享操作的代码
    NSLog(@"要分享了哦😯 goods_id %@",goods_id);
    
    self.bean = [shareBean mj_objectWithKeyValues:goods_id];
    NSLog(@"bean.title %@",self.bean.title);
    
    //创建分享消息对象
    
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:self.bean.title descr:self.bean.title thumImage:self.bean.icon];
    //设置网页地址
    shareObject.webpageUrl =self.bean.url;

    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatFavorite),@(UMSocialPlatformType_WechatTimeLine)]];
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        if (platformType == UMSocialPlatformType_WechatTimeLine) {
            [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
                if (error) {
                    NSLog(@"************Share fail with error %@*********",error);
                }else{
                    NSLog(@"response data is %@",data);
                }
            }];
        }else if (platformType == UMSocialPlatformType_WechatSession){
            [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
                if (error) {
                    NSLog(@"************Share fail with error %@*********",error);
                }else{
                    NSLog(@"response data is %@",data);
                }
            }];
        }else if (platformType == UMSocialPlatformType_WechatFavorite){
            [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
                if (error) {
                    NSLog(@"************Share fail with error %@*********",error);
                }else{
                    NSLog(@"response data is %@",data);
                }
            }];
        }
    }];

}


- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"webViewDidStartLoad");
    NSString *currentURL = webView.URL.absoluteString;
    NSLog(@"webViewDidStartLoad_currentURL %@",currentURL);
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSString *currentURL = webView.URL.absoluteString;
    NSLog(@"webViewDidFinishLoad_currentURL %@",currentURL);
    
}


- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    //返回支付宝的信息字符串，alipays:// 以后的为支付信息，这个信息后台是经过 URLEncode 后的，前端需要进行解码后才能跳转支付宝支付（坑点）
    //https://ds.alipay.com/?from=mobilecodec&scheme=alipays://platformapi/startapp?saId=10000007&clientVersion=3.7.0.0718&qrcode=https%253A%252F%252Fqr.alipay.com%252Fbax041244dd0qf8n6ras805b%253F_s%253Dweb-other
//    NSString *urlStr = [navigationResponse.response.URL.absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    if ([urlStr containsString:@"weixin://"]) {
//
//        NSRange range = [urlStr rangeOfString:@"weixin://"]; //截取的字符串起始位置
//        NSString * resultStr = [urlStr substringFromIndex:range.location]; //截取字符串
//
//        NSURL *alipayURL = [NSURL URLWithString:resultStr];
//
//        [[UIApplication sharedApplication] openURL:alipayURL options:@{UIApplicationOpenURLOptionUniversalLinksOnly: @NO} completionHandler:^(BOOL success) {
//
//        }];
//    }

    WKNavigationResponsePolicy actionPolicy = WKNavigationResponsePolicyAllow;
    //这句是必须加上的，不然会异常
    decisionHandler(actionPolicy);
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    NSString *urlStr =  navigationAction.request.URL.absoluteString;
    NSLog(@"urlStr %@",urlStr);
    NSDictionary *headers = [navigationAction.request allHTTPHeaderFields];
    NSLog(@"headers %@",headers);
// [[UIApplication sharedApplication]openURL:navigationAction.request.URL options:@{UIApplicationOpenURLOptionUniversalLinksOnly: @NO} completionHandler:nil];
    if ([urlStr containsString:@"weixin://wap/pay?"]) {
        [[UIApplication sharedApplication]openURL:navigationAction.request.URL options:@{UIApplicationOpenURLOptionUniversalLinksOnly: @NO,@"from":@"lvdouyi"} completionHandler:nil];
        decisionHandler(WKNavigationActionPolicyCancel);
    }else{
//                WebChatPayH5VIew *h5View = [[WebChatPayH5VIew alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
//                //url是没有拼接redirect_url微信h5支付链接
//                [h5View loadingURL:urlStr withIsWebChatURL:NO];
//                [self.view addSubview:h5View];

    decisionHandler(WKNavigationActionPolicyAllow);
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
