//
//  PostCollectionViewCell.swift
//  fakestagram
//
//  Created by LuisE on 3/16/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import UIKit

protocol showCommentViewDelegate {
    func showView(post: Post, rowId: Int)
}

class PostCollectionViewCell: UICollectionViewCell {
    
    var delegate: showCommentViewDelegate?
    
    public var post: Post? {
        didSet {
            postAuthorV.author = post?.author
            postAuthorV.locationName = post?.location
            updatePost()
        }
    }
    
    var rowId: Int? = nil
        
    @IBOutlet weak var imageV: UIImageView!
    @IBOutlet weak var countLikesLabel: UILabel!
    @IBOutlet weak var titleLabel: UITextView!
    @IBOutlet weak var countCommentsLabel: UILabel!
    @IBOutlet weak var postAuthorV: PostAuthorView!
    
    
    @IBOutlet weak var likeBtn: UIButton!
    
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
        guard var post = self.post, let rowId = self.rowId else {return}
        
        let likeClient = LikeUpdaterClient(post: post, rowId: rowId)
        self.post = likeClient.update()
    }
    
    
    @IBAction func commentView(_ sender: UIButton) {
        delegate?.showView(post: post!, rowId: rowId!)
    }
    
}
