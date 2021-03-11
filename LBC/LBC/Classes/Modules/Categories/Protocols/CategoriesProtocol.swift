//
//  CategoriesProtocol.swift
//  LBC
//
//  Created by Zouhair ASSAIB on 11/03/2021.
//

import UIKit

// MARK: View Output (Presenter -> View)
protocol PresenterToViewCategoriesProtocol: class {
    
    func deselectRowAt(row: Int)
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterCategoriesProtocol: class {
    
    var view: PresenterToViewCategoriesProtocol? { get set }
    var interactor: PresenterToInteractorCategoriesProtocol? { get set }
    var router: PresenterToRouterCategoriesProtocol? { get set }
    
    func viewDidLoad()
    
    var categories: Categories? { get set }
    var selectedCategoryID: Int? { get set }
    
    func numberOfRowsInSection() -> Int
    
    func getCategoryName(indexPath: IndexPath)-> String?
    func getCategoryID(indexPath: IndexPath) -> Int?
    
    func didSelectRowAt(index: Int)
    func deselectRowAt(index: Int)
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorCategoriesProtocol: class {
    
    var presenter: InteractorToPresenterCategoriesProtocol? { get set }
    
    var categories: Categories? { get set }
    
    func setCategories()
    
    func setCategoryID(categoryID: Int?) 
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterCategoriesProtocol: class {
    
    func getCategoriesSuccess(categories: Categories)
    func getCategoryIDSuccess(categoryID: Int?)
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterCategoriesProtocol: class {
    
    static func createModule(with categories: Categories) -> UIViewController
    func dismissCategories(on view: PresenterToViewCategoriesProtocol, with categoryID: Int)
}
