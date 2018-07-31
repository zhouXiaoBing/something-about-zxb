//
//  ViewController.swift
//  AcculifeCommunication
//
//  Created by 周小兵 on 2018/7/31.
//  Copyright © 2018年 ugolazy. All rights reserved.
//

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
    
    @IBOutlet var Web:WKWebView!
    var webView  = WKWebView()
   
    func callHandler(handlerFuncName: String) {
        
    }
    
    override func viewDidLoad() {
        
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

