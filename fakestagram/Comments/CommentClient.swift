//
//  CommentClient.swift
//  fakestagram
//
//  Created by David on 6/4/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation

import Foundation

class CommentClient: RestClient<Comment> {
    
    convenience init(postId: Int) {
        self.init(client: Client(), path: "/api/posts/\(postId)/comments")
    }
    
    func showList(success: @escaping ([Comment]) -> Void) {
        request("GET", path: path, queryItems: nil, payload: nil, success: success, errorHandler: nil)
    }
    
}
