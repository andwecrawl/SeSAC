//
//  Genre.swift
//  TMDB Project
//
//  Created by yeoni on 2023/08/17.
//

import Foundation

// MARK: - Tv
struct Tv: Decodable {
    let genres: [Genre]
}

// MARK: - Movie
struct Movie: Decodable {
    let genres: [Genre]
}

// MARK: - Genre
struct Genre: Decodable {
    let id: Int
    let name: String
}
