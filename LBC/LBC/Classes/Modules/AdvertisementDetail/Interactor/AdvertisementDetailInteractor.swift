//
//  AdvertisementDetailInteractor.swift
//  LBC
//
//  Created by Zouhair ASSAIB on 09/03/2021.
//

import UIKit

class AdvertisementDetailInteractor: PresenterToInteractorAdvertisementDetailProtocol {
    
    // MARK: Properties
    weak var presenter: InteractorToPresenterAdvertisementDetailProtocol?
    var advertisement: AdvertisementModel?
    
    func getImageDataFromURL() {
        print("Interactor receives the request from Presenter to get image data from the server.")
        
        if let advertisement = self.advertisement {
            
            self.presenter?.getImageFromURLFailure(advertisement: advertisement)
            
            if let thumb = advertisement.imagesURL?.thumb,
               let thumbURL = URL(string: thumb) {
                    
                    let task = URLSession.shared.dataTask(with: thumbURL) { data, response, error in
                        
                        if let data = data, let image = UIImage(data: data) {
                            self.presenter?.getImageFromURLSuccess(image: image)
                            return
                        }
                        
                        guard let error = error else {
                            self.presenter?.getImageFromURLFailure(advertisement: advertisement)
                            return
                        }
                        
                        guard (error as NSError).code == NSURLErrorCancelled else {
                            self.presenter?.getImageFromURLFailure(advertisement: advertisement)
                            return
                        }
                    }
                    
                    task.resume()
                } else {
                    self.presenter?.getImageFromURLFailure(advertisement: advertisement)
                }
        }
    }
}
