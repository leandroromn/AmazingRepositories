//
//  ListRepositoriesInteractor.swift
//  AmazingRepositories
//
//  Created by Leandro Romano on 25/11/19.
//  Copyright (c) 2019 Leandro Romano. All rights reserved.
//

import UIKit

protocol ListRepositoriesBusinessLogic {
    var numberOfRows: Int { get }
    
    func requestStarredRepositories()
    func cellForRow(at index: Int) -> ListRepositories.ViewModel
}

protocol ListRepositoriesDataStore {

}

class ListRepositoriesInteractor: ListRepositoriesBusinessLogic, ListRepositoriesDataStore {

    var presenter: ListRepositoriesPresentationLogic?
    var worker: ListRepositoriesWorker?
    var repositories = [Repository]()
    
    init(worker: ListRepositoriesWorker = ListRepositoriesWorker()) {
        self.worker = worker
    }
    
    var numberOfRows: Int {
        return repositories.count
    }
    
    func requestStarredRepositories() {
        worker?.getStarredRepositories(query: "language:swift").done(handleRequestSuccess).catch(handleRequestFailure)
    }
    
    private func handleRequestSuccess(_ response: ListRepositories.Response) {
        guard let repositories = response.repositories else { return }
        self.repositories = repositories
        presenter?.fetchData()
    }
    
    private func handleRequestFailure(_ error: Error) {
        print(error.localizedDescription)
    }
    
    func cellForRow(at index: Int) -> ListRepositories.ViewModel {
        let repository = repositories[index]
        return ListRepositories.ViewModel(repository: repository)
    }

}
