//
//  PostCollectionViewCell.swift
//  fakestagram
//
//  Created by LuisE on 3/16/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import UIKit

class PostCollectionViewCell: UICollectionViewCell {
    public var post: Post? {
        didSet {
            postAuthorV.author = post?.author
            updatePost()
        }
    }
    
    private var like = false
    
    @IBOutlet weak var imageV: UIImageView!
    @IBOutlet weak var countLikesLabel: UILabel!
    @IBOutlet weak var titleLabel: UITextView!
    @IBOutlet weak var countCommentsLabel: UILabel!
    @IBOutlet weak var postAuthorV: PostAuthorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updatePost() {
        guard let post = post else {
            return
        }
        
        countLikesLabel.text = String(post.likesCount) + " Likes"
        countCommentsLabel.text = String(post.commentsCount) + " Comments"
        titleLabel.text = post.title
        
        imageV.getFromUrl(url: post.imageUrl)
        
    }
    
    @IBAction func tapLike(_ sender: Any) {
        likeUpdateView()
    }
    
    func likeUpdateView(){
        guard var post = self.post else {
            return
        }
        
        like = !like
        if like {
            post.likesCount += 1
        } else {
            post.likesCount -= 1
        }
        
        self.post = post
    }
    
    
}
