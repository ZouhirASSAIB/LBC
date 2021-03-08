//
//  AdvertisementsAPIServiceProtocol.swift
//  LBC
//
//  Created by Zouhair ASSAIB on 08/03/2021.
//

import Foundation

protocol AdvertisementsAPIServiceProtocol {
    func getAdvertisements(success: @escaping (Advertisements) -> (), failure: @escaping (Error) -> ())
}
