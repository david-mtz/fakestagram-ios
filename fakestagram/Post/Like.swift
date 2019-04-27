//
//  Like.swift
//  fakestagram
//
//  Created by David Arturo Martinez Guzman D3 on 4/26/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation

struct Like: Codable {
    let id: String?
    let postId: String?
    let accountId: String
    let createdAt: String
    let updateAt: String
}
