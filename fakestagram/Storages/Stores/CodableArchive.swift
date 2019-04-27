//
//  CodableStore.swift
//  fakestagram
//
//  Created by LuisE on 3/25/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation

struct CodableArchive<T> where T: Codable {
    let filename: String
    let dataContainter = DataContainer.permanent
    func load() -> T? {
        guard let data = dataContainter.load(filename: filename) else {
            return nil
        }
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch let err {
            print("Could not decode data: \(err.localizedDescription)")
            return nil
        }
    }
    
    func save(data dataSource: T) -> Bool{
        guard let data = try? JSONEncoder().encode(dataSource) else { return false }
        return dataContainter.save(data: data, in: filename)
    }
}
