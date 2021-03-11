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
    var categories: Categories?
    var categoryID: Int?
    
    // MARK: Inputs from view
    func viewDidLoad() {
        print("AdvertisementsPresenter is being notified that the View was loaded.")
        view?.presentActivity()
        interactor?.loadAdvertisements(categoryID: categoryID)
    }
    
    func refresh() {
        print("AdvertisementsPresenter is being notified that the View was refreshed.")
        interactor?.loadAdvertisements(categoryID: categoryID)
    }
    
    func numberOfRowsInSection() -> Int {
        guard let advertisements = self.advertisements else {
            return 0
        }
        
        return advertisements.count
    }
    
    private func getAdvertisement(indexPath: IndexPath) -> AdvertisementModel? {
        guard let advertisements = self.advertisements else {
            return nil
        }
        
        return advertisements[indexPath.row]
    }
    
    func getAdvertisementImage(indexPath: IndexPath) -> URL? {
        guard let advertisement = self.getAdvertisement(indexPath: indexPath),
              let small = advertisement.imagesURL?.small,
              let smallURL = URL(string:small) else {
            return nil
        }
        
        return smallURL
    }
    
    func getAdvertisementTitle(indexPath: IndexPath) -> String? {
        guard let advertisement = self.getAdvertisement(indexPath: indexPath),
              let title = advertisement.title else {
            return nil
        }
        
        return title
    }
    
    func getAdvertisementPrice(indexPath: IndexPath) -> String? {
        guard let advertisement = self.getAdvertisement(indexPath: indexPath),
              let price = advertisement.price else {
            return nil
        }
        
        return NumberFormatter.localizedString(from: NSNumber(value: price), number: .currency)
    }
    
    func getAdvertisementCreationDate(indexPath: IndexPath) -> String? {
        guard let advertisement = self.getAdvertisement(indexPath: indexPath),
              let creationDate = advertisement.creationDate,
              let realDate = AppDateFormatter.shared.isoDate(from: creationDate) else {
            return nil
        }
        
        return AppDateFormatter.shared.longDateShortTimeString(from: realDate)
    }
    
    private func getCategoryID(advertisementIndexPath: IndexPath) -> Int? {
        guard let advertisement = self.getAdvertisement(indexPath: advertisementIndexPath) else {
            return nil
        }
        
        return advertisement.categoryID
    }
    
    func getAdvertisementCategoryName(indexPath: IndexPath) -> String? {
        guard let categories = self.categories,
              let categoryID = self.getCategoryID(advertisementIndexPath: indexPath) else {
            return nil
        }
        
        return categories.first { $0.id == categoryID }?.name
    }
    
    func isAdvertisementUrgent(indexPath: IndexPath) -> Bool? {
        guard let advertisement = self.getAdvertisement(indexPath: indexPath),
              let isUrgent = advertisement.isUrgent else {
            return nil
        }
        
        return isUrgent
    }
    
    func didSelectRowAt(index: Int) {
        interactor?.retrieveAdvertisement(at: index)
    }
    
    func deselectRowAt(index: Int) {
        view?.deselectRowAt(row: index)
    }
    
    func presentCategories() {
        interactor?.presentCategories()
    }
}

// MARK: - Outputs to view
extension AdvertisementsPresenter: InteractorToPresenterAdvertisementsProtocol {
    func fetchCategoriesSuccess(categories: Categories) {
        print("AdvertisementsPresenter receives the categories result from Interactor after it's done its job.")
        self.categories = categories.compactMap { $0 }
    }
    
    
    func fetchAdvertisementsSuccess(advertisements: Advertisements) {
        print("AdvertisementsPresenter receives the advertisements result from Interactor after it's done its job.")
        self.advertisements = advertisements.compactMap { $0 }
        view?.dismissActivity()
        view?.onFetchAdvertisementsSuccess()
    }
    
    func fetchAdvertisementsFailure(error: Error) {
        print("AdvertisementsPresenter receives the result from Interactor after it's done its job.")
        view?.dismissActivity()
        view?.onFetchAdvertisementsFailure(error: error)
    }
    
    func getAdvertisementSuccess(_ advertisement: AdvertisementModel) {
        router?.presentAdvertisementDetail(on: view!, with: advertisement)
    }
    
    func getAdvertisementFailure() {
        view?.dismissActivity()
        print("Couldn't retrieve advertisement by index")
    }
    
    func getCategoriesSuccess(_ categories: Categories) {
        router?.presentCategories(on: view!, with: categories)
    }
}
