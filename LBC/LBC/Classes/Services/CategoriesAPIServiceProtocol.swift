//
//  CategoriesAPIServiceProtocol.swift
//  LBC
//
//  Created by Zouhair ASSAIB on 08/03/2021.
//

import Foundation

protocol CategoriesAPIServiceProtocol {
    func getCategories(success: @escaping (Categories) -> (), failure: @escaping (Error) -> ())
}
