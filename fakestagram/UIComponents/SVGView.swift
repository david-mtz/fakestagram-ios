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
        image.scrollView.isScrollEnabled = false
        addSubview(image)
        image.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: bottomAnchor)
    }
    
    func setImage(urlString: String) {
        
        let svgName = String(urlString.hashValue) + ".svg"
        let cache = DataCache(filename: svgName)
        
        guard let url = URL(string: urlString) else {
            print("Error: cannot create URL")
            return
        }
        
        if let img = cache.load() {
            image.load(img, mimeType: "image/svg+xml", characterEncodingName: "UTF-8", baseURL: url)
            return
        }
        
        DispatchQueue.global(qos: .background).async {
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    self.image.load(data, mimeType: "image/svg+xml", characterEncodingName: "UTF-8", baseURL: url)
                }
                _ = cache.save(data: data)
            }
        }

        
    }
    
    func setImage(url: URL?) {
        guard let url = url else { return }
        setImage(urlString: url.absoluteString)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // Hard coded offset value to center svg
        webView.evaluateJavaScript("window.scrollTo(410,0)", completionHandler: nil)
    }
    
    
    
}
