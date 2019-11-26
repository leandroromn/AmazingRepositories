//
//  ListRepositoriesInteractor.swift
//  AmazingRepositories
//
//  Created by Leandro Romano on 25/11/19.
//  Copyright (c) 2019 Leandro Romano. All rights reserved.
//

import UIKit

protocol ListRepositoriesBusinessLogic {

}

protocol ListRepositoriesDataStore {

}

class ListRepositoriesInteractor: ListRepositoriesBusinessLogic, ListRepositoriesDataStore {

    var presenter: ListRepositoriesPresentationLogic?
    var worker: ListRepositoriesWorker?
    
    init(worker: ListRepositoriesWorker = ListRepositoriesWorker()) {
        self.worker = worker
    }

}
