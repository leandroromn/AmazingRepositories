import PromiseKit

@testable import AmazingRepositories

class MockListPullRequestsWorker: ListPullRequestsNetworkLogic {
    var returnType: ReturnTypes = .success(type: .numberOfStars, page: 1)

    func searchPullRequests(author: String, repository: String) -> Promise<[ListPullRequests.PullRequest]> {
        switch returnType {
        case .success(_, _):
            var pullRequests = [ListPullRequests.PullRequest]()
            pullRequests.append(ListPullRequests.PullRequest(title: "a-valid-title",
                                                             body: "a-valid-body",
                                                             user: Owner(name: "name", photo: "photo"),
                                                             createdAt: "a-valid-date"))
            pullRequests.append(ListPullRequests.PullRequest(title: "a-valid-title",
                                                             body: "a-valid-body",
                                                             user: Owner(name: "name", photo: "photo"),
                                                             createdAt: "a-valid-date"))
            pullRequests.append(ListPullRequests.PullRequest(title: "a-valid-title",
                                                             body: "a-valid-body",
                                                             user: Owner(name: "name", photo: "photo"),
                                                             createdAt: "a-valid-date"))
            return Promise { seal in seal.fulfill(pullRequests) }
        case .failure:
            return Promise { seal in seal.reject(NetworkError.unknownError) }
        default:
            return Promise { seal in seal.reject(NetworkError.unknownError) }
        }
    }
}
