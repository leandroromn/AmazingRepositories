import UIKit

class DummyHeaderView: UIViewController {
    private lazy var headerView: ListRepositoriesTableHeaderView = {
        let view = ListRepositoriesTableHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeaderView()
        view.backgroundColor = .backgroundGray
    }
    
    func setupHeaderView() {
        view.addSubview(headerView)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
}
