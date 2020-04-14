import UIKit

class ListPullRequestsView: UIView, CustomViewDelegate {
    private var viewModels = [ListPullRequests.ViewModel]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.loadingIndicator.stopAnimating()
                self?.tableView.reloadData()
            }
        }
    }

    private lazy var headerView: ListPullRequestsHeaderView = {
        let view = ListPullRequestsHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorColor = .clear
        tableView.backgroundColor = .clear
        tableView.layer.backgroundColor = UIColor.clear.cgColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ListPullRequestsTableViewCell.self,
                           forCellReuseIdentifier: ListPullRequestsTableViewCell.identifier)
        return tableView
    }()

    private lazy var emptyStateView: ListPullRequestsEmptyStateView = {
        let view = ListPullRequestsEmptyStateView()
        view.backgroundColor = .clear
        view.alpha = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.color = .heavyGray
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()

    init() {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        addSubview(headerView)
        addSubview(tableView)
        addSubview(loadingIndicator)
        addSubview(emptyStateView)
    }

    func setupConstraints() {
        headerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 24).isActive = true
        headerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
        headerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24).isActive = true

        tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20).isActive = true
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        loadingIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        loadingIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        loadingIndicator.widthAnchor.constraint(equalToConstant: 40).isActive = true
        loadingIndicator.heightAnchor.constraint(equalToConstant: 40).isActive = true

        emptyStateView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        emptyStateView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        emptyStateView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        emptyStateView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }

    func setupExtraConfigurations() {
        backgroundColor = .backgroundGray
        loadingIndicator.startAnimating()
    }

    func displayPullRequests(_ viewModels: [ListPullRequests.ViewModel]) {
        if viewModels.isEmpty {
            configureEmptyState()
        } else {
            self.viewModels = viewModels
        }
    }

    private func configureEmptyState() {
        loadingIndicator.stopAnimating()
        emptyStateView.alpha = 1
    }

    func updateRepositoryName(name: String) {
        headerView.repositoryName.text = name
    }
}

extension ListPullRequestsView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListPullRequestsTableViewCell.identifier)

        if let cell = cell as? ListPullRequestsTableViewCell {
            let viewModel = viewModels[indexPath.row]
            cell.configure(viewModel)
            //cell.accessibilityLabel = .repositoryRow
            return cell
        }

        return UITableViewCell()
    }
}
