//
//  AdvertisementDetailRouter.swift
//  LBC
//
//  Created by Zouhair ASSAIB on 09/03/2021.
//

import UIKit

class AdvertisementDetailRouter: PresenterToRouterAdvertisementDetailProtocol {
    
    // MARK: Static methods
    static func createModule(with advertisement: AdvertisementModel) -> UIViewController {
        print("AdvertisementDetailRouter creates the AdvertisementDetail module.")
        let viewController = AdvertisementDetailViewController()
        
        let presenter: ViewToPresenterAdvertisementDetailProtocol & InteractorToPresenterAdvertisementDetailProtocol = AdvertisementDetailPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = AdvertisementDetailRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = AdvertisementDetailInteractor()
        viewController.presenter?.interactor?.advertisement = advertisement
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
}
