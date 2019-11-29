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
    
    let primaryColor: UIColor = .black
    
    private lazy var secureView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .white
        view.layer.cornerRadius = 6
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 6
        view.layer.shadowOpacity = 0.2
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var repositoryPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.layer.masksToBounds = false
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var repositoryNameLabel: UILabel = {
        let label = UILabel()
        
        label.font = .rounded(fontSize: 13, weight: .semibold)
        label.textColor = UIColor(red:0.44, green:0.44, blue:0.51, alpha:1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var repositoryOwnerLabel: UILabel = {
        let label = UILabel()
        
        label.font = .rounded(fontSize: 13, weight: .regular)
        label.textColor = UIColor(red:0.70, green:0.70, blue:0.72, alpha:1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var repositoryStarsAmountLabel: UILabel = {
        let label = UILabel()
        
        label.font = .rounded(fontSize: 13, weight: .bold)
        label.textColor = .darkGray
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var repositoryStarsLabel: UILabel = {
        let label = UILabel()
        
        label.text = "stars"
        label.font = .rounded(fontSize: 12, weight: .regular)
        label.textColor = .lightGray
        label.textAlignment = .center
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
        repositoryNameLabel.text = viewModel.name
        repositoryOwnerLabel.text = viewModel.ownerName
        repositoryStarsAmountLabel.text = viewModel.stars
        
        if let photoUrl = URL(string: viewModel.ownerPhoto) {
            repositoryPhotoImageView.kf.setImage(with: photoUrl, placeholder: UIImage())
        }
    }
    
}

extension RepositoryTableViewCell: CustomViewDelegate {
    
    func setupViews() {
        contentView.addSubview(secureView)
        
        secureView.addSubview(repositoryPhotoImageView)
        secureView.addSubview(repositoryNameLabel)
        secureView.addSubview(repositoryOwnerLabel)
        secureView.addSubview(repositoryStarsAmountLabel)
        secureView.addSubview(repositoryStarsLabel)
    }
    
    func setupConstraints() {
        secureView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6).isActive = true
        secureView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .leading).isActive = true
        secureView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: .trailing).isActive = true
        secureView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6).isActive = true
        
        repositoryPhotoImageView.topAnchor.constraint(equalTo: secureView.topAnchor, constant: 16).isActive = true
        repositoryPhotoImageView.leadingAnchor.constraint(equalTo: secureView.leadingAnchor, constant: 16).isActive = true
        repositoryPhotoImageView.bottomAnchor.constraint(equalTo: secureView.bottomAnchor, constant: -16).isActive = true
        repositoryPhotoImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        repositoryPhotoImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        repositoryStarsAmountLabel.topAnchor.constraint(equalTo: repositoryPhotoImageView.topAnchor).isActive = true
        repositoryStarsAmountLabel.trailingAnchor.constraint(equalTo: secureView.trailingAnchor, constant: -16).isActive = true
        
        repositoryStarsLabel.topAnchor.constraint(equalTo: repositoryStarsAmountLabel.bottomAnchor).isActive = true
        repositoryStarsLabel.leadingAnchor.constraint(equalTo: repositoryStarsAmountLabel.leadingAnchor).isActive = true
        repositoryStarsLabel.trailingAnchor.constraint(equalTo: repositoryStarsAmountLabel.trailingAnchor).isActive = true
        repositoryStarsLabel.bottomAnchor.constraint(equalTo: repositoryPhotoImageView.bottomAnchor).isActive = true
        
        repositoryNameLabel.topAnchor.constraint(equalTo: repositoryPhotoImageView.topAnchor, constant: 2).isActive = true
        repositoryNameLabel.leadingAnchor.constraint(equalTo: repositoryPhotoImageView.trailingAnchor, constant: 16).isActive = true
        repositoryNameLabel.trailingAnchor.constraint(equalTo: repositoryStarsAmountLabel.leadingAnchor).isActive = true
        
        repositoryOwnerLabel.topAnchor.constraint(equalTo: repositoryNameLabel.bottomAnchor, constant: 2).isActive = true
        repositoryOwnerLabel.leadingAnchor.constraint(equalTo: repositoryNameLabel.leadingAnchor).isActive = true
        repositoryOwnerLabel.trailingAnchor.constraint(equalTo: repositoryNameLabel.trailingAnchor).isActive = true
    }
    
    func setupExtraConfigurations() {
        selectionStyle = .none
        backgroundColor = .clear
    }
    
}
