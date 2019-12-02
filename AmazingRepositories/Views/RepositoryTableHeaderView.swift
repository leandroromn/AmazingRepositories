//
//  RepositoryTableHeaderView.swift
//  AmazingRepositories
//
//  Created by Leandro Romano on 26/11/19.
//  Copyright © 2019 Leandro Romano. All rights reserved.
//

import UIKit

protocol RepositoryTableHeaderViewDelegate: class {
    func changeRepositoriesFilter()
}

class RepositoryTableHeaderView: UIView {

    private lazy var contentView: UIView = {
        let view = UIView()
        
        view.alpha = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var typeLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Starred"
        label.font = .rounded(fontSize: 26, weight: .heavy)
        label.textColor = .heavyGray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var repositoryLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Repositories"
        label.font = .rounded(fontSize: 26, weight: .regular)
        label.textColor = .heavyGray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var listView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .clear
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor.veryLightGray!.cgColor
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 19
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var listImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(systemName: "list.bullet")
        imageView.tintColor = .heavyGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .veryLightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    static let identifier = "RepositoryCell"
    
    weak var delegate: RepositoryTableHeaderViewDelegate?
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        listView.layer.borderColor = UIColor.veryLightGray!.cgColor
    }
    
    func changeSortingTitle(text: String) {
        typeLabel.text = text
    }
    
    @objc private func changeFilter() {
        delegate?.changeRepositoriesFilter()
    }
    
}

extension RepositoryTableHeaderView: CustomViewDelegate {
    
    func setupViews() {
        addSubview(contentView)
        
        contentView.addSubview(listView)
        listView.addSubview(listImageView)
        contentView.addSubview(typeLabel)
        contentView.addSubview(repositoryLabel)

        addSubview(separatorView)
    }
    
    func setupConstraints() {
        contentView.topAnchor.constraint(equalTo: topAnchor, constant: 24).isActive = true
        contentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
        contentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24).isActive = true
        
        listView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        listView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        listView.widthAnchor.constraint(equalToConstant: 38).isActive = true
        listView.heightAnchor.constraint(equalToConstant: 38).isActive = true
        
        listImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        listImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        listImageView.centerXAnchor.constraint(equalTo: listView.centerXAnchor).isActive = true
        listImageView.centerYAnchor.constraint(equalTo: listView.centerYAnchor).isActive = true
        
        typeLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        typeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        typeLabel.trailingAnchor.constraint(equalTo: listView.leadingAnchor).isActive = true

        repositoryLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: -2).isActive = true
        repositoryLabel.leadingAnchor.constraint(equalTo: typeLabel.leadingAnchor).isActive = true
        repositoryLabel.trailingAnchor.constraint(equalTo: typeLabel.trailingAnchor).isActive = true
        repositoryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true

        separatorView.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 16).isActive = true
        separatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        separatorView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        separatorView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    func setupExtraConfigurations() {
        UIView.animate(
            withDuration: 0.5,
            delay: 0.01 * 1,
            animations: {
                self.contentView.alpha = 1
            }
        )
        
        listView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(changeFilter)))
    }
    
}
