//
//  UIAlertController.swift
//  Continuum
//
//  Created by River McCaine on 2/2/21.
//  Copyright © 2021 trevorAdcock. All rights reserved.
//

import UIKit

extension UITableViewController {
    func presentPostErrorToUser(textAlert: String) {
        
        let alertController = UIAlertController(title: "Hey, listen!", message: textAlert, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Ok", style: .cancel)
        alertController.addAction(dismissAction)
        present(alertController, animated: true)
    }

}

