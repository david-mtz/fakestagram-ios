//
//  UIImage.swift
//  fakestagram
//
//  Created by David Arturo Martinez Guzman D3 on 4/13/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
        
    
    func getFromUrl(url: String?) {
        
        let contentModeOriginal = contentMode
        let backgroundOriginal = backgroundColor
        
        contentMode = .center
        backgroundColor = UIColor.clear
        image = UIImage(named:"sync-spinning")
        self.startRotating()
        
        guard let urlstring = url, let url = URL(string: urlstring) else {
            return
        }
        
        let imageKey = String(urlstring.hashValue) + ".jpg"
        let cache = ImageCache(filename: imageKey)
        
        if let img = cache.load() {
            self.stopRotating()
            contentMode = contentModeOriginal
            self.image = img
            return
        }
        
        DispatchQueue.global(qos: .background).async {
            if let data = try? Data(contentsOf: url), let img = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.stopRotating()
                    self.contentMode = contentModeOriginal
                    self.image = img
                }
                _ = cache.save(image: img)
            }
        }

    }
    
}
