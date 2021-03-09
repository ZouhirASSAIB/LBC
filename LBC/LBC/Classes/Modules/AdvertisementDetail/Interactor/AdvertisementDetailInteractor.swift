//
//  AdvertisementDetailInteractor.swift
//  LBC
//
//  Created by Zouhair ASSAIB on 09/03/2021.
//

import Foundation

class AdvertisementDetailInteractor: PresenterToInteractorAdvertisementDetailProtocol {
    
    // MARK: Properties
    weak var presenter: InteractorToPresenterAdvertisementDetailProtocol?
    var advertisement: AdvertisementModel?
    
    func getImageDataFromURL() {
        print("Interactor receives the request from Presenter to get image data from the server.")
        
        if let small = advertisement?.imagesURL?.small,
           let smallURL = URL(string: small) {
            
            let task = URLSession.shared.dataTask(with: smallURL) { data, response, error in
                
                if let data = data {
                    self.presenter?.getImageFromURLSuccess(advertisement: self.advertisement!, data: data)
                    return
                }
                
                guard let error = error else {
                    return
                }
                
                guard (error as NSError).code == NSURLErrorCancelled else {
                    self.presenter?.getImageFromURLFailure(advertisement: self.advertisement!)
                    return
                }
            }
            
            task.resume()
        }
    }
}
