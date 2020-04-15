@testable import AmazingRepositories

class MockListPullRequestsPresenter: ListPullRequestsPresentationLogic {
    var hasCalledPresentRequestError = false
    var hasCalledPresentPullRequests = false
    var hasCalledPresentRepositoryName = false
    var hasCalledRemoveLoadingState = false

    func presentRequestError() {
        hasCalledPresentRequestError = true
    }

    func presentPullRequests(_ response: [ListPullRequests.PullRequest]) {
        hasCalledPresentPullRequests = true
    }

    func presentRepositoryName(name: String) {
        hasCalledPresentRepositoryName = true
    }

    func removeLoadingState() {
        hasCalledRemoveLoadingState = true
    }
}
