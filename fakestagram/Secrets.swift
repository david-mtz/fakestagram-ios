//
//  Secrets.swift
//  fakestagram
//
//  Created by LuisE on 3/17/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation
import SAMKeychain

enum Secrets {
    static let account = "com.fakestagram.account"
    case host
    case uuid
    case nameUser
    
    var value: String? {
        switch self {
        case .host:
            return "https://fakestagram-api.herokuapp.com/"
        case .uuid:
            return SAMKeychain.password(forService: "authentication", account: Secrets.account)
        case .nameUser:
            return UserDefaults.standard.string(forKey: "com.fakestagram.nameUser")
        }
    }
    
    func set(value: String) -> Bool{
        switch self {
            case .uuid:
                SAMKeychain.setPassword(value, forService: "authentication", account: Secrets.account)
                return true
            case .nameUser:
                UserDefaults.standard.set(value, forKey: "com.fakestagram.nameUser")
                return true
            default:
                return false
        }
    }
    
}
