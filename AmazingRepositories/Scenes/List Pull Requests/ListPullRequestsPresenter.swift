import Foundation

protocol ListPullRequestsPresentationLogic {
    func reloadTableView()
    func presentRepositoryName(name: String)
}

class ListPullRequestsPresenter: ListPullRequestsPresentationLogic {
    weak var viewController: ListPullRequestsDisplayLogic?

    func reloadTableView() {
        viewController?.reloadTableView()
    }

    func presentRepositoryName(name: String) {
        viewController?.displayRepositoryName(name: name)
    }
}
