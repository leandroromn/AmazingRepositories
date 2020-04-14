import UIKit

protocol ListPullRequestsDisplayLogic: class {

}

class ListPullRequestsViewController: UIViewController, ListPullRequestsDisplayLogic {
    var interactor: ListPullRequestsBusinessLogic?
    var router: (NSObjectProtocol & ListPullRequestsRoutingLogic & ListPullRequestsDataPassing)?

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
    }
}
