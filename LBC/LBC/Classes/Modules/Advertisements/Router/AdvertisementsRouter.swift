//
//  AdvertisementsRouter.swift
//  LBC
//
//  Created by Zouhair ASSAIB on 05/03/2021.
//

import UIKit

// MARK: - AdvertisementsRouter
class AdvertisementsRouter: PresenterToRouterAdvertisementsProtocol {
    
    // MARK: Static methods
    static func createModule() -> UINavigationController {
        
        print("AdvertisementsRouter creates the Advertisements module.")
        let viewController = AdvertisementsViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        
        let presenter: ViewToPresenterAdvertisementsProtocol & InteractorToPresenterAdvertisementsProtocol = AdvertisementsPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = AdvertisementsRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = AdvertisementsInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return navigationController
    }
    
    // MARK: - Navigation
    func pushToAdvertisementDetail(on view: PresenterToViewAdvertisementsProtocol, with advertisement: AdvertisementModel) {
        print("AdvertisementsRouter is instructed to push AdvertisementDetailViewController onto the navigation stack.")
//        let quoteDetailViewController = AdvertisementDetailRouter.createModule(with: advertisement)
//        
//        let viewController = view as! AdvertisementsViewController
//        viewController.navigationController?
//            .pushViewController(AdvertisementDetailViewController, animated: true)
        
    }
    
}
