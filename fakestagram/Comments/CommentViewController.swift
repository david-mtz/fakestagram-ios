//
//  CommentViewController.swift
//  fakestagram
//
//  Created by David on 6/4/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import UIKit

class CommentViewController: UIViewController {

    @IBOutlet weak var commentsCollectionView: UICollectionView!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var avatarView: SVGView!
    @IBOutlet weak var sendButton: UIButton!
    
    let rehusableCell = "rehusableCell"
    
    @IBOutlet weak var commentAreaView: UIView!
    
    var comments: [Comment] = [Comment]() {
        didSet {
            updateView()
        }
    }
    
    var post: Post?
    var rowId: Int?
    var accountProfile: Account?
    var client: CommentClient?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    func setUp() {
        commentsCollectionView.delegate = self
        commentsCollectionView.dataSource = self
        
        commentsCollectionView.register(UINib(nibName: "CommentCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: rehusableCell)
        avatarView.radius(20.0)
        commentAreaView.layer.addBorder(edge: .top, color: UIColor.gray, thickness: 0.25)
        commentTextView.layer.addBorder(color: UIColor.gray, thickness: 0.25)
        commentTextView.radius(10.0)
        sendButton.radius(5.0)
        
        if let postId = post?.id {
            client = CommentClient(postId: postId)
            client?.showList { [weak self] (comments) in
                self?.comments = comments
            }
        }
        
        if let account = accountProfile {
            print(account)
            avatarView.setImage(url: account.avatarURL())
        }
        
    }
    
    func updateView() {
        commentsCollectionView.reloadData()
    }

    @IBAction func sendCommentAction(_ sender: UIButton) {
        guard let textComment = commentTextView.text, textComment.count > 0 else { return }
        let newComment = Comment(id: nil, content: textComment, createdAt: "", updatedAt: "", author: nil)
        client?.create(codable: newComment, success: { [weak self] (new) in
            self?.comments.append(new)
            self?.post?.commentsCount += 1
            guard let data = try? JSONEncoder().encode(self?.post) else {return}
            self?.commentTextView.text = ""
        })
    }
    
    
}

extension CommentViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,  UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: rehusableCell, for: indexPath) as? CommentCollectionViewCell else { return UICollectionViewCell() }
        cell.comment = comments[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sectionInset = (collectionViewLayout as! UICollectionViewFlowLayout).sectionInset
        let referenceHeight: CGFloat = 50
        return CGSize(width: collectionView.frame.width, height: referenceHeight)
    }
    
    
}
