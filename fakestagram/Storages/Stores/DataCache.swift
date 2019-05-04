//
//  ImageCache.swift
//  fakestagram
//
//  Created by David Arturo Martinez Guzman D3 on 4/26/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation
import UIKit

class DataC {
    
    var data: Data
    
    init(data: Data) {
        self.data = data
    }
    
}

struct DataCache {
    
    let dataContainer: DataContainer = DataContainer.cache
    private let cache = NSCache<NSString, DataC>()
    let filename: String
    
    init(filename: String) {
        self.filename = filename
    }
    
    func load() -> Data? {
        
        if let dataClass = cache.object(forKey: filename as NSString) {
            return dataClass.data
        }
        
        guard let data = dataContainer.load(filename: filename) else {
            print("Unable to load data")
            return nil
        }
        
        return data
    }
    
    func save(image: Data) -> Bool {
        
        return true
        
        /*element = DataC(data: <#T##Data#>)
        
        cache.setObject(element, forKey: filename as NSString)
        
        return dataContainer.save(data: data, in: filename)*/
    }
    
}
