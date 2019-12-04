//
//  ListRepositoriesViewControllerSnapshotTests.swift
//  AmazingRepositoriesTests
//
//  Created by Leandro Romano on 03/12/19.
//  Copyright © 2019 Leandro Romano. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots
@testable import AmazingRepositories

class ListRepositoriesViewControllerSnapshotTests: QuickSpec {
    
    override func spec() {
        
        describe("ListRepositoriesViewControllerSnapshotTests") {
            
            var viewController: ListRepositoriesViewController!
            var presenter: ListRepositoriesPresenter!
            var interactor: MockListRepositoriesInteractor!
            
            beforeEach {
                viewController = ListRepositoriesViewController()
                viewController.view.translatesAutoresizingMaskIntoConstraints = false
                
                let window = UIWindow(frame: UIScreen.main.bounds)
                window.rootViewController = viewController
                window.makeKeyAndVisible()
                
                presenter = ListRepositoriesPresenter()
                presenter.viewController = viewController
                
                let mockWorker = MockListRepositoriesWorker()
                mockWorker.returnType = .success(type: .numberOfStars, page: 1)
                
                interactor = MockListRepositoriesInteractor(worker: mockWorker)
                interactor.presenter = presenter
                
                viewController.interactor = interactor
                viewController.viewDidLoad()
            }
            
            afterEach {
                viewController = nil
                presenter = nil
                interactor = nil
            }
            
            it("should present loading state") {
                expect(viewController.view) == snapshot()
            }
            
            it("should display first page of starred repositories") {
                waitUntil(timeout: 10) { done in
                    interactor.requestRepositories(sortedBy: .numberOfStars)
                    done()
                }
                
                expect(interactor.numberOfRows).to(equal(30))
                expect(interactor.cellForRow(at: 0)?.name).to(equal("awesome-ios"))
                expect(viewController) == snapshot()
            }
            
            it("should display pull to refresh element") {
                waitUntil(timeout: 10) { done in
                    interactor.requestRepositories(sortedBy: .numberOfStars)
                    done()
                }
                
                viewController.refreshRepositories(UIRefreshControl())
                expect(interactor.numberOfRows).to(equal(30))
                expect(interactor.cellForRow(at: 0)?.name).to(equal("awesome-ios"))
                expect(viewController) == snapshot()
            }
            
        }
        
    }
    
}
