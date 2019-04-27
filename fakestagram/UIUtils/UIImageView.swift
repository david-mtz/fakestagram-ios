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
        
        
        guard let urlstring = url, let url = URL(string: urlstring) else {
            return
        }
        
        let imageKey = String(urlstring.hashValue)
        let cache = ImageCache(filename: imageKey)
        
        if let img = cache.load() {
            self.image = img
            //print("Se cargo de cache")
            return
        }
        
        DispatchQueue.global(qos: .background).async {
            if let data = try? Data(contentsOf: url), let img = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = img
                }
                _ = cache.save(image: img)
                //print("Se salvo en cache")
            }
        }

    }
    
}
