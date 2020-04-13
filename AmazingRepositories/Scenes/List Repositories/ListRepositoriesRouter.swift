import UIKit

@objc protocol ListRepositoriesRoutingLogic { }

protocol ListRepositoriesDataPassing {
    var dataStore: ListRepositoriesDataStore? { get }
}

class ListRepositoriesRouter: NSObject, ListRepositoriesRoutingLogic, ListRepositoriesDataPassing {
    weak var viewController: ListRepositoriesViewController?
    var dataStore: ListRepositoriesDataStore?
}
