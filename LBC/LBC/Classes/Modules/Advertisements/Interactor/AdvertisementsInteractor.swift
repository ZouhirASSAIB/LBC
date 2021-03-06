//
//  AdvertisementsInteractor.swift
//  LBC
//
//  Created by Zouhair ASSAIB on 05/03/2021.
//

import Foundation

// MARK: - AdvertisementsInteractor
class AdvertisementsInteractor: PresenterToInteractorAdvertisementsProtocol {
    
    // MARK: Properties
    weak var presenter: InteractorToPresenterAdvertisementsProtocol?
    var advertisements: Advertisements?
    
    func loadAdvertisements() {
        print("Interactor receives the request from Presenter to load advertisements from the server.")
        AdvertisementsService.shared.getAdvertisementsService(success: { (advertisements) in
            self.advertisements = advertisements
            self.presenter?.fetchAdvertisementsSuccess(advertisements: advertisements)
        }) { (error) in
            self.presenter?.fetchAdvertisementsFailure(error: error)
        }
    }
    
    func retrieveAdvertisement(at index: Int) {
        guard let advertisements = self.advertisements, advertisements.indices.contains(index) else {
            self.presenter?.getAdvertisementFailure()
            return
        }
        self.presenter?.getAdvertisementSuccess(advertisements[index])
    }

}
