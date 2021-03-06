//
//  APIManager.swift
//  LBC
//
//  Created by Zouhair ASSAIB on 05/03/2021.
//

import Foundation

// MARK: - APIManager
class APIManager {
    
    static let shared = { APIManager() }()
    
    lazy var baseURL: String = { return Constants.url }()
}
