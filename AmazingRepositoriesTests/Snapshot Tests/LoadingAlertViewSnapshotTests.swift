//
//  LoadingAlertViewSnapshotTests.swift
//  AmazingRepositoriesTests
//
//  Created by Leandro Romano on 06/12/19.
//  Copyright © 2019 Leandro Romano. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots
@testable import AmazingRepositories

class LoadingAlertViewSnapshotTests: QuickSpec {

    override func spec() {
        
        describe("LoadingAlertViewSnapshotTests") {
            
            var dummyViewController: DummyLoadingAlertView!
            
            beforeEach {
                dummyViewController = DummyLoadingAlertView()
                dummyViewController.view.translatesAutoresizingMaskIntoConstraints = false
                
                let window = UIWindow(frame: UIScreen.main.bounds)
                window.makeKeyAndVisible()
                window.rootViewController = dummyViewController
                
                dummyViewController.viewDidLoad()
            }
            
            afterEach {
                dummyViewController = nil
            }
            
            it("should present loading alert view") {
                expect(dummyViewController.view) == snapshot()
            }
            
        }
        
    }

}
