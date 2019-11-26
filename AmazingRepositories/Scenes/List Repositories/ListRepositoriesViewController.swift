//
//  ListRepositoriesViewController.swift
//  AmazingRepositories
//
//  Created by Leandro Romano on 25/11/19.
//  Copyright (c) 2019 Leandro Romano. All rights reserved.
//

import UIKit

protocol ListRepositoriesDisplayLogic: class {
    
}

class ListRepositoriesViewController: UITableViewController {

    var interactor: ListRepositoriesBusinessLogic?
    var router: (NSObjectProtocol & ListRepositoriesRoutingLogic & ListRepositoriesDataPassing)?

    override func loadView() {
        super.loadView()
        setup()
    }

    private func setup() {
        let viewController = self
        let interactor = ListRepositoriesInteractor()
        let presenter = ListRepositoriesPresenter()
        let router = ListRepositoriesRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
}

extension ListRepositoriesViewController: ListRepositoriesDisplayLogic {
    
}
