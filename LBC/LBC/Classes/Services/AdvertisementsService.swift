//
//  AdvertisementsService.swift
//  LBC
//
//  Created by Zouhair ASSAIB on 05/03/2021.
//

import Foundation

class AdvertisementsService {
    
    static let shared = { AdvertisementsService() }()
    
    func getAdvertisementsService(success: @escaping (Advertisements) -> (), failure: @escaping (Error) -> ()) {
        
        APIClient.shared.getArray(urlString: Endpoints.LISTING, success: { (arrayOfAdvertisements) in
            success(arrayOfAdvertisements)

        }) { (error) in
            failure(error)
        }
    }
}
