//
//  TimelineViewController.swift
//  fakestagram
//
//  Created by LuisE on 3/16/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController {
    @IBOutlet weak var postsCollectionView: UICollectionView!
    
    let identifierCell = "postViewCell"
    
    
    var listPost: [Post] = [Post]() {
        didSet {
            updateCollection()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postsCollectionView.delegate = self
        postsCollectionView.dataSource = self
        postsCollectionView.register(UINib(nibName: "PostCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: identifierCell)
        PostRepo().getList(success: {(listPost) in
            self.listPost = listPost
        })
        
        NotificationCenter.default.addObserver(self, selector: #selector(didLikePost), name: .didLikePost, object: nil)
        
        
        // Do any additional setup after loading the view.
    }
    
    
    @objc func didLikePost(notification: NSNotification) {
        guard let userInfo = notification.userInfo, let data = userInfo["post"] as? Data else {return}
        print("-------------- Notification post --------------")
        let json = try? JSONDecoder().decode(Post.self, from: data)
        print(json)
        guard let idPost = userInfo["row"] as? Int, let postUpdated = json else {return}
        print("Se actualizo en el timeline")
        listPost[idPost] = postUpdated
    }
    
    
    func updateCollection() {
        postsCollectionView.reloadData()
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

extension TimelineViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listPost.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifierCell, for: indexPath) as! PostCollectionViewCell
        
        cell.post = listPost[indexPath.row]
        
        cell.rowId = indexPath.row
        
        // Configure the cel
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //return image.size
        return CGSize(width: self.postsCollectionView.frame.width, height: 540)
    }

        
}
