//
//  ThumbnailCollectionViewCell.swift
//  fakestagram
//
//  Created by David on 5/10/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import UIKit

class ThumbnailCollectionViewCell: UICollectionViewCell {
    
    var thumbnailUIImageView: UIImageView = {
        let thumbnailUIImageView = UIImageView()
        thumbnailUIImageView.contentMode = UIView.ContentMode.scaleAspectFit
        return thumbnailUIImageView
    }()
    
    var post: Post? {
        didSet { updateImageView() }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(thumbnailUIImageView)
        thumbnailUIImageView.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: bottomAnchor, padding: UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func updateImageView() {
        guard let post = self.post else { return }
        thumbnailUIImageView.getFromUrl(url: post.imageUrl)
    }
    
}
