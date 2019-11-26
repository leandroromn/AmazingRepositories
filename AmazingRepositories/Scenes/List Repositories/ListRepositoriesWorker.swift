//
//  ListRepositoriesWorker.swift
//  AmazingRepositories
//
//  Created by Leandro Romano on 25/11/19.
//  Copyright (c) 2019 Leandro Romano. All rights reserved.
//

import Foundation
import PromiseKit

class ListRepositoriesWorker {

    let networkProvider = NetworkProvider.shared
    
    func getStarredRepositories() -> Promise<ListRepositories.Response> {
        return networkProvider.request(.search(matching: "language:swift", sortedBy: .numberOfForks))
    }
    
}
