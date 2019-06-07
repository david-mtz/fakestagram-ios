//
//  Account.swift
//  fakestagram
//
//  Created by LuisE on 3/17/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation
import UIKit

struct Account: Codable {
    let id: String?
    let name: String
    let deviceNumber: String
    let deviceModel: String
    
    static func initialize() -> Account {
        return Account(
            id: nil,
            name: Names.load().generate(),
            deviceNumber: UIDevice.identifier,
            deviceModel: UIDevice.modelName
        )
    }
    
    func avatarURL() -> URL {
        return Identicon(key: name).url()!
    }
    
    func toAuthor() -> Author? {
        guard let id = id else { return nil }
        return Author(name: name, id: id)
    }

}
