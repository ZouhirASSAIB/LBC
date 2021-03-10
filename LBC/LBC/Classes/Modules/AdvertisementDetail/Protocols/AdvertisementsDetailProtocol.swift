//
//  AdvertisementsDetailProtocol.swift
//  LBC
//
//  Created by Zouhair ASSAIB on 09/03/2021.
//

import UIKit

// MARK: View Output (Presenter -> View)
protocol PresenterToViewAdvertisementDetailProtocol: class {
    
    func onGetImageFromURLSuccess(thumbImage:UIImage)
    
    func onGetImageFromURLFailure(title: String?,
                                  description:String?, price: String?,
                                  creationDate: String?, isUrgent:Bool?,
                                  siret: String?)
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterAdvertisementDetailProtocol: class {
    
    var view: PresenterToViewAdvertisementDetailProtocol? { get set }
    var interactor: PresenterToInteractorAdvertisementDetailProtocol? { get set }
    var router: PresenterToRouterAdvertisementDetailProtocol? { get set }
    
    func viewDidLoad()
    
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorAdvertisementDetailProtocol: class {
    
    var presenter: InteractorToPresenterAdvertisementDetailProtocol? { get set }
    
    var advertisement: AdvertisementModel? { get set }
    
    func getImageDataFromURL()
    
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterAdvertisementDetailProtocol: class {
    
    func getImageFromURLSuccess(image: UIImage)
    func getImageFromURLFailure(advertisement: AdvertisementModel)
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterAdvertisementDetailProtocol: class {
    
    static func createModule(with advertisement: AdvertisementModel) -> UIViewController
}
