//
//  SVGView.swift
//  fakestagram
//
//  Created by LuisE on 3/16/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import UIKit
import WebKit

class SVGView: UIView, WKNavigationDelegate {
    let image: WKWebView = WKWebView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        image.navigationDelegate = self
        addSubview(image)
        image.scrollView.isScrollEnabled = false
        image.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: bottomAnchor)
    }
    
    func setImage(urlString: String) {
        guard let url = URL(string: urlString) else {
            print("Error: cannot create URL")
            return
        }
        
        let req = URLRequest(url: url)
        image.load(req)
        
    }
    
    func setImage(url: URL?) {
        guard let url = url else {
            print("Error: cannot create URL")
            return
        }
        
        let req = URLRequest(url: url)
        image.load(req)
        
    }
    
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // Hard coded offset value to center svg
        webView.evaluateJavaScript("window.scrollTo(410,0)", completionHandler: nil)
    }
    
    
    
}
