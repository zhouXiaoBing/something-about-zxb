//
//  ViewController.m
//  lvdouyi
//
//  Created by Mac on 2018/9/7.
//  Copyright © 2018年 vitagou. All rights reserved.
//

#import "ViewController.h"
#import "WKDelegateController.h"
#import "WebViewJavascriptBridge.h"
#import "IntroductoryPagesHelper.h"
#import <UShareUI/UShareUI.h>
#import "shareBean.h"

@interface ViewController ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>

@property (nonatomic, strong) WKWebView *webView;

@property (nonatomic, strong) WKUserContentController* userContentController;

@property (nonatomic ,strong) shareBean *bean;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"ViewController_viewDidLoad");
    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
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
    
    // 3. 发送请求给服务器
    [_webView loadRequest:request];
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
    
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:self.bean.title descr:self.bean.description thumImage:[UIImage imageNamed:@""]];
    //设置网页地址
    shareObject.webpageUrl =self.bean.url;
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatFavorite),@(UMSocialPlatformType_WechatTimeLine)]];
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        if (platformType == UMSocialPlatformType_WechatTimeLine) {
            
        }else if (platformType == UMSocialPlatformType_WechatSession){
            
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
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"webViewDidFinishLoad");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
