import Quick
import Nimble
import Nimble_Snapshots
@testable import AmazingRepositories

class RepositoryTableHeaderViewSnapshotTests: QuickSpec {
    override func spec() {
        describe("RepositoryTableHeaderViewSnapshotTests") {
            var dummyViewController: DummyHeaderView!
            
            beforeEach {
                dummyViewController = DummyHeaderView()
                dummyViewController.view.translatesAutoresizingMaskIntoConstraints = false
                
                let window = UIWindow(frame: UIScreen.main.bounds)
                window.makeKeyAndVisible()
                window.rootViewController = dummyViewController
                
                dummyViewController.viewDidLoad()
            }
            
            afterEach {
                dummyViewController = nil
            }
            
            it("should present light repository header view") {
                expect(dummyViewController.view).to(haveValidDynamicTypeSnapshot())
            }
        }
    }
}
