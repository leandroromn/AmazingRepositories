//
//  UIViewController+Alerts.swift
//  AmazingRepositories
//
//  Created by Leandro Romano on 01/12/19.
//  Copyright © 2019 Leandro Romano. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func displayLoadingAlert() {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
            alert.view.addSubview(LoadingActivityIndicator())
            self?.present(alert, animated: true)
        }
    }
    
    func displayErrorAlert(errorMessage: String, action: EmptyClosure?) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) { [weak self] in
            let alert = UIAlertController(title: "Error", message: "There's a problem to display the repositories.\n\n\(errorMessage)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Try again", style: .default) { _ in
                action?()
            })
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            self?.present(alert, animated: true)
        }
    }
    
}
