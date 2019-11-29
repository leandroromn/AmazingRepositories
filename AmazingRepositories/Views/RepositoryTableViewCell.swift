//
//  RepositoryTableViewCell.swift
//  AmazingRepositories
//
//  Created by Leandro Romano on 25/11/19.
//  Copyright © 2019 Leandro Romano. All rights reserved.
//

import UIKit
import Kingfisher

class RepositoryTableViewCell: UITableViewCell {
    
    let colours = [UIColor.lightPurple, UIColor.lightYellow]
    let primaryColor: UIColor = .lightYellow
    
    private lazy var roundedView: UIView = {
        let view = UIView()

        view.layer.cornerRadius = 14
        view.backgroundColor = primaryColor
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()
    
    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()

        label.textColor = .white
        label.font = .systemFont(ofSize: 15, weight: .heavy)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()

        label.textColor = .white
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var starsView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var starsLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = primaryColor
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
    
    func configure(viewModel: ListRepositories.ViewModel) {
        titleLabel.text = viewModel.name
        descriptionLabel.text = viewModel.ownerName
        starsLabel.text = viewModel.stars
        
        if let photoUrl = URL(string: viewModel.ownerPhoto) {
            photoImageView.kf.setImage(with: photoUrl, placeholder: UIImage())
        }
    }
    
}

extension RepositoryTableViewCell: CustomViewDelegate {
    
    func setupViews() {
        contentView.addSubview(roundedView)
        roundedView.addSubview(photoImageView)
        roundedView.addSubview(titleLabel)
        roundedView.addSubview(descriptionLabel)
        roundedView.addSubview(starsView)
        starsView.addSubview(starsLabel)
    }
    
    func setupConstraints() {
        roundedView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4).isActive = true
        roundedView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        roundedView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        roundedView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4).isActive = true
        
        photoImageView.topAnchor.constraint(equalTo: roundedView.topAnchor, constant: 16).isActive = true
        photoImageView.trailingAnchor.constraint(equalTo: roundedView.trailingAnchor, constant: -18).isActive = true
        photoImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        photoImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: photoImageView.topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: roundedView.leadingAnchor, constant: 18).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: photoImageView.leadingAnchor, constant: -16).isActive = true

        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        
        starsView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 26).isActive = true
        starsView.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor).isActive = true
        starsView.bottomAnchor.constraint(equalTo: roundedView.bottomAnchor, constant: -16).isActive = true
        
        starsLabel.topAnchor.constraint(equalTo: starsView.topAnchor, constant: 10).isActive = true
        starsLabel.leadingAnchor.constraint(equalTo: starsView.leadingAnchor, constant: 12).isActive = true
        starsLabel.trailingAnchor.constraint(equalTo: starsView.trailingAnchor, constant: -12).isActive = true
        starsLabel.bottomAnchor.constraint(equalTo: starsView.bottomAnchor, constant: -10).isActive = true
    }
    
    func setupExtraConfigurations() {
        selectionStyle = .none
    }
    
}
