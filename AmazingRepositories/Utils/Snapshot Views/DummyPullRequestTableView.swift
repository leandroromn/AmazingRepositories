import UIKit

class DummyPullRequestTableView: UITableViewController {
    var dummyPullRequests = [
        ListPullRequests.PullRequest(title: "Pull Request #1",
                                     body: "This is a valid body.",
                                     user: Owner(name: "Leandro Romano", photo: "photo"),
                                     createdAt: "2020-02-21T14:54:15Z"),
        ListPullRequests.PullRequest(title: "Pull Request #2",
                                     body: "It's a \nmultine\nbody\ndescription!",
                                     user: Owner(name: "Leandro Romano", photo: "photo"),
                                     createdAt: "2020-02-21T14:54:15Z"),
        ListPullRequests.PullRequest(title: "Pull Request #3",
                                     body: nil,
                                     user: Owner(name: "Leandro Romano", photo: "photo"),
                                     createdAt: "2020-02-21T14:54:15Z"),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    private func setupTableView() {
        tableView.separatorColor = .clear
        tableView.backgroundColor = .clear
        tableView.layer.backgroundColor = UIColor.clear.cgColor
        tableView.register(ListPullRequestsTableViewCell.self,
                           forCellReuseIdentifier: ListPullRequestsTableViewCell.identifier)

        view.backgroundColor = .backgroundGray
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyPullRequests.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ListPullRequestsTableViewCell.identifier) as? ListPullRequestsTableViewCell {
            let viewModel = ListPullRequests.ViewModel(pullRequest: dummyPullRequests[indexPath.row])
            cell.configure(viewModel)
            cell.accessibilityLabel = String(format: .pullRequestDescription, viewModel.title, viewModel.userName, viewModel.createdAt)
            return cell
        }

        return UITableViewCell()
    }
}
