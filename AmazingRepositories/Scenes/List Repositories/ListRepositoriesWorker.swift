import Foundation
import PromiseKit

protocol ListRepositoriesNetworkLogic {
    func searchRepositories(sortedBy sorting: Sorting, page: Int) -> Promise<ListRepositories.Response>
}

class ListRepositoriesWorker: ListRepositoriesNetworkLogic {
    let networkProvider = NetworkProvider.shared
    
    func searchRepositories(sortedBy sorting: Sorting, page: Int) -> Promise<ListRepositories.Response> {
        networkProvider.request(.search(sortedBy: sorting, page: page))
    }
}
