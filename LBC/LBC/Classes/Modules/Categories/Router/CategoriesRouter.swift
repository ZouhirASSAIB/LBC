//
//  CategoriesRouter.swift
//  LBC
//
//  Created by Zouhair ASSAIB on 11/03/2021.
//

import UIKit

class CategoriesRouter: PresenterToRouterCategoriesProtocol {
    
    // MARK: Static methods
    static func createModule(with categories: Categories) -> UIViewController {
        print("CategoriesRouter creates the Categories module.")
        let viewController = CategoriesViewController()
        
        let presenter: ViewToPresenterCategoriesProtocol & InteractorToPresenterCategoriesProtocol = CategoriesPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = CategoriesRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = CategoriesInteractor()
        viewController.presenter?.interactor?.categories = categories
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
    func dismissCategories(on view: PresenterToViewCategoriesProtocol, with categoryID: Int) {
        print("CategoriesRouter is instructed to dismiss CategoriesViewController.")
        
        if let viewController = view as? CategoriesViewController,
           let navigationController = viewController.presentingViewController as? UINavigationController,
           let advertisementsViewController = navigationController.topViewController as? AdvertisementsViewController {
            advertisementsViewController.presenter?.categoryID = categoryID
            advertisementsViewController.refresh()
            viewController.dismiss(animated: true)
        }
    }
}
