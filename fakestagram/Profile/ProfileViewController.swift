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
        previewCollectionView.register(ThumbnailCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
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

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? ThumbnailCollectionViewCell else { return ThumbnailCollectionViewCell() }
        cell.post = posts[indexPath.row]
        return cell
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = self.previewCollectionView.frame.width / 3.0
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let nextViewController = PostDetailViewController(nibName: "PostDetailViewController", bundle: nil)
        
        nextViewController.post = posts[indexPath.row]
        
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
    }

    
}
