//
//  UIImage.swift
//  fakestagram
//
//  Created by David Arturo Martinez Guzman D3 on 4/27/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    func toBase64() -> String? {
        
        guard let imageData = self.jpegData(compressionQuality: 0.95) else { return nil }
        
        return "data:image/jpeg;base64," + imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
    }
    
    func toBase64(compressionQuality: CGFloat) -> String? {
        
        guard let imageData = self.jpegData(compressionQuality: compressionQuality) else { return nil }
        
        return "data:image/jpeg;base64," + imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
    }

}
