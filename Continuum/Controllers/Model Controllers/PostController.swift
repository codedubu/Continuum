//
//  PostController.swift
//  Continuum
//
//  Created by River McCaine on 2/2/21.
//  Copyright © 2021 trevorAdcock. All rights reserved.
//

import UIKit

class PostController {
    // MARK: - Properties
    static let shared = PostController()
    var posts: [Post] = []
    var comments: [Comment] = []
    
    // MARK: - CRUD Methods
    func createPostWith(image: UIImage, caption: String, completion: @escaping(Result<Post?, PostError>) -> Void) {
        let newPost = Post(caption: caption, photo: image)
        posts.append(newPost)
    }
    
    func addComment(post: Post, text: String, completion: @escaping(Comment, PostError) -> Void) {
        let newComment = Comment(text: text, post: post)
        post.comments.append(newComment)
    }
    
} // END OF CLASS 
