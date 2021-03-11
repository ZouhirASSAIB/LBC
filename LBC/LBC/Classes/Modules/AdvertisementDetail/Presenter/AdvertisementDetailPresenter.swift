//
//  AdvertisementDetailPresenter.swift
//  LBC
//
//  Created by Zouhair ASSAIB on 09/03/2021.
//

import UIKit

class AdvertisementDetailPresenter: ViewToPresenterAdvertisementDetailProtocol {
    
    // MARK: Properties
    weak var view: PresenterToViewAdvertisementDetailProtocol?
    var interactor: PresenterToInteractorAdvertisementDetailProtocol?
    var router: PresenterToRouterAdvertisementDetailProtocol?
    
    func viewDidLoad() {
        print("AdvertisementDetailPresenter is being notified that the View was loaded.")
        interactor?.getImageDataFromURL()
    }
    
}

extension AdvertisementDetailPresenter: InteractorToPresenterAdvertisementDetailProtocol {
    
    func getImageFromURLSuccess(image: UIImage) {
        print("AdvertisementDetailPresenter receives the success result from Interactor after it's done its job.")
        
        view?.onGetImageFromURLSuccess(thumbImage: image)
    }
    
    func getImageFromURLFailure(advertisement: AdvertisementModel) {
        print("AdvertisementDetailPresenter receives the failure result from Interactor after it's done its job.")
        
        let realDate = AppDateFormatter.shared.isoDate(from: advertisement.creationDate)
        let longDateShortTime = AppDateFormatter.shared.longDateShortTimeString(from: realDate)
        var priceNumber:String? = nil
        
        if let price = advertisement.price {
            priceNumber = NumberFormatter.localizedString(from: NSNumber(value: price) , number: .currency)
        }
        
        view?.onGetImageFromURLFailure(title: advertisement.title,
                                       description: advertisement.advertisementDescription,
                                       price: priceNumber, creationDate: longDateShortTime,
                                       isUrgent: advertisement.isUrgent, siret: advertisement.siret)
    }
}
