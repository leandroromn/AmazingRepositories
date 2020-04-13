@testable import AmazingRepositories

enum ReturnTypes {
    case requestFailure
    case parseError
    case failure
    case success(type: Sorting, page: Int)
}
