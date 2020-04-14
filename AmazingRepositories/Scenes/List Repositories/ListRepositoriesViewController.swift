import UIKit

protocol ListRepositoriesDisplayLogic: class {
    func displayLoadingState()
    func removeLoadingState()
    func displaySortingTitle(_ title: String)
    func displayError(_ errorMessage: String)
    func reloadTableView()
    func displayPullRequests()
}

class ListRepositoriesViewController: UITableViewController {
    var interactor: ListRepositoriesBusinessLogic?
    var router: (NSObjectProtocol & ListRepositoriesRoutingLogic & ListRepositoriesDataPassing)?
    
    private let customRefreshControl = UIRefreshControl()

    override func loadView() {
        super.loadView()
        setup()
    }

    private func setup() {
        let viewController = self
        let interactor = ListRepositoriesInteractor()
        let presenter = ListRepositoriesPresenter()
        let router = ListRepositoriesRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        if let headerView = tableView.tableHeaderView {
            let height = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
            var headerFrame = headerView.frame
            if height != headerFrame.size.height {
                headerFrame.size.height = height
                headerView.frame = headerFrame
                tableView.tableHeaderView = headerView
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupRefreshControl()
        setupView()

        interactor?.filterRepositories(sortedBy: .numberOfStars)
    }
    
    private func setupRefreshControl() {
        refreshControl = customRefreshControl
        refreshControl?.addTarget(self, action: #selector(refreshRepositories), for: .valueChanged)
    }
    
    private func setupTableView() {
        tableView.prefetchDataSource = self
        tableView.separatorColor = .clear
        tableView.backgroundColor = .clear
        tableView.layer.backgroundColor = UIColor.clear.cgColor
        tableView.refreshControl = customRefreshControl
        tableView.register(ListRepositoriesTableViewCell.self,
                           forCellReuseIdentifier: ListRepositoriesTableViewCell.identifier)
        
        let tableHeaderView = ListRepositoriesTableHeaderView()
        tableHeaderView.delegate = self
        tableView.tableHeaderView = tableHeaderView
    }
    
    private func setupView() {
        view.backgroundColor = .backgroundGray
    }
    
    @objc func refreshRepositories(_ sender: Any) {
        interactor?.requestRepositories(sortedBy: .numberOfStars)
    }
}

extension ListRepositoriesViewController: ListRepositoriesDisplayLogic {
    func displayLoadingState() {
        displayLoadingAlert()
    }
    
    func removeLoadingState() {
        DispatchQueue.main.async { [weak self] in
            if let vc = self?.presentedViewController, vc is UIAlertController {
                vc.dismiss(animated: true)
            }
        }
    }
    
    func displaySortingTitle(_ title: String) {
        DispatchQueue.main.async { [weak self] in
            let tableHeaderView = self?.tableView.tableHeaderView as? ListRepositoriesTableHeaderView
            tableHeaderView?.changeSortingTitle(text: title)
        }
    }
    
    func displayError(_ errorMessage: String) {
        removeLoadingState()
        displayErrorAlert(errorMessage: errorMessage, action: interactor?.refreshRepositories)
    }
    
    func reloadTableView() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
            self?.refreshControl?.endRefreshing()
        }
    }

    func displayPullRequests() {
        router?.routeToPullRequests()
    }
}

extension ListRepositoriesViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interactor?.numberOfRows ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: ListRepositoriesTableViewCell.identifier) as? ListRepositoriesTableViewCell,
            let viewModel = interactor?.cellForRow(at: indexPath.row)
        else {
            return UITableViewCell()
        }
        
        cell.configure(viewModel: viewModel)
        cell.accessibilityLabel = .repositoryRow
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor?.didSelectRow(at: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ListRepositoriesViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            interactor?.requestNextPage(index: indexPath.row)
        }
    }
}

extension ListRepositoriesViewController: ListRepositoriesTableHeaderViewDelegate {
    func changeRepositoriesFilter() {
        let alert = UIAlertController(title: .filterTitle, message: .filterDescription, preferredStyle: .actionSheet)
        alert.accessibilityLabel = .repositoriesFilterAlert
        
        alert.addAction(UIAlertAction(title: .recency, style: .default) { [weak self] _ in
            self?.interactor?.filterRepositories(sortedBy: .recency)
        })
        
        alert.addAction(UIAlertAction(title: .numberOfStars, style: .default) { [weak self] _ in
            self?.interactor?.filterRepositories(sortedBy: .numberOfStars)
        })
        
        alert.addAction(UIAlertAction(title: .numberOfForks, style: .default) { [weak self] _ in
            self?.interactor?.filterRepositories(sortedBy: .numberOfForks)
        })
        
        alert.addAction(UIAlertAction(title: .cancel, style: .cancel))
        
        present(alert, animated: true)
    }
}
