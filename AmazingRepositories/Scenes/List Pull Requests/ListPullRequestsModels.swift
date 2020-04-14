import Foundation

enum ListPullRequests {
    struct PullRequest: Codable {
        let title: String
        let body: String?
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
            body = pullRequest.body ?? .noDescription
            userName = pullRequest.user.name
            userPhoto = pullRequest.user.photo
            createdAt = String(format: .createdAt,
                               ViewModel.convertDate(pullRequest.createdAt) ?? "")
        }

        static func convertDate(_ date: String) -> String? {
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"

            guard let convertedDate = dateFormatterGet.date(from: date) else { return nil }
            return dateFormatter.string(from: convertedDate)
        }
    }
}
