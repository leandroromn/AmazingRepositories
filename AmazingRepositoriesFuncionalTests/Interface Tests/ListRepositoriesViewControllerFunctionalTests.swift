import XCTest
import KIF
@testable import AmazingRepositories

class ListRepositoriesViewControllerFunctionalTests: KIFTestCase {
    func testDisplayHeaderView_StarredRepositories_FirstOpen() {
        tester().waitForView(withAccessibilityLabel: .starred)
        tester().waitForView(withAccessibilityLabel: .repositories)
        tester().waitForView(withAccessibilityLabel: .repositoryFilterButton)
    }
    
    func testTapFilterButton_ToFilterRepositories_ByFork() {
        tester().waitForView(withAccessibilityLabel: .repositoryFilterButton)
        tester().tapView(withAccessibilityLabel: .repositoryFilterButton)
        
        tester().waitForView(withAccessibilityLabel: .filterTitle)
        tester().tapView(withAccessibilityLabel: .numberOfForks)
        
        tester().waitForView(withAccessibilityLabel: .pleaseWait)
        
        tester().waitForView(withAccessibilityLabel: .forked)
        tester().waitForView(withAccessibilityLabel: .repositories)
        
        tester().waitForView(withAccessibilityLabel: .repositoryRow)
    }
    
    func testTapFilterButton_ToFilterRepositories_ByDate() {
        tester().waitForView(withAccessibilityLabel: .repositoryFilterButton)
        tester().tapView(withAccessibilityLabel: .repositoryFilterButton)
        
        tester().waitForView(withAccessibilityLabel: .filterTitle)
        tester().tapView(withAccessibilityLabel: .recency)
        
        tester().waitForView(withAccessibilityLabel: .pleaseWait)
        
        tester().waitForView(withAccessibilityLabel: .recent)
        tester().waitForView(withAccessibilityLabel: .repositories)
        
        tester().waitForView(withAccessibilityLabel: .repositoryRow)
    }
}
