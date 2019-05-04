//
//  TimelineClient.swift
//  fakestagram
//
//  Created by David Arturo Martinez Guzman D3 on 5/4/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation

class TimelineClient: RestClient<[Post]> {
    
    convenience init() {
        self.init(client: Client(), path: "/api/posts")
    }
    
    func show(page: Int, success: @escaping codableResponse) {
        let items = ["page": String(page)]
        //request(method: "GET", path: "/", queryItems: items, payload: [Post], success: success, errorHandler: nil)
    }

}
