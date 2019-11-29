//
//  Endpoint+Repositories.swift
//  AmazingRepositories
//
//  Created by Leandro Romano on 25/11/19.
//  Copyright © 2019 Leandro Romano. All rights reserved.
//

import Foundation

enum Sorting: String {
    case numberOfStars = "stars"
    case numberOfForks = "forks"
    case recency = "updated"
}

extension Endpoint {
    
    static func search(sortedBy sorting: Sorting, page: Int) -> Endpoint {
        Endpoint(
            path: "/search/repositories",
            queryItems: [
                URLQueryItem(name: "q", value: "language:swift"),
                URLQueryItem(name: "sort", value: sorting.rawValue),
                URLQueryItem(name: "per_page", value: "30"),
                URLQueryItem(name: "page", value: "\(page)")
            ]
        )
    }
    
}
