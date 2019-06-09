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
    
    public var author: Author? {
        didSet {
            updateContent()
        }
    }
    
    public var locationName: String? {
        didSet {
            updateLocation()
        }
    }
    
    let avatarView: SVGView = SVGView()
    
    let label: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor.red
        label.textAlignment = NSTextAlignment(CTTextAlignment.left)
        return label
    }()
    
    let locationLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor.blue
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
        
        avatarView.anchor(top: topAnchor, leading: leadingAnchor, trailing: nil, bottom: bottomAnchor, size: CGSize(width: 40, height: 0))
        avatarView.radius(20)

        addSubview(label)
        label.anchor(top: topAnchor, leading: avatarView.trailingAnchor, trailing: trailingAnchor, bottom: nil, padding: UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0), size: CGSize(width: 0, height: 20))
        
        addSubview(locationLabel)
        locationLabel.anchor(top: label.bottomAnchor, leading: avatarView.trailingAnchor, trailing: trailingAnchor, bottom: bottomAnchor, padding: UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0))

    }
    
    func updateContent() {
        guard let author = self.author else { return }
        label.text
        = author.name
        avatarView.setImage(url: author.avatarURL())
        
    }
    
    func updateLocation() {
        guard let location = locationName else {return}
        locationLabel.text = location
    }
        
}
