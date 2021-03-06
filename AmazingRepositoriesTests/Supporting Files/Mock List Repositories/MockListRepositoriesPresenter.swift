import Foundation
@testable import AmazingRepositories

class MockListRepositoriesPresenter: ListRepositoriesPresentationLogic {
    var hasCalledPresentLoadingState = false
    var hasCalledRemoveLoadingState = false
    var hasCalledPresentSortingTitle = false
    var hasCalledPresentError = false
    var hasCalledReloadTableView = false
    var hasCalledPresentPullRequests = false
    
    func presentLoadingState() {
        hasCalledPresentLoadingState = true
    }
    
    func removeLoadingState() {
        hasCalledRemoveLoadingState = true
    }
    
    func presentSortingTitle(currentSorting: Sorting) {
        hasCalledPresentSortingTitle = true
    }
    
    func presentError(_ error: Error) {
        hasCalledPresentError = true
    }
    
    func reloadTableView() {
        hasCalledReloadTableView = true
    }

    func presentPullRequests() {
        hasCalledPresentPullRequests = true
    }
}
