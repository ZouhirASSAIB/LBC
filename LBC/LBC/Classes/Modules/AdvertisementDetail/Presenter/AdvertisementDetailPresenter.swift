//
//  AdvertisementDetailPresenter.swift
//  LBC
//
//  Created by Zouhair ASSAIB on 09/03/2021.
//

import Foundation

class AdvertisementDetailPresenter: ViewToPresenterAdvertisementDetailProtocol {
    
    // MARK: Properties
    weak var view: PresenterToViewAdvertisementDetailProtocol?
    var interactor: PresenterToInteractorAdvertisementDetailProtocol?
    var router: PresenterToRouterAdvertisementDetailProtocol?
    
    func viewDidLoad() {
        print("Presenter is being notified that the View was loaded.")
        interactor?.getImageDataFromURL()
    }
    
}

extension AdvertisementDetailPresenter: InteractorToPresenterAdvertisementDetailProtocol {
    
    func getImageFromURLSuccess(advertisement: AdvertisementModel, data: Data?) {
        print("Presenter receives the result from Interactor after it's done its job.")
        
        if let small = advertisement.imagesURL?.small,
           let smallURL = URL(string: small),
           let price = advertisement.price {
            view?.onGetImageFromURLSuccess(smallURL: smallURL, title: advertisement.title,
                                           description: advertisement.advertisementDescription,
                                           price: NumberFormatter.localizedString(from: NSNumber(value: price), number: .currency),
                                           creationDate: advertisement.creationDate, categoryName: advertisement.creationDate,
                                           isUrgent: advertisement.isUrgent, siret: advertisement.siret)
        }
    }
    
    func getImageFromURLFailure(advertisement: AdvertisementModel) {
        print("Presenter receives the result from Interactor after it's done its job.")
        if let price = advertisement.price {
            view?.onGetImageFromURLFailure(title: advertisement.title,
                                           description: advertisement.advertisementDescription,
                                           price: NumberFormatter.localizedString(from: NSNumber(value: price), number: .currency),
                                           creationDate: advertisement.creationDate, categoryName: advertisement.creationDate,
                                           isUrgent: advertisement.isUrgent, siret: advertisement.siret)
        }
    }
}
