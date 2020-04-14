import Foundation

enum ListRepositories {
    struct Response: Codable {
        let repositories: [Repository]?
        
        enum CodingKeys: String, CodingKey {
            case repositories = "items"
        }
    }
    
    struct ViewModel {
        let name: String
        let description: String
        let stars: String
        let forks: String
        let ownerName: String
        let ownerPhoto: String
        
        init(repository: Repository) {
            self.name = repository.name
            self.description = repository.description ?? .noDescription
            self.stars = repository.stars.abbrevation
            self.forks = repository.forks.abbrevation
            self.ownerName = "\(String.createdBy) \(repository.owner.name)"
            self.ownerPhoto = repository.owner.photo
        }
    }
}

struct Repository: Codable, Comparable {
    let name: String
    let description: String?
    let stars: Int
    let forks: Int
    let owner: Owner
    
    enum CodingKeys: String, CodingKey {
        case name
        case description
        case stars = "stargazers_count"
        case forks = "forks_count"
        case owner
    }
    
    static func < (lhs: Repository, rhs: Repository) -> Bool {
        lhs.stars < rhs.stars
    }
    
    static func == (lhs: Repository, rhs: Repository) -> Bool {
        lhs.stars == rhs.stars
    }
}

struct Owner: Codable {
    let name: String
    let photo: String
    
    enum CodingKeys: String, CodingKey {
        case name = "login"
        case photo = "avatar_url"
    }
}
