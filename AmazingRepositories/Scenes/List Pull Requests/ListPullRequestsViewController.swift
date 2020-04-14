import UIKit

protocol ListPullRequestsDisplayLogic: class {
    func displayRequestError()
    func displayRepositoryName(name: String)
    func displayPullRequests(_ viewModels: [ListPullRequests.ViewModel])
    func removeLoadingState()
}

class ListPullRequestsViewController: UIViewController {
    var interactor: ListPullRequestsBusinessLogic?
    var router: (NSObjectProtocol & ListPullRequestsRoutingLogic & ListPullRequestsDataPassing)?
    var contentView: ListPullRequestsView = ListPullRequestsView()

    override func loadView() {
        super.loadView()
        view = contentView
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        let viewController = self
        let interactor = ListPullRequestsInteractor()
        let presenter = ListPullRequestsPresenter()
        let router = ListPullRequestsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.requestPullRequests()
    }
}

extension ListPullRequestsViewController: ListPullRequestsDisplayLogic {
    func displayRequestError() {
        contentView.configureErrorState()
    }

    func displayRepositoryName(name: String) {
        contentView.updateRepositoryName(name: name)
    }

    func displayPullRequests(_ viewModels: [ListPullRequests.ViewModel]) {
        contentView.displayPullRequests(viewModels)
    }

    func removeLoadingState() {
        contentView.removeLoadingState()
    }
}
