//
//  RepositoryTableHeaderView.swift
//  AmazingRepositories
//
//  Created by Leandro Romano on 26/11/19.
//  Copyright © 2019 Leandro Romano. All rights reserved.
//

import UIKit

class RepositoryTableHeaderView: UIView {

    private lazy var contentView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var typeLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Starred"
        label.font = .rounded(fontSize: 30, weight: .heavy)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var repositoryLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Repositories"
        label.font = .rounded(fontSize: 30, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .veryLightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    static let identifier = "RepositoryCell"
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension RepositoryTableHeaderView: CustomViewDelegate {
    
    func setupViews() {
        addSubview(contentView)
        
        contentView.addSubview(typeLabel)
        contentView.addSubview(repositoryLabel)
        
        addSubview(separatorView)
    }
    
    func setupConstraints() {
        contentView.topAnchor.constraint(equalTo: topAnchor, constant: 24).isActive = true
        contentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
        contentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24).isActive = true
        
        typeLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        typeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        typeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        repositoryLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: -5).isActive = true
        repositoryLabel.leadingAnchor.constraint(equalTo: typeLabel.leadingAnchor).isActive = true
        repositoryLabel.trailingAnchor.constraint(equalTo: typeLabel.trailingAnchor).isActive = true
        repositoryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        separatorView.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 8).isActive = true
        separatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        separatorView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        separatorView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    func setupExtraConfigurations() {
        
    }
    
}
