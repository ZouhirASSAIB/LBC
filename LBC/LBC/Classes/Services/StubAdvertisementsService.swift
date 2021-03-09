//
//  StubAdvertisementsService.swift
//  LBC
//
//  Created by Zouhair ASSAIB on 09/03/2021.
//

import Foundation

class StubAdvertisementsService : AdvertisementsAPIServiceProtocol {
    
    func getAdvertisements(success: @escaping (Advertisements) -> (), failure: @escaping (Error) -> ()) {
        
        success([AdvertisementModel(id: 1, categoryID: 3, title: "AD 1", advertisementDescription: "AD 1 description.",
                                    price: 120.0, imagesURL: ImagesURL(small:"https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-small/4f592a83a753bdff15048b5b5413914ece868e03.jpg", thumb: "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-thumb/4f592a83a753bdff15048b5b5413914ece868e03.jpg"),
                                    creationDate: "2019-11-06T11:18:02+0000", isUrgent: true, siret: "123 323 002")])
    }
}
