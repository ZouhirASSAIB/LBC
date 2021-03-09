//
//  AdvertisementsRouterTests.swift
//  LBCTests
//
//  Created by Zouhair ASSAIB on 09/03/2021.
//

import XCTest
@testable import LBC

class AdvertisementsRouterTests: XCTestCase {
    
    var advertisementsRouter: AdvertisementsRouter!
    
    var advertisements: Advertisements?
    
    override func setUp() {
        super.setUp()
        advertisementsRouter = AdvertisementsRouter()
        StubAdvertisementsService().getAdvertisements(success: { advertisements in
            self.advertisements = advertisements
        }, failure: { error in })

    }
    
    func testTopVCIsMovieDetailVCWhenPresented() {
        if let advertisement = self.advertisements?.first,
           let navigationController = UIApplication.shared.windows.first!.rootViewController as? UINavigationController,
           let advertisementsViewController = navigationController.topViewController as? AdvertisementsViewController {
            advertisementsRouter.pushToAdvertisementDetail(on:advertisementsViewController, with: advertisement)
            XCTAssertTrue(advertisementsViewController.navigationController?.visibleViewController is AdvertisementDetailViewController)
        }
    }
}
