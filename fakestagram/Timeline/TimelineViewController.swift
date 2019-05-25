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
    
    let client = TimelineClient()
    let refreshControl = UIRefreshControl()
    var pageOffset = 1
    var loadingPage = false
    var lastPage = false

    var listPost: [Post] = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postsCollectionView.delegate = self
        postsCollectionView.dataSource = self
        postsCollectionView.prefetchDataSource = self
        postsCollectionView.register(UINib(nibName: "PostCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: identifierCell)
        postsCollectionView.addSubview(refreshControl)
        
        client.show { [weak self] data in
            self?.listPost = data
            self?.reloadData()
        }

        refreshControl.addTarget(self, action: #selector(self.reloadData), for: UIControl.Event.valueChanged)
        
        NotificationCenter.default.addObserver(self, selector: #selector(didLikePost), name: .didLikePost, object: nil)
        
//        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: ""), style: .done, target: self, action: #selector(takePhoto))
        
        // Do any additional setup after loading the view.
    }
    
    @objc func reloadData() {
        pageOffset = 1
        client.show { [weak self] data in
            self?.listPost = data
            sleep(1)
            self?.refreshControl.endRefreshing()
            self?.postsCollectionView.reloadData()
        }
    }

    
    @objc func didLikePost(notification: NSNotification) {
        guard let userInfo = notification.userInfo, let data = userInfo["post"] as? Data else {return}
        let json = try? JSONDecoder().decode(Post.self, from: data)
        guard let idPost = userInfo["row"] as? Int, let postUpdated = json else {return}
        listPost[idPost] = postUpdated
    }
    
    
    func updateCollection() {
        postsCollectionView.reloadData()
    }
    
    func loadNextPage() {
        if lastPage { return }
        loadingPage = true
        pageOffset += 1
        client.show(page: pageOffset) { [weak self] posts in
            self?.lastPage = posts.count < 25
            self?.listPost.append(contentsOf: posts)
            self?.loadingPage = false
            self?.postsCollectionView.reloadData()
        }
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

extension TimelineViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        if loadingPage { return }
        guard let indexPath = indexPaths.last else { return }
        let upperLimit = listPost.count - 5
        if indexPath.row > upperLimit {
            loadNextPage()
        }
    }
}
