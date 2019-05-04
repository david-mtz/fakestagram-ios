//
//  ProfileClient.swif
//  fakestagram
//
//  Created by David Arturo Martinez Guzman D3 on 4/26/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation

class ProfileClient {
    
    let client = Client()
    let basePath = "/api/profile"
    
    let encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()
    
    let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()

    func showProfile(success: @escaping (Author) -> Void) {
        client.request("GET", path: basePath, body: nil, completionHandler: { (response, data) in
            if response.successful() {
                guard let data = data else {
                    print("Empty response")
                    return
                }
                do {
                    let json = try self.decoder.decode(Author.self, from: data)
                    success(json)
                } catch let err {
                    print("Error on json serialization: \(err.localizedDescription)")
                }
            } else{
                print("Error on response: \(response.rawResponse) - \(response.status):\nBody: \(String(describing: data))")
            }
        }, errorHandler: nil)
    }
    
    func showProfilePosts(success: @escaping ([Post]) -> Void) {
        let path = basePath + "/posts"
        client.request("GET", path: path, body: nil, completionHandler: { (response, data) in
            if response.successful() {
                guard let data = data else {
                    print("Empty response")
                    return
                }
                do {
                    print(data)
                    let json = try self.decoder.decode([Post].self, from: data)
                    success(json)
                } catch let err {
                    print("Error on json serialization: \(err.localizedDescription)")
                }
            } else{
                print("Error on response: \(response.rawResponse) - \(response.status):\nBody: \(String(describing: data))")
            }
        }, errorHandler: nil)
    }

}
