import Foundation

enum ListPullRequests {
    struct PullRequest: Codable {
        let title: String
        let body: String
        let user: Owner
        let createdAt: String

        enum CodingKeys: String, CodingKey {
            case title
            case body
            case user
            case createdAt = "created_at"
        }
    }

    struct ViewModel {
        let title: String
        let body: String
        let userName: String
        let userPhoto: String
        let createdAt: String

        init(pullRequest: PullRequest) {
            title = pullRequest.title
            body = pullRequest.body
            userName = pullRequest.user.name
            userPhoto = pullRequest.user.photo
            createdAt = pullRequest.createdAt
        }
    }
}
