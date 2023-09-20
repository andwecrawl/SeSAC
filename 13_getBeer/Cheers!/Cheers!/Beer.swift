//
//  Beer.swift
//  Cheers!
//
//  Created by yeoni on 2023/09/20.
//

import Foundation

// MARK: - BeerElement
struct BeerElement: Codable {
    let id: Int
    let name, tagline, firstBrewed, description: String
    let abv: Double
    let ibu: Double?
    let imageURL: String
    let foodPairing: [String]
    let brewersTips: String
    let contributedBy: String

    enum CodingKeys: String, CodingKey {
        case id, name, tagline
        case firstBrewed = "first_brewed"
        case description
        case abv, ibu
        case imageURL = "image_url"
        case foodPairing = "food_pairing"
        case brewersTips = "brewers_tips"
        case contributedBy = "contributed_by"
    }
}

typealias Beer = [BeerElement]
