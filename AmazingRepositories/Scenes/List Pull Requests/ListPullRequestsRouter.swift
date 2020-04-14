import UIKit

@objc protocol ListPullRequestsRoutingLogic { }

protocol ListPullRequestsDataPassing {
    var dataStore: ListPullRequestsDataStore? { get }
}

class ListPullRequestsRouter: NSObject, ListPullRequestsRoutingLogic, ListPullRequestsDataPassing {
    weak var viewController: ListPullRequestsViewController?
    var dataStore: ListPullRequestsDataStore?
}
