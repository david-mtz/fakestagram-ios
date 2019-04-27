//
//  LikeClient.swift
//  fakestagram
//
//  Created by David Arturo Martinez Guzman D3 on 4/26/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation

class LikeUpdaterClient {

    private let client = Client()
    //let id = Int
    private let basePath = "/api/posts"
    
    func like(post: Post) -> Int {
        guard let postId = post.id else { return post.likesCount }
        let path = basePath + "/\(postId)/like"
        client.request("POST", path: path, body: nil, completionHandler: onSuccess(response:data:), errorHandler: onError(error:))
        return post.likesCount + 1
    }
    
    func dislike(post: Post) -> Int {
        guard let postId = post.id else { return post.likesCount }
        let path = basePath + "/\(postId)/like"
        client.request("DELETE", path: path, body: nil, completionHandler: onSuccess(response:data:), errorHandler: onError(error:))
        return post.likesCount - 1
    }

    func onSuccess(response: HTTPResponse, data: Data?) {
        guard response.successful() else { return }
        print("Ok")
    }
    
    func onError(error: Error?) -> Void {
        guard let error = error else { return }
        print("Error on request: \(error.localizedDescription)")
    }

}


/*class LikeClient: RestClient<Like> {
    
    convenience init(postId: Int) {
        self.init(client: Client(), path: "api/post/\(postId)/like")
    }
    
    /*func create() {
        client.request("POST", path: path, body: nil, completionHandler: <#T##completionHandler?##completionHandler?##(HTTPResponse, Data?) -> Void#>, errorHandler: <#T##errorHandler?##errorHandler?##(Error?) -> Void#>)
    }*/
    
    
}
*/
