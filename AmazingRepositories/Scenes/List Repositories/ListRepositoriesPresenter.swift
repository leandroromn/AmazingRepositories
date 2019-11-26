//
//  ListRepositoriesPresenter.swift
//  AmazingRepositories
//
//  Created by Leandro Romano on 25/11/19.
//  Copyright (c) 2019 Leandro Romano. All rights reserved.
//

import UIKit

protocol ListRepositoriesPresentationLogic {
    func fetchData()
}

class ListRepositoriesPresenter: ListRepositoriesPresentationLogic {

    weak var viewController: ListRepositoriesDisplayLogic?
    
    func fetchData() {
        viewController?.fetchData()
    }
    
}
