//
//  CustomViewDelegate.swift
//  AmazingRepositories
//
//  Created by Leandro Romano on 25/11/19.
//  Copyright © 2019 Leandro Romano. All rights reserved.
//

import Foundation

protocol CustomViewDelegate {
    func setupViews()
    func setupConstraints()
    func setupExtraConfigurations()
    func setup()
}

extension CustomViewDelegate {
    func setup() {
        setupViews()
        setupConstraints()
        setupExtraConfigurations()
    }
}
