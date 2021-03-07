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
    var categories: Categories?
    
    func loadAdvertisements() {
        print("Interactor receives the request from Presenter to load categories and advertisements from the server.")
        
        CategoriesService.shared.getCategoriesService(success: { (categories) in
            self.categories = categories
            self.presenter?.fetchCategoriesSuccess(categories: categories)
        }) { (error) in }
        
        AdvertisementsService.shared.getAdvertisementsService(success: { (advertisements) in
            
            self.advertisements = advertisements.sorted {
                
                guard let firstCreationDate = $0.creationDate,
                      let secondCreationDate = $1.creationDate,
                      let firstDate = AppDateFormatter.shared.isoDate(from:firstCreationDate),
                      let secondDate = AppDateFormatter.shared.isoDate(from:secondCreationDate),
                      let firstIsUrgent = $0.isUrgent,
                      let secondIsUrgent = $1.isUrgent else {
                    return false
                }
                
                if (firstIsUrgent && !secondIsUrgent) {
                    return (firstIsUrgent && !secondIsUrgent)
                } else {
                    return firstDate.compare(secondDate) == .orderedDescending
                }
            }
            
            if let advertisements = self.advertisements {
                self.presenter?.fetchAdvertisementsSuccess(advertisements: advertisements)
            }
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
