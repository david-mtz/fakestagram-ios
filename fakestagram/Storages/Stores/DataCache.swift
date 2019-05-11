//
//  ImageCache.swift
//  fakestagram
//
//  Created by David Arturo Martinez Guzman D3 on 4/26/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation
import UIKit

struct DataCache {
    
    let dataContainer: DataContainer = DataContainer.cache
    private let cache = NSCache<NSString, NSData>()
    let filename: String
    
    init(filename: String) {
        self.filename = filename
    }
    
    func load() -> Data? {
        
        if let data = cache.object(forKey: filename as NSString) {
            return Data(referencing: data)
        }
        
        guard let data = dataContainer.load(filename: filename) else {
            return nil
        }
                
        return data
    }
    
    func save(data: Data) -> Bool {
                
        cache.setObject(NSData(data: data), forKey: filename as NSString)
        
        return dataContainer.save(data: data, in: filename)
    }
    
}
