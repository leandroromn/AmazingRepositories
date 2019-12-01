//
//  ListRepositoriesPresenter.swift
//  AmazingRepositories
//
//  Created by Leandro Romano on 25/11/19.
//  Copyright (c) 2019 Leandro Romano. All rights reserved.
//

import UIKit

protocol ListRepositoriesPresentationLogic {
    func reloadTableView()
    func presentSortingTitle(currentSorting: Sorting)
}

class ListRepositoriesPresenter: ListRepositoriesPresentationLogic {

    weak var viewController: ListRepositoriesDisplayLogic?
    
    func reloadTableView() {
        viewController?.reloadTableView()
    }
    
    func presentSortingTitle(currentSorting: Sorting) {
        viewController?.displaySortingTitle(currentSorting.title)
    }
    
}
