//
//  CategoriesInteractor.swift
//  LBC
//
//  Created by Zouhair ASSAIB on 11/03/2021.
//

import Foundation

class CategoriesInteractor: PresenterToInteractorCategoriesProtocol {
    
    // MARK: Properties
    weak var presenter: InteractorToPresenterCategoriesProtocol?
    
    var categories: Categories?
    
    func setCategories() {
        print("CategoriesInteractor receives the request from Presenter to set categories.")
        
        if let categories = self.categories {
            self.presenter?.getCategoriesSuccess(categories: categories)
        }
    }
    
    func setCategoryID(categoryID: Int?) {
        print("CategoriesInteractor receives the request from Presenter to set category ID.")
        
        if let categoryID = categoryID {
            self.presenter?.getCategoryIDSuccess(categoryID: categoryID)
        }
    }
}
