//
//  CommentCollectionViewCell.swift
//  fakestagram
//
//  Created by David on 6/4/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import UIKit

class CommentCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var avatarView: SVGView!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var commentTextView: UITextView!
    
    var comment: Comment? {
        didSet {
            updateView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
        // Initialization code
    }
    
    func setUpUI() {
        avatarView.clipsToBounds = true
        avatarView.layer.cornerRadius = 20
        commentTextView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func updateView() {
        
        guard let comment = comment, let author = comment.author else {
            return
        }
        
        avatarView.setImage(url: author.avatarURL())
        authorNameLabel.text = author.name
        commentTextView.text = comment.content
    }

}
