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
    
    
//    let ADCVal : String
//    let T1 :String
//    let T2 :String

    var webView : WKWebView!
    
    var itemString :String?
    
    var js:String?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addWebView()
        let notification = Notification.Name(rawValue: "PeripheralNotification")
        NotificationCenter.default.addObserver(self, selector: #selector(AddSession(notification:)), name:notification, object: nil)
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
        
    }
    
    
    
    @objc func AddSession(notification:Notification) {
        print("AddSession 被调用")
        let user = notification.userInfo as![String:AnyObject]
        let ADCVal = user["ADCVal"] as! String
        let T1 = user["T1"] as! String
        let T2 = user["T2"] as! String
        let js1:String = "javascript:(function(){window.sessionStorage.setItem('ADCVal',"
        let js2:String = ");window.sessionStorage.setItem('T1',"
        let js3:String = ");window.sessionStorage.setItem('T2',"
        let js4:String = ");})();"
        let js:String =  js1.appending(ADCVal).appending(js2).appending(T1).appending(js3).appending(T2).appending(js4)
        print("js",js)
        DispatchQueue.main.sync {
              print("主线程")
        webView.evaluateJavaScript(js, completionHandler: nil)
        }
    }
    
    
    //js 调用 native 代理
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("js 调用 native 代理")
        // 判断是否是调用原生的
        if "myName" == message.name {
            // 判断message的内容，然后做相应的操作
            print("message.body",message.body)//message.body就是 mmappbid ，另一个参数是1.
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
    



