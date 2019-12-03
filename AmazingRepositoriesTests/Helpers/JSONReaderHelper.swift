//
//  JSONReaderHelper.swift
//  AmazingRepositoriesTests
//
//  Created by Leandro Romano on 03/12/19.
//  Copyright © 2019 Leandro Romano. All rights reserved.
//

import Foundation

class JSONReaderHelper {
    
    func read<T: Decodable>(filename: String) -> T? {
        let bundle = Bundle(for: type(of: self))
        if let path = bundle.path(forResource: filename, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let result = try JSONDecoder().decode(T.self, from: data)
                return result
            } catch {
                return nil
            }
        }
        return nil
    }
    
}
