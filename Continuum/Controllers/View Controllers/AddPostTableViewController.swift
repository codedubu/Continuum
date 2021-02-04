//
//  AddPostTableViewController.swift
//  Continuum
//
//  Created by River McCaine on 2/2/21.
//  Copyright © 2021 trevorAdcock. All rights reserved.
//

import UIKit

class AddPostTableViewController: UITableViewController {
    // MARK: - Outlets
    @IBOutlet weak var selectImageButton: UIButton!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postCaptionTextField: UITextField!
    
    // MARK: - Properties
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        postCaptionTextField.text = ""
        selectImageButton.setTitle("Select Image", for: .normal)
        postImageView.image = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    // MARK: - Actions
    @IBAction func selectImageButtonTapped(_ sender: Any) {
        
//        postImageView.image = UIImage(named: "spaceEmptyState")
        selectImageButton.setTitle("", for: .normal)

        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.mediaTypes = ["public.image"]
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Take photo", style: .default, handler: { (action: UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            } else {
                self.presentPostErrorToUser(textAlert: "Unable to take photo without camera!")
            }
        }))

        actionSheet.addAction(UIAlertAction(title: "Choose photo from your library", style: .default, handler: { (action: UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)

        }))

//        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//        if postImageView.image != nil {
//            actionSheet.addAction(UIAlertAction(title: "Remove Photo", style: .destructive, handler: { (_ action: UIAlertAction) in
//                self.postImageView = nil
//            }))
//        }
        present(actionSheet, animated: true, completion: nil)
    }
    
   
    
    @IBAction func addPostButtonTapped(_ sender: Any) {
//        guard let caption = postCaptionTextField.text, !caption.isEmpty else { return }
        if let postImage = postImageView.image, let caption = postCaptionTextField.text, !caption.isEmpty {
       
            PostController.shared.createPostWith(image: postImage, caption: caption) { (_) in
            }
            self.tabBarController?.selectedIndex = 0
            
        } else if postImageView.image == nil , let caption = postCaptionTextField.text, !caption.isEmpty {
            presentPostErrorToUser(textAlert:"You need to add an image!!")
            
        } else if postImageView.image != nil , let caption = postCaptionTextField.text, caption.isEmpty{
            presentPostErrorToUser(textAlert:"You need add a caption!!")
            
        } else {
            presentPostErrorToUser(textAlert: "You need to add both you fool!")
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.tabBarController?.selectedIndex = 0
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    
} // END OF CLASS


extension AddPostTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            postImageView.image = image
            dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
