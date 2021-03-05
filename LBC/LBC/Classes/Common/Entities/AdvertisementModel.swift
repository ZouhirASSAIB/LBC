//
//  AdvertisementModel.swift
//  LBC
//
//  Created by Zouhair ASSAIB on 05/03/2021.
//

import Foundation

// MARK: - AdvertisementModel
struct AdvertisementModel: Decodable {
    let id, categoryID: Int?
    let title, advertisementDescription: String?
    let price: Int?
    let imagesURL: ImagesURL?
    let creationDate: String?
    let isUrgent: Bool?
    let siret: String?

    enum CodingKeys: String, CodingKey {
        case id
        case categoryID = "category_id"
        case title
        case advertisementDescription = "description"
        case price
        case imagesURL = "images_url"
        case creationDate = "creation_date"
        case isUrgent = "is_urgent"
        case siret
    }
}

// MARK: - ImagesURL
struct ImagesURL: Codable {
    let small, thumb: String?
}

typealias Advertisements = [AdvertisementModel]
