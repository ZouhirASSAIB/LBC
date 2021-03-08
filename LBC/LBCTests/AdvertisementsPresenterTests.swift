//
//  AdvertisementsPresenterTests.swift
//  LBCTests
//
//  Created by Zouhair ASSAIB on 05/03/2021.
//

import XCTest
@testable import LBC

class AdvertisementsPresenterTests: XCTestCase {
    var presenter: ViewToPresenterAdvertisementsProtocol!
    var interactor: InteractorToPresenterAdvertisementsProtocol!
    
    override func setUp() {
        super.setUp()
        
        interactor = TestAdvertisementsInteractor()
        presenter = AdvertisementsPresenter()
    }
    
    func testThatItRetrievesCategories() {
        let testExpectation = expectation(description: #function)
        
        let category = CategoryModel(id: 6, name: "Voitures")
        interactor.fetchCategoriesSuccess(categories: [category])
        
        
        XCTAssertEqual(presenter.categories?.count, 1)
        XCTAssertEqual(presenter.categories?.first?.id, 6)
        XCTAssertEqual(presenter.categories?.first?.name, "Voitures")
        testExpectation.fulfill()
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testThatItRetrievesCategory() {
        let testExpectation = expectation(description: #function)
        
        let category = CategoryModel(id: 6, name: "Voitures")
        interactor.fetchCategoriesSuccess(categories: [category])
        
        
        XCTAssertEqual(presenter.categories?.count, 1)
        XCTAssertEqual(presenter.categories?.first?.id, 6)
        XCTAssertEqual(presenter.categories?.first?.name, "Voitures")
        testExpectation.fulfill()
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testThatItRetrievesAdvertisements() {
        let testExpectation = expectation(description: #function)
        
        let advertisement = AdvertisementModel(id: 1, categoryID: 3, title: "AD 1", advertisementDescription: "AD 1 description.",
                                               price: 120.0, imagesURL: ImagesURL(small: "", thumb: ""),
                                               creationDate: "", isUrgent: true, siret: nil)
        
        interactor.fetchAdvertisementsSuccess(advertisements: [advertisement])
        
        
        XCTAssertEqual(presenter.advertisements?.count, 1)
        XCTAssertEqual(presenter.advertisements?.first?.id, 1)
        XCTAssertEqual(presenter.advertisements?.first?.title, "AD 1")
        testExpectation.fulfill()
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testThatItRetrievesAdvertisement() {
        let testExpectation = expectation(description: #function)
        
        let advertisement = AdvertisementModel(id: 1, categoryID: 3, title: "AD 1", advertisementDescription: "AD 1 description.",
                                               price: 120.0, imagesURL: ImagesURL(small: "", thumb: ""),
                                               creationDate: "", isUrgent: true, siret: nil)
        
        interactor.getAdvertisementSuccess(advertisement)
        
        
        XCTAssertEqual(presenter.advertisements?.count, 1)
        XCTAssertEqual(presenter.advertisements?.first?.id, 1)
        XCTAssertEqual(presenter.advertisements?.first?.title, "AD 1")
        testExpectation.fulfill()
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
}

// Test Classes
extension AdvertisementsPresenterTests {
    
    class TestAdvertisementsInteractor: InteractorToPresenterAdvertisementsProtocol {
        func fetchCategoriesSuccess(categories: Categories) {
            print("Presenter receives the categories result from Interactor after it's done its job.")
        }
        
        
        func fetchAdvertisementsSuccess(advertisements: Advertisements) {
            print("Presenter receives the advertisements result from Interactor after it's done its job.")
        }
        
        func fetchAdvertisementsFailure(error: Error) {
            print("Presenter receives the result from Interactor after it's done its job.")
        }
        
        func getAdvertisementSuccess(_ advertisement: AdvertisementModel) {
        }
        
        func getAdvertisementFailure() {
            print("Couldn't retrieve advertisement by index")
        }
    }
}
