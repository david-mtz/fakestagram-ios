//
//  Secrets.swift
//  fakestagram
//
//  Created by LuisE on 3/17/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation

enum Secrets {
    case host
    case uuid
    case nameUser
    
    var value: String? {
        switch self {
        case .host:
            return "https://fakestagram-api.herokuapp.com/"
        case .uuid:
            return UserDefaults.standard.string(forKey: "com.fakestagram.uuid")
        case .nameUser:
            return UserDefaults.standard.string(forKey: "com.fakestagram.nameUser")
        }
    }
    
    func set(value: String) -> Bool{
        switch self {
            case .uuid:
                UserDefaults.standard.set(value, forKey: "com.fakestagram.uuid")
                return true
            case .nameUser:
                UserDefaults.standard.set(value, forKey: "com.fakestagram.nameUser")
                return true
            default:
                return false
        }
    }
    
}
