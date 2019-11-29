//
//  ListRepositoriesViewController.swift
//  AmazingRepositories
//
//  Created by Leandro Romano on 25/11/19.
//  Copyright (c) 2019 Leandro Romano. All rights reserved.
//

import UIKit

protocol ListRepositoriesDisplayLogic: class {
    func fetchData()
}

class ListRepositoriesViewController: UITableViewController {

    var interactor: ListRepositoriesBusinessLogic?
    var router: (NSObjectProtocol & ListRepositoriesRoutingLogic & ListRepositoriesDataPassing)?
    
    private let customRefreshControl = UIRefreshControl()
    
    override var prefersStatusBarHidden: Bool {
        true
    }

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
        
        interactor?.requestRepositories(sortedBy: .numberOfStars)
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
        tableView.tableHeaderView = RepositoryTableHeaderView()
        tableView.register(RepositoryTableViewCell.self, forCellReuseIdentifier: RepositoryTableHeaderView.identifier)
    }
    
    private func setupView() {
        view.backgroundColor = .backgroundGray
    }
    
    @objc private func refreshRepositories(_ sender: Any) {
        interactor?.requestRepositories(sortedBy: .numberOfStars)
    }
    
}

extension ListRepositoriesViewController: ListRepositoriesDisplayLogic {
    
    func fetchData() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
            self?.refreshControl?.endRefreshing()
        }
    }
    
}

extension ListRepositoriesViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interactor?.numberOfRows ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryTableHeaderView.identifier) as? RepositoryTableViewCell,
            let viewModel = interactor?.cellForRow(at: indexPath.row)
        else {
            return UITableViewCell()
        }
        
        cell.configure(viewModel: viewModel)
        
        return cell
    }
    
}

extension ListRepositoriesViewController: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            interactor?.requestNextPage(index: indexPath.row)
        }
    }
        
}
