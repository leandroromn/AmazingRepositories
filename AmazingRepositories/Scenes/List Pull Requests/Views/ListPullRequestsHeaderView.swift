import UIKit

class ListPullRequestsHeaderView: UIView, CustomViewDelegate {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .rounded(fontSize: 20, weight: .heavy)
        label.textColor = .heavyGray
        label.text = "Pull Requests"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var repositoryName: UILabel = {
        let label = UILabel()
        label.font = .rounded(fontSize: 20, weight: .regular)
        label.textColor = .heavyGray
        label.text = "for AmazingRepositories"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(titleLabel)
        addSubview(repositoryName)
    }

    func setupConstraints() {
        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true

        repositoryName.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        repositoryName.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        repositoryName.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        repositoryName.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

    func setupExtraConfigurations() {}
}
