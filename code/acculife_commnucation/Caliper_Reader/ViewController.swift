//
//  ViewController.swift
//  AcculifeCommunication
//
//  Created by 周小兵 on 2018/7/31.
//  Copyright © 2018年 ugolazy. All rights reserved.
//
/**在工程里用  故事板写了 wkwebview  如果运行在 ios11以下 就会报这个错误，如果要支持iOS 11 以下的用户，需重写View部分，使用代码调用WKWebView，而不用使用故事版来加载wkwebview。
*/
import Foundation
import UIKit
import JavaScriptCore
import WebKit



@objc protocol SwiftJavaScriptDelegate :JSExport{
    
    func callHandler(handlerFuncName:String)
}

@objc class SwiftJavaScriptModel: NSObject, SwiftJavaScriptDelegate{
    func callHandler(handlerFuncName: String) {
        
    }
    
    weak var controller: UIViewController?
    weak var jsContext: JSContext?
    
}

// 通过JSContext 执行JS 代码
let context : JSContext = JSContext()




class ViewController : UIViewController,SwiftJavaScriptDelegate,WKNavigationDelegate{
    

    var webView  = WKWebView()
   
    func callHandler(handlerFuncName: String) {
        
    }
    
    override func viewDidLoad() {
        print("viewController_viewDidLoad")
        self.addWebView()
    }
    //
    func addWebView() {
        
        let webConfiguration = WKWebViewConfiguration()
        let myURL = URL(string: "http://125.227.206.31:136/AcuLife/app/index.html")
        webView = WKWebView(frame: view.bounds, configuration: webConfiguration)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        self.view.addSubview(webView)
        webView.navigationDelegate = self;
        
    }
    
    
}

