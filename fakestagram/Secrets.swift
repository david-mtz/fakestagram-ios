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
    static let account = "com.fakestagram.token"
    case host
    case uuid
    
    var value: String? {
        switch self {
        case .host:
            return "https://fakestagram-api.herokuapp.com/"
        case .uuid:
            return SAMKeychain.password(forService: "authentication", account: Secrets.account)
        }
    }
    
    func set(value: String) -> Bool{
        switch self {
            case .uuid:
                SAMKeychain.setPassword(value, forService: "authentication", account: Secrets.account)
                return true
            default:
                return false
        }
    }
    
}
