//
//  SVGView.swift
//  fakestagram
//
//  Created by LuisE on 3/16/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import UIKit
import WebKit

class SVGView: UIView {
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
        addSubview(image)
        image.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: bottomAnchor)
    }
    
    func setImage(urlString: String) {
        guard let url = URL(string: urlString) else {
            print("Error: cannot create URL")
            return
        }
        guard let stringSVG = try? String(contentsOf: url) else {
            print("Error: The server doesn't give data")
            return
        }
        image.loadHTMLString(stringSVG, baseURL: nil)
    }
    
    
}
