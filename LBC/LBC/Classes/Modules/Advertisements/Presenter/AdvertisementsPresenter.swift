//
//  AdvertisementsPresenter.swift
//  LBC
//
//  Created by Zouhair ASSAIB on 05/03/2021.
//

import Foundation

// MARK: - AdvertisementsPresenter
class AdvertisementsPresenter: ViewToPresenterAdvertisementsProtocol {
    
    // MARK: Properties
    weak var view: PresenterToViewAdvertisementsProtocol?
    var interactor: PresenterToInteractorAdvertisementsProtocol?
    var router: PresenterToRouterAdvertisementsProtocol?
    
    var advertisements: Advertisements?
    
    // MARK: Inputs from view
    func viewDidLoad() {
        print("Presenter is being notified that the View was loaded.")
        view?.presentActivity()
        interactor?.loadAdvertisements()
    }
    
    func refresh() {
        print("Presenter is being notified that the View was refreshed.")
        interactor?.loadAdvertisements()
    }
    
    func numberOfRowsInSection() -> Int {
        guard let advertisements = self.advertisements else {
            return 0
        }
        
        return advertisements.count
    }
    
    func getAdvertisement(indexPath: IndexPath) -> AdvertisementModel? {
        guard let advertisements = self.advertisements else {
            return nil
        }
        
        return advertisements[indexPath.row]
    }

    
    func didSelectRowAt(index: Int) {
        interactor?.retrieveAdvertisement(at: index)
    }
    
    func deselectRowAt(index: Int) {
        view?.deselectRowAt(row: index)
    }
}

// MARK: - Outputs to view
extension AdvertisementsPresenter: InteractorToPresenterAdvertisementsProtocol {
    
    func fetchAdvertisementsSuccess(advertisements: Advertisements) {
        print("Presenter receives the result from Interactor after it's done its job.")
        self.advertisements = advertisements.compactMap { $0 }
        view?.dismissActivity()
        view?.onFetchAdvertisementsSuccess()
    }
    
    func fetchAdvertisementsFailure(error: Error) {
        print("Presenter receives the result from Interactor after it's done its job.")
        view?.dismissActivity()
        view?.onFetchAdvertisementsFailure(error: error)
    }
    
    func getAdvertisementSuccess(_ advertisement: AdvertisementModel) {
        router?.pushToAdvertisementDetail(on: view!, with: advertisement)
    }
    
    func getAdvertisementFailure() {
        view?.dismissActivity()
        print("Couldn't retrieve advertisement by index")
    }
    
    
}
