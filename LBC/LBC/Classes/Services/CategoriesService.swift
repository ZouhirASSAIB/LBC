//
//  CategoriesService.swift
//  LBC
//
//  Created by Zouhair ASSAIB on 07/03/2021.
//

import Foundation

class CategoriesService : CategoriesAPIServiceProtocol {
    
    func getCategories(success: @escaping (Categories) -> (), failure: @escaping (Error) -> ()) {
        
        APIClient.shared.getArray(urlString: Endpoints.categories, success: { (arrayOfCategories) in
            success(arrayOfCategories)

        }) { (error) in
            failure(error)
        }
    }
}
