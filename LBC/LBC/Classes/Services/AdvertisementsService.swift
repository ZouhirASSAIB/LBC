//
//  AdvertisementsService.swift
//  LBC
//
//  Created by Zouhair ASSAIB on 05/03/2021.
//

import Foundation

class AdvertisementsService : AdvertisementsAPIServiceProtocol {
    
    func getAdvertisements(success: @escaping (Advertisements) -> (), failure: @escaping (Error) -> ()) {
        
        APIClient.shared.getArray(urlString: Endpoints.listing, success: { (arrayOfAdvertisements) in
            success(arrayOfAdvertisements)

        }) { (error) in
            failure(error)
        }
    }
}
