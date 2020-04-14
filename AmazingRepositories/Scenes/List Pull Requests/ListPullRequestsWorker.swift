import Foundation
import PromiseKit

protocol ListPullRequestsNetworkLogic {
    func searchPullRequests(author: String, repository: String) -> Promise<[ListPullRequests.PullRequest]>
}


class ListPullRequestsWorker: ListPullRequestsNetworkLogic {
    let networkProvider = NetworkProvider.shared

    func searchPullRequests(author: String, repository: String) -> Promise<[ListPullRequests.PullRequest]> {
        networkProvider.request(.pullRequests(author: author, repository: repository))
    }
}
