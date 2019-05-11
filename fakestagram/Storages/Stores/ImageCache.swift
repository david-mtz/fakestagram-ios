//
//  ImageCache.swift
//  fakestagram
//
//  Created by David Arturo Martinez Guzman D3 on 4/26/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation
import UIKit

struct ImageCache {
    
    let dataContainer: DataContainer = DataContainer.cache
    private let cache = NSCache<NSString, UIImage>()
    let filename: String
    
    init(filename: String) {
        self.filename = filename
    }
    
    func load() -> UIImage?{
        
        if let img = cache.object(forKey: filename as NSString) {
            return img
        }
        
        guard let data = dataContainer.load(filename: filename) else {
            //print("Unable to load data")
            return nil
        }
        return UIImage(data: data)
    }
    
    func save(image: UIImage) -> Bool {
        cache.setObject(image, forKey: filename as NSString)

        guard let data = image.jpegData(compressionQuality: 0.95) else {
            print("Unable to load jpeg data representation")
            return false
        }
        
        return dataContainer.save(data: data, in: filename)
    }
    
}
