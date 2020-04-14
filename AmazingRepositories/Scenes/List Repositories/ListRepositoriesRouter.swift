import UIKit

@objc protocol ListRepositoriesRoutingLogic {
    func routeToPullRequests()
}

protocol ListRepositoriesDataPassing {
    var dataStore: ListRepositoriesDataStore? { get }
}

class ListRepositoriesRouter: NSObject, ListRepositoriesRoutingLogic, ListRepositoriesDataPassing {
    weak var viewController: ListRepositoriesViewController?
    var dataStore: ListRepositoriesDataStore?

    func routeToPullRequests() {
        let pullRequestsViewController = ListPullRequestsViewController()
        guard
            let dataStore = dataStore,
            let pullRequestsRouter = pullRequestsViewController.router,
            var pullRequestsDataStore = pullRequestsRouter.dataStore
        else { return }
        passDataToPullRequests(source: dataStore, destination: &pullRequestsDataStore)
        navigateToPullRequests(source: viewController, destination: pullRequestsViewController)
    }

    private func passDataToPullRequests(source: ListRepositoriesDataStore, destination: inout ListPullRequestsDataStore) {
        destination.author = source.author
        destination.repository = source.repository
    }

    private func navigateToPullRequests(source: ListRepositoriesViewController?, destination: ListPullRequestsViewController) {
        source?.present(destination, animated: true)
    }
}
