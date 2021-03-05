//
//  AdvertisementsProtocol.swift
//  LBC
//
//  Created by Zouhair ASSAIB on 05/03/2021.
//

import UIKit

// MARK: View Output (Presenter -> View)
protocol PresenterToViewAdvertisementsProtocol: class {
    func onFetchAdvertisementsSuccess()
    func onFetchAdvertisementsFailure(error: Error)
    
    func presentActivity()
    func dismissActivity()
    
    func deselectRowAt(row: Int)
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterAdvertisementsProtocol: class {
    
    var view: PresenterToViewAdvertisementsProtocol? { get set }
    var interactor: PresenterToInteractorAdvertisementsProtocol? { get set }
    var router: PresenterToRouterAdvertisementsProtocol? { get set }
    
    var advertisements: Advertisements? { get set }
    
    func viewDidLoad()
    
    func refresh()
    
    func numberOfRowsInSection() -> Int
    func getAdvertisement(indexPath: IndexPath) -> AdvertisementModel?
    
    func didSelectRowAt(index: Int)
    func deselectRowAt(index: Int)

}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorAdvertisementsProtocol: class {
    
    var presenter: InteractorToPresenterAdvertisementsProtocol? { get set }
    
    func loadAdvertisements()
    func retrieveAdvertisement(at index: Int)
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterAdvertisementsProtocol: class {
    
    func fetchAdvertisementsSuccess(advertisements: Advertisements)
    func fetchAdvertisementsFailure(error: Error)
    
    func getAdvertisementSuccess(_ advertisement: AdvertisementModel)
    func getAdvertisementFailure()
    
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterAdvertisementsProtocol: class {
    
    static func createModule() -> UINavigationController
    
    func pushToAdvertisementDetail(on view: PresenterToViewAdvertisementsProtocol, with advertisement: AdvertisementModel)
}
