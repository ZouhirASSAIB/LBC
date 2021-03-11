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
        viewController.presenter?.interactor?.categoriesAPIService = CategoriesService()
        viewController.presenter?.interactor?.advertisementsAPIService = AdvertisementsService()
        
        return navigationController
    }
    
    // MARK: - Navigation
    func presentAdvertisementDetail(on view: PresenterToViewAdvertisementsProtocol, with advertisement: AdvertisementModel) {
        print("AdvertisementsRouter is instructed to present AdvertisementDetailViewController.")
        let advertisementDetailViewController = AdvertisementDetailRouter.createModule(with: advertisement)
        
        let viewController = view as! AdvertisementsViewController
        viewController.present(advertisementDetailViewController, animated: true)
    }
    
    func presentCategories(on view: PresenterToViewAdvertisementsProtocol, with categories: Categories) {
        print("AdvertisementsRouter is instructed to present CategoriesViewController.")
        let categoriesViewController = CategoriesRouter.createModule(with: categories) as! CategoriesViewController
        let advertisementsViewController = view as! AdvertisementsViewController
        categoriesViewController.presenter?.selectedCategoryID = advertisementsViewController.presenter?.categoryID
        advertisementsViewController.present(categoriesViewController, animated: true)
    }
}
