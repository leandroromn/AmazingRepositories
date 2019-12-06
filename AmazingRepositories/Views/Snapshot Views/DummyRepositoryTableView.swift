//
//  DummyRepositoryTableView.swift
//  AmazingRepositories
//
//  Created by Leandro Romano on 05/12/19.
//  Copyright © 2019 Leandro Romano. All rights reserved.
//

import UIKit

class DummyRepositoryTableView: UITableViewController {
    
    var dummyRepositories = [
        Repository(name: "AmazingRepositories", stars: 999, owner: Owner(name: "Romano", photo: "a-valid-photo")),
        Repository(name: "AmazingRepositories", stars: 999, owner: Owner(name: "Romano", photo: "a-valid-photo")),
        Repository(name: "AmazingRepositories", stars: 999, owner: Owner(name: "Romano", photo: "a-valid-photo")),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.separatorColor = .clear
        tableView.backgroundColor = .clear
        tableView.layer.backgroundColor = UIColor.clear.cgColor
        tableView.register(RepositoryTableViewCell.self, forCellReuseIdentifier: RepositoryTableHeaderView.identifier)
        
        view.backgroundColor = .backgroundGray
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyRepositories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryTableHeaderView.identifier) as? RepositoryTableViewCell {
            let viewModel = ListRepositories.ViewModel(repository: dummyRepositories[indexPath.row])
            cell.configure(viewModel: viewModel)
            cell.accessibilityLabel = .repositoryRow
            return cell
        }
        
        return UITableViewCell()
    }
    
}
