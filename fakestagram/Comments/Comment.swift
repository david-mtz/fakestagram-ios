//
//  Comment.swift
//  fakestagram
//
//  Created by David on 6/4/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation

struct Comment: Codable {
    let id: Int?
    var content: String
    let createdAt: String
    let updatedAt: String
    var author: Author?
}
