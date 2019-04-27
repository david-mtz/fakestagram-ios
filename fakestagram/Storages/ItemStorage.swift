//
//  ItemStorage.swift
//  fakestagram
//
//  Created by LuisE on 3/25/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation

class ItemStorage<T> where T: Codable {
    public var item: T?
    private let store: CodableArchive<T>
    
    init(filename: String) {
        //StorageType.permanent.ensureExists()
        store = CodableArchive<T>(filename: filename)
        item = store.load()
    }
    
    func save() {
        guard let payload = item else { return }
        store.save(data: payload)
    }
}
