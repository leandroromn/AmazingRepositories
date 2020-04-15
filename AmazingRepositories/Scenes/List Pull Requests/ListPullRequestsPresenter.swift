import Foundation

protocol ListPullRequestsPresentationLogic {
    func presentRequestError()
    func presentPullRequests(_ response: [ListPullRequests.PullRequest])
    func presentRepositoryName(name: String)
    func removeLoadingState()
}

class ListPullRequestsPresenter: ListPullRequestsPresentationLogic {
    weak var viewController: ListPullRequestsDisplayLogic?

    func presentRequestError() {
        viewController?.displayRequestError()
    }

    func presentPullRequests(_ response: [ListPullRequests.PullRequest]) {
        let viewModels = response.map { ListPullRequests.ViewModel(pullRequest: $0) }
        viewController?.displayPullRequests(viewModels)
    }

    func presentRepositoryName(name: String) {
        viewController?.displayRepositoryName(name: String(format: .forRepository, name))
    }

    func removeLoadingState() {
        viewController?.removeLoadingState()
    }
}
