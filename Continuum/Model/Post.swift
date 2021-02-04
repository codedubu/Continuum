//
//  Post.swift
//  Continuum
//
//  Created by River McCaine on 2/2/21.
//  Copyright © 2021 trevorAdcock. All rights reserved.
//

import CloudKit
import UIKit

class Post {
    
    var photoData: Data?
    var timestamp: Date
    var caption: String
    var comments: [Comment]
    var photo: UIImage? {
        get {
            guard let photoData = photoData else { return nil }
            return UIImage(data: photoData)
        }
        set (newValue) {
            photoData  = newValue?.jpegData(compressionQuality: 0.5)
        }
    }

    init(caption: String, timestamp: Date = Date(), comments: [Comment] = [], photo: UIImage?) {
        self.caption = caption
        self.timestamp = timestamp
        self.comments = comments
        self.photo = photo

    }
    

    
} // END OF CLASS

class Comment {
    
    var text: String
    var timestamp: Date
    weak var post: Post?
    
    init(text: String, timestamp: Date = Date(), post: Post?) {
        self.text = text
        self.timestamp = timestamp
        self.post = post
    }
    
} // END OF CLASS

extension Post: SearchableRecord {
    func matches(searchTerm: String) -> Bool {
        return caption.lowercased().contains(searchTerm.lowercased()) ?  true : false
        
    }
    
    
} // END OF EXTENSION
