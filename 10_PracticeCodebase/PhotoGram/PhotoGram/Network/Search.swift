//
//  Search.swift
//  PhotoGram
//
//  Created by yeoni on 2023/09/01.
//

import Foundation

// MARK: - Search
struct Search: Codable {
    let total, totalPages: Int
    let results: [Result]

    enum CodingKeys: String, CodingKey {
        case total
        case totalPages = "total_pages"
        case results
    }
}

// MARK: - Result
struct Result: Codable {
    let id: String
    let urls: Urls
}

// MARK: - Urls
struct Urls: Codable {
    let full, regular, small: String
    let thumb: String
}
