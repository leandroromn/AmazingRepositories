//
//  ListRepositoriesViewControllerFunctionalTests.swift
//  AmazingRepositoriesFuncionalTests
//
//  Created by Leandro Romano on 04/12/19.
//  Copyright © 2019 Leandro Romano. All rights reserved.
//

import XCTest
import KIF

class ListRepositoriesViewControllerFunctionalTests: KIFTestCase {

    func testDisplayHeaderView_StarredRepositories_FirstOpen() {
        tester().waitForView(withAccessibilityLabel: "Starred")
        tester().waitForView(withAccessibilityLabel: "Repositories")
        tester().waitForView(withAccessibilityLabel: "Repository filter button")
    }
    
    func testTapFilterButton_ToFilterRepositories_ByFork() {
        tester().waitForView(withAccessibilityLabel: "Repository filter button")
        tester().tapView(withAccessibilityLabel: "Repository filter button")
        
        tester().waitForView(withAccessibilityLabel: "Repositories Filter")
        tester().tapView(withAccessibilityLabel: "Number of Forks")
        
        tester().waitForView(withAccessibilityLabel: "Please wait...")
        
        tester().waitForView(withAccessibilityLabel: "Forked")
        tester().waitForView(withAccessibilityLabel: "Repositories")
        
        tester().waitForView(withAccessibilityLabel: "Repository row")
    }
    
    func testTapFilterButton_ToFilterRepositories_ByDate() {
        tester().waitForView(withAccessibilityLabel: "Repository filter button")
        tester().tapView(withAccessibilityLabel: "Repository filter button")
        
        tester().waitForView(withAccessibilityLabel: "Repositories Filter")
        tester().tapView(withAccessibilityLabel: "Recency")
        
        tester().waitForView(withAccessibilityLabel: "Please wait...")
        
        tester().waitForView(withAccessibilityLabel: "Recent")
        tester().waitForView(withAccessibilityLabel: "Repositories")
        
        tester().waitForView(withAccessibilityLabel: "Repository row")
    }

}
