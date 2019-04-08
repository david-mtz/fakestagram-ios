//
//  Author.swift
//  fakestagram
//
//  Created by LuisE on 3/16/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import UIKit

@IBDesignable
class PostAuthorView: UIView {
    var author: Author!
    let avatarView: SVGView = SVGView()
    let label: UILabel = {
        let label = UILabel()
        label.text = "Adipiscing elit"
        label.textColor = UIColor.white
        label.textAlignment = NSTextAlignment(CTTextAlignment.left)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView() {
        
        addSubview(avatarView)
        avatarView.anchor(top: topAnchor, leading: leadingAnchor, trailing: nil, bottom: bottomAnchor,  size: CGSize(width: 60, height: 0))
        avatarView.clipsToBounds = true
        avatarView.layer.cornerRadius = 30
        
        addSubview(label)
        label.anchor(top: topAnchor, leading: avatarView.trailingAnchor, trailing: trailingAnchor, bottom: bottomAnchor, padding: UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0))
        
        
    }
}
