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
    
    func getStarredRepositories(query: String) -> Promise<ListRepositories.Response> {
        networkProvider.request(.search(matching: query, sortedBy: .numberOfStars))
    }
    
    func getRecentRepositories(query: String) -> Promise<ListRepositories.Response> {
        networkProvider.request(.search(matching: query, sortedBy: .recency))
    }
    
    func getForkedRepositories(query: String) -> Promise<ListRepositories.Response> {
        networkProvider.request(.search(matching: query, sortedBy: .numberOfForks))
    }
    
}
