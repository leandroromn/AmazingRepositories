import UIKit

class ListPullRequestsTableViewCell: UITableViewCell, CustomViewDelegate {
    static let identifier = "PullRequestCell"

    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .cellGray
        view.layer.cornerRadius = 6
        view.layer.shadowColor = UIColor.shadowGray!.cgColor
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 6
        view.layer.shadowOpacity = 0.2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .rounded(fontSize: 16, weight: .semibold)
        label.textColor = .heavyGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var bodyLabel: UILabel = {
        let label = UILabel()
        label.font = .rounded(fontSize: 14, weight: .medium)
        label.textColor = .mediumGray
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = false
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var userLabel: UILabel = {
        let label = UILabel()
        label.font = .rounded(fontSize: 14, weight: .bold)
        label.textColor = .heavyGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .rounded(fontSize: 13, weight: .regular)
        label.textColor = .mediumGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(_ model: ListPullRequests.ViewModel) {
        titleLabel.text = model.title
        bodyLabel.text = model.body
        userLabel.text = model.userName
        dateLabel.text = model.createdAt

        if let photoUrl = URL(string: model.userPhoto) {
            photoImageView.kf.setImage(with: photoUrl,
                                       placeholder: UIImage(systemName: "person.crop.circle.fill"))
        }
    }

    func setupViews() {
        contentView.addSubview(containerView)

        containerView.addSubview(titleLabel)
        containerView.addSubview(bodyLabel)
        containerView.addSubview(photoImageView)
        containerView.addSubview(userLabel)
        containerView.addSubview(dateLabel)
    }

    func setupConstraints() {
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6).isActive = true
        containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24).isActive = true
        containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6).isActive = true

        titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16).isActive = true

        bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4).isActive = true
        bodyLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        bodyLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true

        photoImageView.topAnchor.constraint(equalTo: bodyLabel.bottomAnchor, constant: 10).isActive = true
        photoImageView.leadingAnchor.constraint(equalTo: bodyLabel.leadingAnchor).isActive = true
        photoImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        photoImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        photoImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16).isActive = true

        userLabel.topAnchor.constraint(equalTo: photoImageView.topAnchor, constant: 4).isActive = true
        userLabel.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 8).isActive = true
        userLabel.trailingAnchor.constraint(equalTo: bodyLabel.trailingAnchor).isActive = true

        dateLabel.topAnchor.constraint(equalTo: userLabel.bottomAnchor).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: userLabel.leadingAnchor).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: userLabel.trailingAnchor).isActive = true
    }

    func setupExtraConfigurations() {
        backgroundColor = .clear
        selectionStyle = .none
    }
}
