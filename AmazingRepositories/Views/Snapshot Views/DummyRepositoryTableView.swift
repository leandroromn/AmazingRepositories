import UIKit

class DummyRepositoryTableView: UITableViewController {
    var dummyRepositories = [
        Repository(name: "AmazingRepositories", description: "AmazingRepositories Description", stars: 999, forks: 10, owner: Owner(name: "Romano", photo: "a-valid-photo")),
        Repository(name: "AmazingRepositories", description: "AmazingRepositories Description", stars: 999, forks: 10, owner: Owner(name: "Romano", photo: "a-valid-photo")),
        Repository(name: "AmazingRepositories", description: "AmazingRepositories Description", stars: 999, forks: 10, owner: Owner(name: "Romano", photo: "a-valid-photo")),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.separatorColor = .clear
        tableView.backgroundColor = .clear
        tableView.layer.backgroundColor = UIColor.clear.cgColor
        tableView.register(ListRepositoriesTableViewCell.self,
                           forCellReuseIdentifier: ListRepositoriesTableViewCell.identifier)
        
        view.backgroundColor = .backgroundGray
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyRepositories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ListRepositoriesTableViewCell.identifier) as? ListRepositoriesTableViewCell {
            let viewModel = ListRepositories.ViewModel(repository: dummyRepositories[indexPath.row])
            cell.configure(viewModel: viewModel)
            cell.accessibilityLabel = .repositoryRow
            return cell
        }
        
        return UITableViewCell()
    }
}
