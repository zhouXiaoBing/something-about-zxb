//
//  ViewController.swift
//  AcculifeCommunication
//
//  Created by Mac on 2018/8/1.
//  Copyright © 2018年 vitagou. All rights reserved.
//

import UIKit
import UIKit
import JavaScriptCore
import WebKit




class ViewController: UIViewController,UIWebViewDelegate,WKNavigationDelegate,WKScriptMessageHandler{
    

    var webView : WKWebView!
    
    var itemString :String?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.addWebView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addWebView() {
        print("addWebView")
        let webConfiguration = WKWebViewConfiguration()
  // 创建UserContentController（提供JavaScript向webView发送消息的方法）
        let userContent = WKUserContentController()
        userContent.add(self as WKScriptMessageHandler, name: "myName")
        webConfiguration.userContentController = userContent
        let myURL = URL(string: "http://125.227.206.31:136/AcuLife/ios/index.html")
        webView = WKWebView(frame: UIScreen.main.bounds, configuration: webConfiguration)
        let myRequest = URLRequest(url: myURL!)
        print("addWebView1")
        webView.load(myRequest)
        self.view.addSubview(webView)
        webView.navigationDelegate = self;
        print("addWebView2")
        
        
//        self.webView = WKWebView(frame: self.view.bounds)
//        self.view.addSubview(self.webView)
////        self.webView.delegate = self
////        self.webView.scalesPageToFit = true
//
////         加载网络Html页面 请设置允许Http请求
//        let url = NSURL(string: "http://125.227.206.31:136/AcuLife/ios/index.html");
//        let request = NSURLRequest(url:url! as URL)
//
//        self.webView.load(request as URLRequest)
//
    }
    
    
    
    
    //js 调用 native 代理
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("js 调用 native 代理")
        // 判断是否是调用原生的
        if "myName" == message.name {
            // 判断message的内容，然后做相应的操作
            print(message.body)//message.body就是 mmappbid ，另一个参数是1.
            //带着 mmappbid，1 跳转到蓝牙连接页面
            itemString = message.body as? String
            self.performSegue(withIdentifier: "CaliperView", sender: self)
        }
        
    }
    
    //segue 给新页面传递数据的方法
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CaliperView"{
            print("给新页面传递数据的方法")
            let con = segue.destination as! CaliperViewController
            con.uuidfromViewController = itemString
//            print(itemString ?? )
        }
        
    }
    
    
    //内容开始加载
    func webViewDidStartLoad(_ webView: UIWebView) {
        print("内容开始加载")
    }
    
    
    //页面加载失败
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print("页面加载页面加载失败")
    }
 
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
         print("页面加载完成")
    

        }
    }
    



