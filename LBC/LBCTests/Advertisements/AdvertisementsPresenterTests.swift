//
//  AdvertisementsPresenterTests.swift
//  LBCTests
//
//  Created by Zouhair ASSAIB on 05/03/2021.
//

import XCTest
@testable import LBC

class AdvertisementsPresenterTests: XCTestCase {
    
    var presenter: AdvertisementsPresenter!
    
    var fakeCategories: Categories!
    
    var fakeAdvertisements: Advertisements!
    
    override func setUp() {
        super.setUp()
        
        self.presenter = AdvertisementsPresenter()
        
        StubCategoriesService().getCategories(success: { categories in
            self.fakeCategories = categories
        }, failure: { error in
            
        })
        
        StubAdvertisementsService().getAdvertisements(success: { advertisements in
            self.fakeAdvertisements = advertisements
        }, failure: { error in
            
        })
    }
    
    func testThatItRetrievesCategories() {
        let testExpectation = expectation(description: #function)
        
        presenter.fetchCategoriesSuccess(categories: fakeCategories)
        
        XCTAssertEqual(presenter.categories?.count, 1)
        XCTAssertEqual(presenter.categories?.first?.id, 6)
        XCTAssertEqual(presenter.categories?.first?.name, "Voitures")
        testExpectation.fulfill()
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testThatItRetrievesAdvertisements() {
        let testExpectation = expectation(description: #function)
        
        presenter.fetchAdvertisementsSuccess(advertisements: fakeAdvertisements)
        
        XCTAssertEqual(presenter.advertisements?.count, 1)
        XCTAssertEqual(presenter.advertisements?.first?.id, 1)
        XCTAssertEqual(presenter.advertisements?.first?.title, "AD 1")
        testExpectation.fulfill()
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testAdvertisementsNumberOfRowsInSection() {
        presenter.fetchAdvertisementsSuccess(advertisements: fakeAdvertisements)
        XCTAssertEqual(presenter.numberOfRowsInSection(), 1)
    }
    
    func testAdvertisementAtIndex() {
        presenter.fetchAdvertisementsSuccess(advertisements: fakeAdvertisements)
        let ad = presenter.advertisements?[0]
        
        XCTAssertEqual(ad?.id, fakeAdvertisements[0].id)
        XCTAssertEqual(ad?.categoryID, fakeAdvertisements[0].categoryID)
        XCTAssertEqual(ad?.title, fakeAdvertisements[0].title)
        XCTAssertEqual(ad?.advertisementDescription, fakeAdvertisements[0].advertisementDescription)
        XCTAssertEqual(ad?.price, fakeAdvertisements[0].price)
        XCTAssertEqual(ad?.imagesURL?.small, fakeAdvertisements[0].imagesURL?.small)
        XCTAssertEqual(ad?.imagesURL?.thumb, fakeAdvertisements[0].imagesURL?.thumb)
        XCTAssertEqual(ad?.creationDate, fakeAdvertisements[0].creationDate)
        XCTAssertEqual(ad?.isUrgent, fakeAdvertisements[0].isUrgent)
        XCTAssertEqual(ad?.siret, fakeAdvertisements[0].siret)
    }
    
    func testCategoryAtIndex() {
        presenter.fetchCategoriesSuccess(categories: fakeCategories)
        let category = presenter.categories?[0]
        
        XCTAssertEqual(category?.id, fakeCategories[0].id)
        XCTAssertEqual(category?.name, fakeCategories[0].name)
    }
}
