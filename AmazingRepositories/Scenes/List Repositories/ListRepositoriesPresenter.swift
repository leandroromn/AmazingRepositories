//
//  ListRepositoriesPresenter.swift
//  AmazingRepositories
//
//  Created by Leandro Romano on 25/11/19.
//  Copyright (c) 2019 Leandro Romano. All rights reserved.
//

import UIKit

protocol ListRepositoriesPresentationLogic {
    func presentLoadingState()
    func removeLoadingState()
    func presentSortingTitle(currentSorting: Sorting)
    func presentError(_ error: Error)
    func reloadTableView()
}

class ListRepositoriesPresenter: ListRepositoriesPresentationLogic {

    weak var viewController: ListRepositoriesDisplayLogic?
    
    func presentLoadingState() {
        viewController?.displayLoadingState()
    }
    
    func removeLoadingState() {
        viewController?.removeLoadingState()
    }
    
    func presentSortingTitle(currentSorting: Sorting) {
        viewController?.displaySortingTitle(currentSorting.title)
    }
    
    func presentError(_ error: Error) {
        viewController?.displayError(error.localizedDescription)
    }
    
    func reloadTableView() {
        viewController?.reloadTableView()
    }
    
}
