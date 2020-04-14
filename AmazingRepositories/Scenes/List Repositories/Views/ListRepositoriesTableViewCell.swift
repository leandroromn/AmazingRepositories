import UIKit
import Kingfisher

class ListRepositoriesTableViewCell: UITableViewCell {
    let primaryColor: UIColor = .black
    static let identifier = "RepositoryCell"
    
    private lazy var secureView: UIView = {
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
    
    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = false
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .rounded(fontSize: 18, weight: .semibold)
        label.textColor = .heavyGray
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .rounded(fontSize: 16, weight: .medium)
        label.textColor = .mediumGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var ownerLabel: UILabel = {
        let label = UILabel()
        label.font = .rounded(fontSize: 16, weight: .regular)
        label.textColor = .mediumGray
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var informationView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var starsAmountLabel: UILabel = {
        let label = UILabel()
        label.font = .rounded(fontSize: 13, weight: .bold)
        label.textColor = .heavyGray
        label.textAlignment = .right
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var forksAmountLabel: UILabel = {
        let label = UILabel()
        label.font = .rounded(fontSize: 13, weight: .bold)
        label.textColor = .heavyGray
        label.textAlignment = .right
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var starsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "star")
        imageView.tintColor = .heavyGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var forksImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "fork")
        imageView.tintColor = .heavyGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(viewModel: ListRepositories.ViewModel) {
        nameLabel.text = viewModel.name
        descriptionLabel.text = viewModel.description
        ownerLabel.text = viewModel.ownerName
        starsAmountLabel.text = viewModel.stars
        forksAmountLabel.text = viewModel.forks
        
        if let photoUrl = URL(string: viewModel.ownerPhoto) {
            photoImageView.kf.setImage(with: photoUrl,
                                       placeholder: UIImage(systemName: "person.crop.circle.fill"))
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        secureView.layer.shadowColor = UIColor.shadowGray!.cgColor
    }
}

extension ListRepositoriesTableViewCell: CustomViewDelegate {
    func setupViews() {
        contentView.addSubview(secureView)
        
        secureView.addSubview(photoImageView)
        secureView.addSubview(nameLabel)
        secureView.addSubview(descriptionLabel)
        secureView.addSubview(ownerLabel)
        secureView.addSubview(informationView)

        informationView.addSubview(starsImageView)
        informationView.addSubview(starsAmountLabel)
        informationView.addSubview(forksImageView)
        informationView.addSubview(forksAmountLabel)
    }
    
    func setupConstraints() {
        secureView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6).isActive = true
        secureView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24).isActive = true
        secureView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24).isActive = true
        secureView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6).isActive = true
        
        photoImageView.topAnchor.constraint(equalTo: secureView.topAnchor, constant: 16).isActive = true
        photoImageView.trailingAnchor.constraint(equalTo: secureView.trailingAnchor, constant: -16).isActive = true
        photoImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        photoImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo: photoImageView.topAnchor, constant: 2).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: secureView.leadingAnchor, constant: 16).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: photoImageView.leadingAnchor, constant: -16).isActive = true

        descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 6).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor).isActive = true
        
        ownerLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 6).isActive = true
        ownerLabel.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor).isActive = true
        ownerLabel.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor).isActive = true

        informationView.topAnchor.constraint(equalTo: ownerLabel.bottomAnchor, constant: 10).isActive = true
        informationView.leadingAnchor.constraint(equalTo: secureView.leadingAnchor, constant: 16).isActive = true
        informationView.trailingAnchor.constraint(equalTo: secureView.trailingAnchor, constant: -16).isActive = true
        informationView.bottomAnchor.constraint(equalTo: secureView.bottomAnchor, constant: -16).isActive = true

        starsImageView.topAnchor.constraint(equalTo: informationView.topAnchor).isActive = true
        starsImageView.leadingAnchor.constraint(equalTo: informationView.leadingAnchor).isActive = true
        starsImageView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        starsImageView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        starsImageView.bottomAnchor.constraint(equalTo: informationView.bottomAnchor).isActive = true

        starsAmountLabel.leadingAnchor.constraint(equalTo: starsImageView.trailingAnchor, constant: 4).isActive = true
        starsAmountLabel.centerYAnchor.constraint(equalTo: starsImageView.centerYAnchor, constant: 1).isActive = true

        forksImageView.topAnchor.constraint(equalTo: informationView.topAnchor).isActive = true
        forksImageView.leadingAnchor.constraint(equalTo: starsAmountLabel.trailingAnchor, constant: 16).isActive = true
        forksImageView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        forksImageView.heightAnchor.constraint(equalToConstant: 16).isActive = true

        forksAmountLabel.leadingAnchor.constraint(equalTo: forksImageView.trailingAnchor, constant: 4).isActive = true
        forksAmountLabel.centerYAnchor.constraint(equalTo: forksImageView.centerYAnchor).isActive = true
    }
    
    func setupExtraConfigurations() {
        backgroundColor = .clear
    }
}
