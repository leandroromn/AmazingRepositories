import UIKit

class ListPullRequestsView: UIView, CustomViewDelegate {
    var interactor: ListPullRequestsBusinessLogic?

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
    }

    func setupConstraints() {
        headerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 24).isActive = true
        headerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
        headerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24).isActive = true

        tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20).isActive = true
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

    func setupExtraConfigurations() {
        backgroundColor = .backgroundGray
    }

    func reloadTableView() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }

    func updateRepositoryName(name: String) {
        headerView.repositoryName.text = "for \(name)"
    }
}

extension ListPullRequestsView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interactor?.numberOfRows ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: ListPullRequestsTableViewCell.identifier) as? ListPullRequestsTableViewCell,
            let viewModel = interactor?.cellForRow(at: indexPath.row)
        else {
            return UITableViewCell()
        }

        cell.configure(viewModel)
//        cell.accessibilityLabel = .repositoryRow

        return cell
    }
}
