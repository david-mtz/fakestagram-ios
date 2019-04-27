//
//  PostRepo.swift
//  fakestagram
//
//  Created by David Arturo Martinez Guzman D3 on 4/13/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation
import UIKit

class PostRepo {
    static let shared = PostRepo()
    let restClient = RestClient<[Post]>(client: Client(), path: "/api/post")

    typealias postResponse = ([Post]) -> Void
    
    func get(success: @escaping ([Post]) -> Void) {
        restClient.show(success: success)
    }
    
    func getList(success: @escaping ([Post]) -> Void) {
        let restClient = RestClient<[Post]>(client: Client(), path: "/api/posts")
        restClient.show(success: success)
    }
    
}
