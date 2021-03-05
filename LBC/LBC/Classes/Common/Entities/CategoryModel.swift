//
//  CategoryModel.swift
//  LBC
//
//  Created by Zouhair ASSAIB on 05/03/2021.
//

import Foundation

// MARK: - CategoryModel
struct CategoryModel: Decodable {
    let id: Int?
    let name: String?
}

typealias Categories = [CategoryModel]
