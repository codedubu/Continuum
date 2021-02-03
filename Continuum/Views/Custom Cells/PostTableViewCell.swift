//
//  PostTableViewCell.swift
//  Continuum
//
//  Created by River McCaine on 2/2/21.
//  Copyright © 2021 trevorAdcock. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postCaption: UILabel!
    @IBOutlet weak var postCommentCount: UILabel!
    
    // MARK: - Propeties
    var post: Post? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - Helper Methods
    func updateViews() {
        postImageView.image = post?.photo
        postCaption.text = post?.caption
        postCommentCount.text = "\(post?.comments.count ?? 0)"
    }
    

}
