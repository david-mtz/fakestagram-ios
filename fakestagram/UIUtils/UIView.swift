//
//  constraintsUIView.swift
//  fakestagram
//
//  Created by David on 4/7/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import UIKit
import Foundation

extension UIView {
    
    
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, trailing: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        
        if size.width > 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height > 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
        
    }
    
    func dimensionAnchors(height: NSLayoutDimension?, heightMultiplier: CGFloat = 1.0, width: NSLayoutDimension?, widthMultiplier: CGFloat = 1.0) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let height = height {
            heightAnchor.constraint(equalTo: height, multiplier: heightMultiplier).isActive = true
        }
        
        if let width = width {
            widthAnchor.constraint(equalTo: width, multiplier: widthMultiplier).isActive = true
        }
        
    }
    
    func centerAnchors(centerX: NSLayoutXAxisAnchor?, centerY: NSLayoutYAxisAnchor?) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let centerX = centerX {
            centerXAnchor.constraint(equalTo: centerX).isActive = true
        }
        
        if let centerY = centerY {
            centerYAnchor.constraint(equalTo: centerY).isActive = true
        }
        
    }
    
    
}

// Animation

extension UIView {
    
    func startRotating(duration: Double = 1) {
        let kAnimationKey = "rotation"
        
        if self.layer.animation(forKey: kAnimationKey) == nil {
            let animate = CABasicAnimation(keyPath: "transform.rotation")
            animate.duration = duration
            animate.repeatCount = Float.infinity
            animate.fromValue = 0.0
            animate.toValue = Float(M_PI * 2.0)
            self.layer.add(animate, forKey: kAnimationKey)
        }
    }
    
    func stopRotating() {
        let kAnimationKey = "rotation"
        
        if self.layer.animation(forKey: kAnimationKey) != nil {
            self.layer.removeAnimation(forKey: kAnimationKey)
        }
    }
    
}
