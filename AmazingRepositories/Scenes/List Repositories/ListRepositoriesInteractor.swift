import UIKit

protocol ListRepositoriesBusinessLogic {
    var numberOfRows: Int { get }
    func cellForRow(at index: Int) -> ListRepositories.ViewModel?
    
    func requestRepositories(sortedBy sorting: Sorting)
    func filterRepositories(sortedBy sorting: Sorting)
    func requestNextPage(index: Int)
    func refreshRepositories()
    func didSelectRow(at index: Int)
}

protocol ListRepositoriesDataStore {
    var currentPage: Int { get }
    var currentSorting: Sorting { get }
    var author: String? { get }
    var repository: String? { get }
}

class ListRepositoriesInteractor: ListRepositoriesBusinessLogic, ListRepositoriesDataStore {
    var presenter: ListRepositoriesPresentationLogic?
    var worker: ListRepositoriesNetworkLogic
    var repositories = [Repository]()
    var pageSize: Int = 30
    var currentPage: Int = 1
    var currentSorting: Sorting = .numberOfStars
    var author: String?
    var repository: String?
    
    init(worker: ListRepositoriesNetworkLogic = ListRepositoriesWorker()) {
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

        if currentSorting == .numberOfForks {
            self.repositories.append(contentsOf: repositories.sorted(by: \.forks))
        } else if currentSorting == .numberOfStars {
            self.repositories.append(contentsOf: repositories.sorted(by: \.stars))
        } else {
            self.repositories.append(contentsOf: repositories)
        }
        
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
    
    func cellForRow(at index: Int) -> ListRepositories.ViewModel? {
        guard let repository = getRepositoryFromList(at: index) else { return nil }
        return ListRepositories.ViewModel(repository: repository)
    }
    
    private func resetCurrentPage() {
        currentPage = 1
    }

    func didSelectRow(at index: Int) {
        if let repository = getRepositoryFromList(at: index) {
            self.author = repository.owner.name
            self.repository = repository.name
            presenter?.presentPullRequests()
        }
    }

    private func getRepositoryFromList(at index: Int) -> Repository? {
        guard index >= 0 && index < numberOfRows else { return nil }
        return repositories[index]
    }
}
