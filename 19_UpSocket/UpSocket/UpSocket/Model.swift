//
//  Model.swift
//  UpSocket
//
//  Created by yeoni on 12/27/23.
//

import Foundation

struct MarketModel: Decodable {
    let market, koreanName, englishName: String

    enum CodingKeys: String, CodingKey {
        case market
        case koreanName = "korean_name"
        case englishName = "english_name"
    }
}
