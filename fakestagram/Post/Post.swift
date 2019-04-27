//
//  Post.swift
//  fakestagram
//
//  Created by LuisE on 3/16/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation

struct Post: Codable {
    let id: Int?
    let title: String
    let imageUrl: String?
    let author: Author?
    var likesCount: Int
    var commentsCount: Int
    let createdAt: String
    var liked: Bool
    
    mutating func swapLiked() -> Bool {
        self.liked = !self.liked
        return self.liked
    }
    
}
