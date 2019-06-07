//
//  CALayer+radius.swift
//  fakestagram
//
//  Created by David on 6/5/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func radius(_ value: CGFloat) {
        layer.cornerRadius = value
        clipsToBounds = true
    }
    
}
