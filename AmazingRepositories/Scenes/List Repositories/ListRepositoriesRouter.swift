//
//  ListRepositoriesRouter.swift
//  AmazingRepositories
//
//  Created by Leandro Romano on 25/11/19.
//  Copyright (c) 2019 Leandro Romano. All rights reserved.
//

import UIKit

@objc protocol ListRepositoriesRoutingLogic {

}

protocol ListRepositoriesDataPassing {
    var dataStore: ListRepositoriesDataStore? { get }
}

class ListRepositoriesRouter: NSObject, ListRepositoriesRoutingLogic, ListRepositoriesDataPassing {

    weak var viewController: ListRepositoriesViewController?
    var dataStore: ListRepositoriesDataStore?

}
