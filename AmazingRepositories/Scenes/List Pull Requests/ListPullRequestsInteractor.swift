import Foundation

protocol ListPullRequestsBusinessLogic {
    func requestPullRequests()
}

protocol ListPullRequestsDataStore {
    var author: String? { get set }
    var repository: String? { get set }
}

class ListPullRequestsInteractor: ListPullRequestsBusinessLogic, ListPullRequestsDataStore {
    var presenter: ListPullRequestsPresentationLogic?
    var worker: ListPullRequestsWorker?
    var author: String?
    var repository: String?

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
            .finally { [weak self] in
                self?.presenter?.removeLoadingState()
            }
    }

    private func handleRequestSuccess(_ response: [ListPullRequests.PullRequest]) {
        presenter?.presentPullRequests(response)
    }

    private func handleRequestFailure(_ error: Error) {
        presenter?.presentRequestError()
    }
}
