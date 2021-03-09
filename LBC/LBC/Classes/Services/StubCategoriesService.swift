//
//  StubCategoriesService.swift
//  LBC
//
//  Created by Zouhair ASSAIB on 09/03/2021.
//

import Foundation

class StubCategoriesService : CategoriesAPIServiceProtocol {
    
    func getCategories(success: @escaping (Categories) -> (), failure: @escaping (Error) -> ()) {
        
        success([CategoryModel(id: 6, name: "Voitures")] )
    }
}
