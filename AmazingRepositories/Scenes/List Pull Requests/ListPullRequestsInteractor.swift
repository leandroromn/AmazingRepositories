import Foundation

protocol ListPullRequestsBusinessLogic {
    var numberOfRows: Int { get }

    func requestPullRequests()
    func cellForRow(at index: Int) -> ListPullRequests.ViewModel?
}

protocol ListPullRequestsDataStore {
    var author: String? { get set }
    var repository: String? { get set }
}

class ListPullRequestsInteractor: ListPullRequestsBusinessLogic, ListPullRequestsDataStore {
    var presenter: ListPullRequestsPresentationLogic?
    var worker: ListPullRequestsWorker?
    var pullRequests = [ListPullRequests.PullRequest]()
    var author: String?
    var repository: String?

    var numberOfRows: Int {
        return pullRequests.count
    }

    init(worker: ListPullRequestsWorker = ListPullRequestsWorker()) {
        self.worker = worker
    }

    func requestPullRequests() {
        guard let author = author, let repository = repository else { return }
        presenter?.presentRepositoryName(name: repository)
        worker?
            .searchPullRequests(author: author, repository: repository)
            .done(handleRequestSuccess)
            .catch(handleRequestFailure)
    }

    private func handleRequestSuccess(_ response: [ListPullRequests.PullRequest]) {
        pullRequests = response
        presenter?.reloadTableView()
    }

    private func handleRequestFailure(_ error: Error) {
        print(error.localizedDescription)
    }

    func cellForRow(at index: Int) -> ListPullRequests.ViewModel? {
        guard index >= 0 && index < numberOfRows else { return nil }
        let pullRequest = pullRequests[index]
        return ListPullRequests.ViewModel(pullRequest: pullRequest)
    }
}
