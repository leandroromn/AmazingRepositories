//
//  NetworkError.swift
//  AmazingRepositories
//
//  Created by Leandro Romano on 25/11/19.
//  Copyright © 2019 Leandro Romano. All rights reserved.
//

enum NetworkError: Error {
    case badUrl
    case unauthorized
    case forbidden
    case notFound
    case mappingError
    case emptyResponseDataError
    case unknownError
}
