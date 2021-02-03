//
//  PostListTableViewController.swift
//  Continuum
//
//  Created by River McCaine on 2/2/21.
//  Copyright © 2021 trevorAdcock. All rights reserved.
//

import UIKit

class PostListTableViewController: UITableViewController {
    // MARK: - Outlets
    @IBOutlet weak var postListSearchBar: UISearchBar!
    
    // MARK: - Properties
    var delegate: SearchableRecord?

    var resultsArray: [Post] = []
    var isSearching: Bool = false
    var dataSource: [SearchableRecord] {
        return isSearching ? resultsArray : PostController.shared.posts
    }
    
    
    // MARK: - Todo
    // delegate?.matches(searchTerm: caption)
    // when we have a search function, this is the job that needs to get done.

    override func viewDidLoad() {
        super.viewDidLoad()
        postListSearchBar.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        resultsArray = PostController.shared.posts
        tableView.reloadData()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return dataSource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? PostTableViewCell else { return UITableViewCell() }

        let post = resultsArray[indexPath.row]
        
        cell.post = post

        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPostDetailTableVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destinationVC = segue.destination as? PostDetailTableViewController else { return }
            
            let post = PostController.shared.posts[indexPath.row]
            destinationVC.post = post
        }
    }
    
} // END OF CLASS

extension PostListTableViewController: UISearchBarDelegate {
    
    

    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String ) {
        delegate?.matches(searchTerm: searchText)
        resultsArray = PostController.shared.posts
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        resultsArray = PostController.shared.posts
        tableView.reloadData()
        postListSearchBar.text = ""
        postListSearchBar.resignFirstResponder()
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearching = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        isSearching = false
    }
}
