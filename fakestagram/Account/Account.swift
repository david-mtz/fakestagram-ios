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
    
    static func loadFromStorage() -> Account? {
        
        if let uuid = UserDefaults.standard.string(forKey: "com.fakestagram.uuid"), let name = UserDefaults.standard.string(forKey: "com.fakestagram.nameUser") {
            return Account(
                id: uuid,
                name: name,
                deviceNumber: UIDevice.identifier,
                deviceModel: UIDevice.modelName
            )
        }
        
        return nil
    }
    
    static func saveInStorage(account: Account) {
        if let id = account.id {
            UserDefaults.standard.set(id, forKey: "com.fakestagram.uuid")
            UserDefaults.standard.set(account.name, forKey: "com.fakestagram.nameUser")
        }
        print("I didn't save account in storage")
    }
    
}
