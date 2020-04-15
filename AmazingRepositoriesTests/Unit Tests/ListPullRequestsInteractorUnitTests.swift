import Quick
import Nimble
import PromiseKit

@testable import AmazingRepositories

class ListPullRequestsInteractorUnitTests: QuickSpec {
    override func spec() {
        super.spec()

        describe("ListPullRequestsInteractorUnitTests") {
            var sut: ListPullRequestsInteractor!
            var mockWorker: MockListPullRequestsWorker!
            var mockPresenter: MockListPullRequestsPresenter!

            beforeEach {
                PromiseKit.conf.Q.map = nil
                PromiseKit.conf.Q.return = nil

                mockPresenter = MockListPullRequestsPresenter()
                mockWorker = MockListPullRequestsWorker()

                let interactor = ListPullRequestsInteractor(worker: mockWorker)
                interactor.presenter = mockPresenter
                interactor.repository = "a-valid-repository"
                interactor.author = "a-valid-author"

                sut = interactor
            }

            it("call's presenter method to display pull requests after a succeeded request") {
                mockWorker.returnType = .success(type: .numberOfStars, page: 1)
                sut.requestPullRequests()

                expect(mockPresenter.hasCalledPresentRepositoryName).to(beTrue())
                expect(mockPresenter.hasCalledRemoveLoadingState).to(beTrue())
                expect(mockPresenter.hasCalledPresentPullRequests).to(beTrue())
            }

            it("call's presenter method to display error message after a failed request") {
                mockWorker.returnType = .failure
                sut.requestPullRequests()

                expect(mockPresenter.hasCalledRemoveLoadingState).to(beTrue())
                expect(mockPresenter.hasCalledPresentRequestError).to(beTrue())
            }
        }
    }
}
