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
    var categories: Categories? { get set }
    var categoryID: Int? { get set }
    
    func viewDidLoad()
    
    func refresh()
    
    func numberOfRowsInSection() -> Int
    
    func getAdvertisementImage(indexPath: IndexPath) -> URL?
    func getAdvertisementTitle(indexPath: IndexPath) -> String?
    func getAdvertisementPrice(indexPath: IndexPath) -> String?
    func getAdvertisementCreationDate(indexPath: IndexPath)-> String?
    func getAdvertisementCategoryName(indexPath: IndexPath)-> String?
    func isAdvertisementUrgent(indexPath: IndexPath)-> Bool?
    
    func didSelectRowAt(index: Int)
    func deselectRowAt(index: Int)

    func presentCategories()
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorAdvertisementsProtocol: class {
    
    var presenter: InteractorToPresenterAdvertisementsProtocol? { get set }
    var advertisementsAPIService: AdvertisementsAPIServiceProtocol?{ get set }
    var categoriesAPIService: CategoriesAPIServiceProtocol?{ get set }
    
    var advertisements: Advertisements? { get set }
    var categories: Categories? { get set }
    
    func loadAdvertisements(categoryID: Int?)
    func retrieveAdvertisement(at index: Int)
    
    func presentCategories()
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterAdvertisementsProtocol: class {
    
    func fetchAdvertisementsSuccess(advertisements: Advertisements)
    func fetchAdvertisementsFailure(error: Error)
    
    func getAdvertisementSuccess(_ advertisement: AdvertisementModel)
    func getAdvertisementFailure()
    
    func fetchCategoriesSuccess(categories: Categories)
    
    func getCategoriesSuccess(_ categories: Categories)
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterAdvertisementsProtocol: class {
    
    static func createModule() -> UINavigationController
    
    func presentAdvertisementDetail(on view: PresenterToViewAdvertisementsProtocol, with advertisement: AdvertisementModel)
    
    func presentCategories(on view: PresenterToViewAdvertisementsProtocol, with categories: Categories)
}
