//
//  WikiWebViewController.swift
//  MarvelHeroesGuide
//
//  Created by Tairus Djons on 24.07.2018.
//  Copyright © 2018 Tairus Djons. All rights reserved.
//

import UIKit
import WebKit
class WikiWebViewController: UIViewController {

    private var hero: Character?
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    @IBOutlet fileprivate weak var webView: WKWebView!
    override func viewDidLoad() {
        
        webView.navigationDelegate = self
        
        guard let hero = self.hero
            else {
                alertMessage(view: self,
                             title: "He was here! But flies away",
                             usrMessage: "Hero data is not found, maybe problem is in bad connection")
                return
        }

        let request = URLRequest(url: URL(string: hero.urls[0].url)!)
        
        self.webView.load(request)
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    init(nibName: String?,
         bundle: Bundle?,
         character: Character) {
        self.hero = character
        super.init(nibName: nibName, bundle: bundle)
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


extension WikiWebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
         self.loadingIndicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        self.loadingIndicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.loadingIndicator.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.loadingIndicator.stopAnimating()
        alertMessage(view: self, title: "Problems", usrMessage: "Can't download resource")
    }
}

