//
//  ReturnTypes.swift
//  AmazingRepositoriesTests
//
//  Created by Leandro Romano on 03/12/19.
//  Copyright © 2019 Leandro Romano. All rights reserved.
//

@testable import AmazingRepositories

enum ReturnTypes {
    
    case requestFailure
    case parseError
    case failure
    case success(type: Sorting, page: Int)
    
}
