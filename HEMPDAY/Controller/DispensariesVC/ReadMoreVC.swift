//
//  ReadMoreVC.swift
//  HEMPDAY
//
//  Created by admin on 1/19/21.
//  Copyright © 2021 Chandradip. All rights reserved.
//

import UIKit
import WebKit
import MBProgressHUD

class ReadMoreVC: UIViewController,WKNavigationDelegate {
    
   var webload = String()
    @IBOutlet weak var webView : WKWebView!
    
    var firstTimeLoad : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        MBProgressHUD.showAdded(to: (self.view)!, animated: true)
        self.webView?.backgroundColor = UIColor.clear
        self.webView?.scrollView.backgroundColor = UIColor.clear
        
        webView.navigationDelegate = self
         let url = URL(string: webload)
         webView.load(URLRequest(url: url!))

    }
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
         DispatchQueue.main.async {
                   MBProgressHUD.hide(for: (self.view)!, animated: true)
               }
    }

   func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: (self.view)!, animated: true)
        }
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("start")
        if firstTimeLoad{
            MBProgressHUD.showAdded(to: (self.view)!, animated: true)
        }
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
         DispatchQueue.main.async {
            MBProgressHUD.hide(for: (self.view)!, animated: true)
        }
    }
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: (self.view)!, animated: true)
        }
    }
    
    @IBAction func backButtonAction( _ sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    

}
