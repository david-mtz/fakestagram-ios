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
    


}
