//
//  Error+Extension.swift
//  LBC
//
//  Created by Zouhair ASSAIB on 05/03/2021.
//

import Foundation

// MARK: - HttpRequestError
enum HttpRequestError: Error {
    case invalidResponse
    case unexpected
}

extension HttpRequestError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return NSLocalizedString("Invalid response", comment: "Invalid response")
        case .unexpected:
            return NSLocalizedString("Unexpected error", comment: "Unexpected error")
        }
    }
}
