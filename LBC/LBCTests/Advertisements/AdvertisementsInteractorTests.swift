//
//  AdvertisementsInteractorTests.swift
//  LBCTests
//
//  Created by Zouhair ASSAIB on 09/03/2021.
//

import XCTest
@testable import LBC

class AdvertisementsInteractorTests: XCTestCase {
    
    class FakeAdvertisementsInteractor: PresenterToInteractorAdvertisementsProtocol {
        
        var presenter: InteractorToPresenterAdvertisementsProtocol?
        
        var advertisementsAPIService: AdvertisementsAPIServiceProtocol?
        
        var categoriesAPIService: CategoriesAPIServiceProtocol?
        
        var advertisements: Advertisements?
        
        var categories: Categories?
        
        func loadAdvertisements(categoryID: Int?) {
            
            StubCategoriesService().getCategories(success: { categories in
                self.categories = categories
                self.presenter?.fetchCategoriesSuccess(categories: categories)
            }, failure: { error in })
            
            StubAdvertisementsService().getAdvertisements(success: { advertisements in
                self.advertisements = advertisements
                self.presenter?.fetchAdvertisementsSuccess(advertisements: advertisements)
            }, failure: { error in
                self.presenter?.fetchAdvertisementsFailure(error: error)
            })
        }
        
        func retrieveAdvertisement(at index: Int) {
            guard let advertisements = self.advertisements, advertisements.indices.contains(index) else {
                self.presenter?.getAdvertisementFailure()
                return
            }
            self.presenter?.getAdvertisementSuccess(advertisements[index])
        }
        
        func presentCategories() {
            guard let categories = self.categories else {
                return
            }
            self.presenter?.getCategoriesSuccess(categories)
        }
    }
    
    var interactor: PresenterToInteractorAdvertisementsProtocol!
    
    var presenter: AdvertisementsPresenter!
    
    var fakeCategories: Categories!
    
    var fakeAdvertisements: Advertisements!
    
    override func setUp() {
        super.setUp()
        
        self.interactor = FakeAdvertisementsInteractor()
        self.presenter = AdvertisementsPresenter()
        
        interactor.presenter = presenter
    }
    
    func testThatItRetrievesCategoriesAndAdvertisements() {
        let testExpectation = expectation(description: #function)
        
        interactor.loadAdvertisements(categoryID: nil)
        
        XCTAssertEqual(interactor.categories?.count, 1)
        XCTAssertEqual(interactor.categories?.first?.id, 6)
        XCTAssertEqual(interactor.categories?.first?.name, "Voitures")
        
        XCTAssertEqual(interactor.advertisements?.count, 1)
        XCTAssertEqual(interactor.advertisements?.first?.id, 1)
        XCTAssertEqual(interactor.advertisements?.first?.title, "AD 1")
        
        testExpectation.fulfill()
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testThatItRetrievesAdvertisement() {
        let testExpectation = expectation(description: #function)
        
        interactor.loadAdvertisements(categoryID: nil)
        interactor.retrieveAdvertisement(at: 0)
        
        XCTAssertEqual(self.presenter.categories?.count, 1)
        XCTAssertEqual(self.presenter.categories?.first?.id, 6)
        XCTAssertEqual(self.presenter.categories?.first?.name, "Voitures")
        
        XCTAssertEqual(self.presenter.advertisements?.count, 1)
        XCTAssertEqual(self.presenter.advertisements?.first?.id, 1)
        XCTAssertEqual(self.presenter.advertisements?.first?.title, "AD 1")
        
        testExpectation.fulfill()
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
}
