import Quick
import Nimble
import Nimble_Snapshots

@testable import AmazingRepositories

class ListPullRequestsTableViewCellSnapshotTests: QuickSpec {
    override func spec() {
        describe("ListPullRequestsTableViewCellSnapshotTests") {
            var dummyViewController: DummyPullRequestTableView!

            beforeEach {
                dummyViewController = DummyPullRequestTableView()
                dummyViewController.view.translatesAutoresizingMaskIntoConstraints = false

                let window = UIWindow(frame: UIScreen.main.bounds)
                window.makeKeyAndVisible()
                window.rootViewController = dummyViewController

                dummyViewController.viewDidLoad()
            }

            afterEach {
                dummyViewController = nil
            }

            it("should has a valid cell for pull request item") {
                expect(dummyViewController).to(haveValidSnapshot())
            }
        }
    }
}
