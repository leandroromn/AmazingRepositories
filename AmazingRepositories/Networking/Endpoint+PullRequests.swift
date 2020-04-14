import Foundation

extension Endpoint {
    static func pullRequests(author: String, repository: String) -> Endpoint {
        return Endpoint(path: "/repos/\(author)/\(repository)/pulls",
                        queryItems: [URLQueryItem]())
    }
}
