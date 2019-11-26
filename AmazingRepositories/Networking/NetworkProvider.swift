//
//  NetworkProvider.swift
//  AmazingRepositories
//
//  Created by Leandro Romano on 25/11/19.
//  Copyright © 2019 Leandro Romano. All rights reserved.
//

import Foundation
import PromiseKit

struct NetworkProvider {
    
    private init() { }
    
    static let shared = NetworkProvider()
    
    func request<T: Codable>(_ endpoint: Endpoint) -> Promise<T> {
        return Promise { seal in
            guard let url = endpoint.url else { return seal.reject(NetworkError.badUrl) }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data else { return seal.reject(NetworkError.emptyResponseDataError) }
                
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
                
                if 200...299 ~= statusCode {
                    do {
                        let decodableObject = try JSONDecoder().decode(T.self, from: data)
                        return seal.fulfill(decodableObject)
                    } catch {
                        return seal.reject(NetworkError.mappingError)
                    }
                }
                
                return seal.reject(self.parseErrorFor(statusCode: statusCode))
            }.resume()
        }
    }
    
    fileprivate func parseErrorFor(statusCode: Int) -> NetworkError {
        switch statusCode {
        case 401:
            return .unauthorized
        case 403:
            return .forbidden
        case 404:
            return .notFound
        default:
            return .unknownError
        }
    }
    
}
