//
//  ImageArchive.swift
//  fakestagram
//
//  Created by David Arturo Martinez Guzman D3 on 4/26/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation
import UIKit

struct ImageArchive {
    
    let dataContainer: DataContainer = DataContainer.permanent
    
    let filename: String
    
    func load() -> UIImage?{
        guard let data = dataContainer.load(filename: filename) else {
            print("Unable to load data")
            return nil
        }
        return UIImage(data: data)
    }
    
    func save(image: UIImage) -> Bool {
        guard let data = image.jpegData(compressionQuality: 0.95) else {
            print("Unable to load jpeg data representation")
            return false
        }
        
        return dataContainer.save(data: data, in: filename)
    }
    
}
