//
//  ListRepositoriesModels.swift
//  AmazingRepositories
//
//  Created by Leandro Romano on 25/11/19.
//  Copyright (c) 2019 Leandro Romano. All rights reserved.
//

import Foundation

enum ListRepositories {

    struct Response: Codable {
        
        let repositories: [Repository]?
        
        enum CodingKeys: String, CodingKey {
            case repositories = "items"
        }
        
    }
    
}

struct Repository: Codable {
    
    let name: String
    let stars: Int
    let owner: Owner
    
    enum CodingKeys: String, CodingKey {
        case name
        case stars = "stargazers_count"
        case owner
    }
    
}

struct Owner: Codable {
    
    let name: String
    let photo: String
    
    enum CodingKeys: String, CodingKey {
        case name = "login"
        case photo = "avatar_url"
    }
    
}
