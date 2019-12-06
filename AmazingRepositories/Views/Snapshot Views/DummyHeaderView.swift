//
//  DummyHeaderView.swift
//  AmazingRepositories
//
//  Created by Leandro Romano on 05/12/19.
//  Copyright © 2019 Leandro Romano. All rights reserved.
//

import UIKit

class DummyHeaderView: UIViewController {

    private lazy var headerView: RepositoryTableHeaderView = {
        let view = RepositoryTableHeaderView()
        
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
