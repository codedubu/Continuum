//
//  PostDetailTableViewController.swift
//  Continuum
//
//  Created by River McCaine on 2/2/21.
//  Copyright © 2021 trevorAdcock. All rights reserved.
//

import UIKit

class PostDetailTableViewController: UITableViewController {
    // MARK: - Outlets
    @IBOutlet weak var postImageView: UIImageView!
    
    // MARK: - Properties
    var post: Post? {
        didSet {
            loadViewIfNeeded()
            updateViews()
        }
    }
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    @IBAction func commentButtonTapped(_ sender: Any) {
        
    presentCommentAlert()
        
    }
    
    @IBAction func shareButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func followPostButtonTapped(_ sender: Any) {
        
    }
    
    // MARK: - Helper Methods
    func updateViews() {
        postImageView.image = post?.photo
        tableView.reloadData()
    }
    
    func presentCommentAlert() {
        let alertController = UIAlertController(title: "Get a post up!", message: "Show the world my guy", preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "What ya thinkin bout?"
            textField.autocorrectionType = .yes
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        let addAction = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let commentText = alertController.textFields?.first?.text, !commentText.isEmpty,
                  let post = self.post else { return }
            
            PostController.shared.addComment(post: post, text: commentText) { (comment, error) in
            }
            self.tableView.reloadData()
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(addAction)
        
        self.present(alertController, animated: true, completion: nil)
    }

// MARK: - Table view data source
override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return post?.comments.count ?? 0
}

override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath)
    let comment = post?.comments[indexPath.row]

    cell.textLabel?.text = comment?.text
    cell.detailTextLabel?.text = "\(comment?.timestamp.dateToSTring() ?? "\(Date().dateToSTring())")"
    
    return cell
}

// MARK: - Navigation
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 
}


} // END OF CLASS
