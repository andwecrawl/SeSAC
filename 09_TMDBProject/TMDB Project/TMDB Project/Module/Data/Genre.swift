//
//  Genre.swift
//  TMDB Project
//
//  Created by yeoni on 2023/08/17.
//

import Foundation

// MARK: - Tv
struct Tv: Codable {
    let genres: [Genre]
}

// MARK: - Movie
struct Movie: Codable {
    let genres: [Genre]
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}
