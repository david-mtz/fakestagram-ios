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
    
    private var post: Post
    
    var rowId: Int? = nil
    
    init(post: Post, rowId: Int) {
        self.post = post
        self.rowId? = rowId
    }
    
    init(post: Post) {
        self.post = post
    }

    func update() -> Post {
        if !post.liked {
            return like()
        } else {
            return dislike()
        }
    }
    
    func like() -> Post {
        guard let postId = self.post.id else { return self.post }
        let path = basePath + "/\(postId)/like"
        client.request("POST", path: path, body: nil, completionHandler: onSuccessLike(response:data:), errorHandler: onError(error:))
        var post = self.post
        post.likesCount += 1
        post.liked = true
        return post
    }
    
    func dislike() -> Post {
        guard let postId = self.post.id else { return self.post }
    
        let path = basePath + "/\(postId)/like"
        client.request("DELETE", path: path, body: nil, completionHandler: onSuccessDisLike(response:data:), errorHandler: onError(error:))
        
        var post = self.post
        post.likesCount -= 1
        post.liked = false
        return post
    }

    func onSuccessLike(response: HTTPResponse, data: Data?) {
        guard response.successful() else { return }
        print("-------------Ok like------------")
        
        var post = self.post
        post.likesCount += 1
        post.liked = true
        
        //sendNotification(post: post)

    }
    
    func onSuccessDisLike(response: HTTPResponse, data: Data?) {
        guard response.successful() else { return }
        
        print("-------------Ok dislike-------------")
        
        var post = self.post
        post.likesCount -= 1
        post.liked = false

        //sendNotification(post: post)

    }

    func onError(error: Error?) -> Void {
        guard let error = error else { return }
        print("Error on request: \(error.localizedDescription)")
    }
    
    private func sendNotification(post: Post) {
        guard let data = try? JSONEncoder().encode(post) else {return}
        
        NotificationCenter.default.post(name: .didLikePost, object: nil, userInfo: ["post": data as Any, "row": rowId as Any])
    }

}

