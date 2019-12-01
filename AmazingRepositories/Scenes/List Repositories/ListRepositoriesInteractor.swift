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
    func cellForRow(at index: Int) -> ListRepositories.ViewModel
    
    func requestRepositories(sortedBy sorting: Sorting)
    func filterRepositories(sortedBy sorting: Sorting)
    func requestNextPage(index: Int)
    func refreshRepositories()
}

protocol ListRepositoriesDataStore {
    var currentPage: Int { get }
    var currentSorting: Sorting { get }
}

class ListRepositoriesInteractor: ListRepositoriesBusinessLogic, ListRepositoriesDataStore {

    var presenter: ListRepositoriesPresentationLogic?
    var worker: ListRepositoriesWorker
    var repositories = [Repository]()
    var pageSize: Int = 30
    var currentPage: Int = 1
    var currentSorting: Sorting = .numberOfStars
    
    init(worker: ListRepositoriesWorker = ListRepositoriesWorker()) {
        self.worker = worker
    }
    
    var numberOfRows: Int {
        repositories.count
    }
    
    func requestRepositories(sortedBy sorting: Sorting) {
        currentSorting = sorting
        worker
            .searchRepositories(sortedBy: sorting, page: currentPage)
            .done(handleRequestSuccess)
            .catch(handleRequestFailure)
            .finally { [weak self] in
                self?.presenter?.removeLoadingState()
            }
    }
    
    func filterRepositories(sortedBy sorting: Sorting) {
        resetCurrentPage()
        repositories.removeAll(keepingCapacity: true)
        
        presenter?.presentLoadingState()
        requestRepositories(sortedBy: sorting)
    }
    
    private func handleRequestSuccess(_ response: ListRepositories.Response) {
        guard let repositories = response.repositories else { return }
        self.repositories.append(contentsOf: repositories.sorted(by: >))
        
        presenter?.presentSortingTitle(currentSorting: currentSorting)
        presenter?.reloadTableView()
    }
    
    private func handleRequestFailure(_ error: Error) {
        presenter?.presentError(error)
    }
    
    func requestNextPage(index: Int) {
        let targetCount = currentPage < 0 ? 1 : currentPage * pageSize - 10
        if index != targetCount { return }
        currentPage += 1
        requestRepositories(sortedBy: currentSorting)
    }
    
    func refreshRepositories() {
        resetCurrentPage()
        requestRepositories(sortedBy: currentSorting)
    }
    
    func cellForRow(at index: Int) -> ListRepositories.ViewModel {
        let repository = repositories[index]
        return ListRepositories.ViewModel(repository: repository)
    }
    
    private func resetCurrentPage() {
        currentPage = 0
    }

}
