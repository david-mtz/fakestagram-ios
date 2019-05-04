//
//  ProfileViewController.swift
//  fakestagram
//
//  Created by David Arturo Martinez Guzman D3 on 5/4/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var postAuthorV: PostAuthorView!
    private let client = ProfileClient()
    var posts: [Post] = [Post]()
    var author = Author.initialize()
    let cellId = "postThumbnailCell"
    
    @IBOutlet weak var previewCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        previewCollectionView.delegate = self
        previewCollectionView.dataSource = self
        setUpView()
    }
    
    
    func setUpView() {
        
        client.showProfile { (author) in
            print(author)
            self.postAuthorV?.author = author
        }
        
        client.showProfilePosts { (listPost) in
            self.posts = listPost
            self.previewCollectionView.reloadData()
            print(listPost)
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        cell.backgroundColor = .red
        return cell
        
    }

    
    
    
}
