import Quick
import Nimble
import Nimble_Snapshots
@testable import AmazingRepositories

class ListRepositoriesViewControllerSnapshotTests: QuickSpec {
    override func spec() {
        describe("ListRepositoriesViewControllerSnapshotTests") {
            var dummyViewController: DummyRepositoryTableView!
            
            beforeEach {
                dummyViewController = DummyRepositoryTableView()
                dummyViewController.view.translatesAutoresizingMaskIntoConstraints = false
                
                let window = UIWindow(frame: UIScreen.main.bounds)
                window.makeKeyAndVisible()
                window.rootViewController = dummyViewController
                
                dummyViewController.viewDidLoad()
            }
            
            afterEach {
                dummyViewController = nil
            }
            
            it("should present light repository cell") {
                expect(dummyViewController.view).to(haveValidDynamicTypeSnapshot())
            }   
        }
    }
}
