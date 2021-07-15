//
//  ViewController.swift
//  SampleHibrid
//
//  Created by hklife_mo on 2021/06/22.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {

    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let config = URLSessionConfiguration.default
//        config.httpAdditionalHeaders = ["User-Agent"]
        
        let url = URL(string: "https://eplandev.heungkuklife.co.kr")
//        if (enabled) {
//            newUserAgent = webSettings.getUserAgentString().replace("Mobile", "eliboM").replace("Android", "diordnA");
//        }
//        else {
//            newUserAgent = webSettings.getUserAgentString().replace("eliboM", "Mobile").replace("diordnA", "Android");
//        }
        
        var request = URLRequest(url: url!)
        print("start")

//        webView.evaluateJavaScript("navigator.userAgent"){ [weak webView] (result, error) in
//            if let webView = webView, let userAgent = result as? String {
//                webView.customUserAgent = userAgent + "/diordnA"
//            }
//
//        }
        
        webView.load(request)
    }

    
    override func loadView() {
        super.loadView()
        
        webView = WKWebView(frame: self.view.frame)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        
        self.view = self.webView
//
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //alert 처리
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: { (action) in
            completionHandler()
        }))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    //confirm 처리
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: { (action) in
            completionHandler(true)
        }))
        
        alertController.addAction(UIAlertAction(title: "취소", style: .default, handler: { (action) in
            completionHandler(false)
        }))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    //confirm 처리2
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        
        let alertController = UIAlertController(title: "", message: prompt, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: { (action) in
            
            if let text = alertController.textFields?.first?.text{
                completionHandler(text)
            }else{
                completionHandler(defaultText)
            }
            
        }))
        
        alertController.addAction((UIAlertAction(title: "취소", style: .default, handler: { (action) in
            completionHandler(nil)
        })))
        
        self.present(alertController, animated: true, completion: nil)
    }

    //href="_blank" 처리
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
        }
        
        return nil
    }
    
    //중복적으로 리로드 방지
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        webView.reload()
    }
}

