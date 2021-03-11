//
//  CategoriesPresenter.swift
//  LBC
//
//  Created by Zouhair ASSAIB on 11/03/2021.
//

import Foundation

class CategoriesPresenter: ViewToPresenterCategoriesProtocol {
    
    
    
    // MARK: Properties
    weak var view: PresenterToViewCategoriesProtocol?
    var interactor: PresenterToInteractorCategoriesProtocol?
    var router: PresenterToRouterCategoriesProtocol?
    
    var categories: Categories?
    var selectedCategoryID: Int?
    
    // MARK: Inputs from view
    func viewDidLoad() {
        print("CategoriesPresenter is being notified that the View was loaded.")
        interactor?.setCategories()
    }
    
    func numberOfRowsInSection() -> Int {
        guard let categories = self.categories else {
            return 0
        }
        
        return categories.count
    }
    
    private func getCategory(indexPath: IndexPath) -> CategoryModel? {
        guard let categories = self.categories else {
            return nil
        }
        
        return categories[indexPath.row]
    }
    
    func getCategoryName(indexPath: IndexPath) -> String? {
        guard let category = self.getCategory(indexPath: indexPath),
              let name = category.name else {
            return nil
        }
        
        return name
    }
    
    func getCategoryID(indexPath: IndexPath) -> Int? {
        guard let category = self.getCategory(indexPath: indexPath),
              let id = category.id else {
            return nil
        }
        
        return id
    }
    
    func didSelectRowAt(index: Int) {
        guard let categories = self.categories else {
            return
        }
        
        interactor?.setCategoryID(categoryID: categories[index].id)
    }
    
    func deselectRowAt(index: Int) {
        view?.deselectRowAt(row: index)
    }
}

extension CategoriesPresenter: InteractorToPresenterCategoriesProtocol {
    
    
    func getCategoriesSuccess(categories: Categories) {
        print("CategoriesPresenter receives the categories result from Interactor after it's done its job.")
        self.categories = categories.compactMap { $0 }
    }
    
    func getCategoryIDSuccess(categoryID: Int?) {
        if let categoryID = categoryID {
            router?.dismissCategories(on: view!, with: categoryID)
        }
    }
}
