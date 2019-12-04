//
//  ListRepositoriesInteractorUnitTests.swift
//  AmazingRepositoriesTests
//
//  Created by Leandro Romano on 03/12/19.
//  Copyright © 2019 Leandro Romano. All rights reserved.
//

import XCTest
import Quick
import Nimble
import PromiseKit
@testable import AmazingRepositories

class ListRepositoriesInteractorUnitTests: QuickSpec {
    
    override func spec() {
        super.spec()
        
        describe("ListRepositoriesInteractorTests") {
            
            var sut: ListRepositoriesInteractor!
            var mockWorker: MockListRepositoriesWorker!
            var mockPresenter: MockListRepositoriesPresenter!
            
            beforeEach {
                PromiseKit.conf.Q.map = nil
                PromiseKit.conf.Q.return = nil
                
                mockPresenter = MockListRepositoriesPresenter()
                mockWorker = MockListRepositoriesWorker()
                
                let interactor = ListRepositoriesInteractor(worker: mockWorker)
                interactor.presenter = mockPresenter
                
                sut = interactor
            }
            
            describe("a request to fetch repositories and populate a list") {
                
                context("a successful request to GitHub's API") {
                    
                    it("returns the first page with 30 results for most starred repositories") {
                        mockWorker.returnType = .success(type: .numberOfStars, page: 1)
                        sut.requestRepositories(sortedBy: .numberOfStars)
                        
                        expect(sut.numberOfRows).to(equal(30))
                        expect(sut.currentPage).to(equal(1))
                        expect(sut.cellForRow(at: 0)?.name).to(equal("awesome-ios"))
                        expect(mockPresenter.hasCalledReloadTableView).to(beTrue())
                        expect(mockPresenter.hasCalledRemoveLoadingState).to(beTrue())
                    }
                    
                    it("returns the second page with 60 results for most starred repositories") {
                        mockWorker.returnType = .success(type: .numberOfStars, page: 1)
                        sut.requestRepositories(sortedBy: .numberOfStars)
                        
                        expect(sut.numberOfRows).to(equal(30))
                        expect(sut.currentPage).to(equal(1))
                        expect(sut.cellForRow(at: 0)?.name).to(equal("awesome-ios"))
                        expect(mockPresenter.hasCalledReloadTableView).to(beTrue())
                        expect(mockPresenter.hasCalledRemoveLoadingState).to(beTrue())
                        
                        mockWorker.returnType = .success(type: .numberOfStars, page: 2)
                        sut.requestNextPage(index: 20)
                        
                        expect(sut.numberOfRows).to(equal(60))
                        expect(sut.currentPage).to(equal(2))
                        expect(sut.cellForRow(at: 30)?.name).to(equal("folding-cell"))
                        expect(mockPresenter.hasCalledReloadTableView).to(beTrue())
                        expect(mockPresenter.hasCalledRemoveLoadingState).to(beTrue())
                    }
                    
                    it("returns the first page with 30 results for most starred repositories after pulled to refresh") {
                        mockWorker.returnType = .success(type: .numberOfStars, page: 1)
                        sut.refreshRepositories()
                        
                        expect(sut.numberOfRows).to(equal(30))
                        expect(sut.currentPage).to(equal(1))
                        expect(sut.cellForRow(at: 0)?.name).to(equal("awesome-ios"))
                        expect(mockPresenter.hasCalledReloadTableView).to(beTrue())
                        expect(mockPresenter.hasCalledRemoveLoadingState).to(beTrue())
                    }
                    
                    it("returns the first page with 30 results for most recent repositories filtered by user and ordered by stars amount") {
                        mockWorker.returnType = .success(type: .recency, page: 1)
                        sut.filterRepositories(sortedBy: .recency)
                        
                        expect(sut.numberOfRows).to(equal(30))
                        expect(sut.currentPage).to(equal(1))
                        expect(sut.cellForRow(at: 0)?.name).to(equal("CodableAlamofire"))
                        expect(mockPresenter.hasCalledPresentLoadingState).to(beTrue())
                        expect(mockPresenter.hasCalledReloadTableView).to(beTrue())
                        expect(mockPresenter.hasCalledRemoveLoadingState).to(beTrue())
                    }
                    
                    it("not request for the next page if it's not necessary") {
                        mockWorker.returnType = .success(type: .numberOfStars, page: 1)
                        sut.requestRepositories(sortedBy: .numberOfStars)
                        
                        expect(sut.numberOfRows).to(equal(30))
                        expect(sut.currentPage).to(equal(1))
                        
                        sut.requestNextPage(index: 5)
                        
                        expect(sut.numberOfRows).to(equal(30))
                        expect(sut.currentPage).to(equal(1))
                        
                    }
                    
                }
                
                context("a failure request to GitHub's API") {
                    
                    it("returns an error when the first request has empty data response") {
                        mockWorker.returnType = .failure
                        sut.filterRepositories(sortedBy: .numberOfStars)
                        
                        expect(sut.numberOfRows).to(equal(0))
                        expect(sut.currentPage).to(equal(1))
                        expect(mockPresenter.hasCalledRemoveLoadingState).to(beTrue())
                        expect(mockPresenter.hasCalledPresentError).to(beTrue())
                    }
                    
                    it("returns an error when the request for infity scroll failed") {
                        mockWorker.returnType = .success(type: .numberOfStars, page: 1)
                        sut.requestRepositories(sortedBy: .numberOfStars)
                        
                        expect(sut.numberOfRows).to(equal(30))
                        expect(sut.currentPage).to(equal(1))
                        expect(mockPresenter.hasCalledRemoveLoadingState).to(beTrue())
                        expect(mockPresenter.hasCalledReloadTableView).to(beTrue())
                        
                        mockWorker.returnType = .parseError
                        sut.requestNextPage(index: 20)
                        
                        expect(sut.numberOfRows).to(equal(30))
                        expect(sut.currentPage).to(equal(2))
                        expect(mockPresenter.hasCalledRemoveLoadingState).to(beTrue())
                        expect(mockPresenter.hasCalledPresentError).to(beTrue())
                    }
                    
                    it("returns an error when the request for pull to refresh failed") {
                        mockWorker.returnType = .success(type: .numberOfStars, page: 1)
                        sut.requestRepositories(sortedBy: .numberOfStars)
                        
                        expect(sut.numberOfRows).to(equal(30))
                        expect(sut.currentPage).to(equal(1))
                        expect(mockPresenter.hasCalledRemoveLoadingState).to(beTrue())
                        expect(mockPresenter.hasCalledReloadTableView).to(beTrue())
                        
                        mockWorker.returnType = .parseError
                        sut.refreshRepositories()
                        
                        expect(sut.numberOfRows).to(equal(30))
                        expect(sut.currentPage).to(equal(1))
                        expect(mockPresenter.hasCalledRemoveLoadingState).to(beTrue())
                        expect(mockPresenter.hasCalledPresentError).to(beTrue())
                    }
                    
                }
                
            }
            
        }
        
    }

}
