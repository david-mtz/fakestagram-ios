//
//  PostDetailViewController.swift
//  fakestagram
//
//  Created by LuisE on 3/16/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import UIKit

class PostDetailViewController: UIViewController {

    @IBOutlet weak var authorView: PostAuthorView!
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var commentLabel: UIButton!
    
    @IBOutlet weak var countLikes: UILabel!
    
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    public var post: Post?

    var rowId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpPost()
    }
    
    func setUpPost() {
        
        guard let post = post else { return }
        
        authorView.author = post.author
        
        authorView.locationName = post.location
        
        descriptionTextView.text = post.title
        
        imgView.getFromUrl(url: post.imageUrl)
        
        countLikes.text = ("\(post.likesCount) Likes")
        
    }
    
    @IBAction func showCommentView(_ sender: UIButton) {
        let nextViewController = CommentViewController(nibName: "CommentViewController", bundle: nil)
        nextViewController.post = post
        nextViewController.rowId = rowId
        nextViewController.accountProfile = AccountRepo.shared.load()
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @IBAction func likeAction(_ sender: UIButton) {
        guard var post = self.post else {return}
        
        let likeClient = LikeUpdaterClient(post: post)
        self.post = likeClient.update()
        
        countLikes.text = ("\(self.post!.likesCount) Likes")
        
    }
    
}
