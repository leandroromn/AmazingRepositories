import Foundation
import PromiseKit
@testable import AmazingRepositories

class MockListRepositoriesWorker: ListRepositoriesNetworkLogic {
    var returnType: ReturnTypes = .success(type: .numberOfStars, page: 1)
    
    func searchRepositories(sortedBy sorting: Sorting, page: Int) -> Promise<ListRepositories.Response> {
        switch returnType {
        case .success(let sorting, let page):
            let helper = JSONReaderHelper()
            if let response: ListRepositories.Response = helper.read(filename: "repositories-\(sorting.rawValue)-page-\(page)") {
                return Promise { seal in seal.fulfill(response) }
            } else {
                return Promise { seal in seal.reject(NetworkError.mappingError) }
            }
        case .failure:
            return Promise { seal in seal.reject(NetworkError.emptyResponseDataError) }
        case .parseError:
            return Promise { seal in seal.reject(NetworkError.mappingError) }
        case .requestFailure:
            return Promise { seal in seal.reject(NetworkError.badUrl) }
        }
    }
}
