import Foundation

protocol ListPullRequestsPresentationLogic {
    func presentPullRequests(_ response: [ListPullRequests.PullRequest])
    func presentRepositoryName(name: String)
}

class ListPullRequestsPresenter: ListPullRequestsPresentationLogic {
    weak var viewController: ListPullRequestsDisplayLogic?

    func presentPullRequests(_ response: [ListPullRequests.PullRequest]) {
        let viewModels = response.map { return ListPullRequests.ViewModel(pullRequest: $0) }
        viewController?.displayPullRequests(viewModels)
    }

    func presentRepositoryName(name: String) {
        viewController?.displayRepositoryName(name: String(format: .forRepository, name))
    }
}
