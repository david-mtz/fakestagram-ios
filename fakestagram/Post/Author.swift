//
//  Author.swift
//  fakestagram
//
//  Created by LuisE on 3/16/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation

struct Author: Codable {
    let name: String
    let id: String
    
    static func initialize() -> Author {
        return Author(
            name: "",
            id: ""
        )
    }

    func avatarURL() -> URL {
        return Identicon(key: self.name).url()!
    }
}
