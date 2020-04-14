import Foundation

protocol ListPullRequestsBusinessLogic {
    
}

protocol ListPullRequestsDataStore {
    
}

class ListPullRequestsInteractor: ListPullRequestsBusinessLogic, ListPullRequestsDataStore {
    var presenter: ListPullRequestsPresentationLogic?
    var worker: ListPullRequestsWorker?
}
