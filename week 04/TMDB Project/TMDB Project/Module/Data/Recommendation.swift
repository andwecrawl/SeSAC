//
//  Recommendation.swift
//  TMDB Project
//
//  Created by yeoni on 2023/08/19.
//

import Foundation

// MARK: - Recommendation
struct Recommendation: Codable {
    let page: Int
    let results: [RecommendedMovie]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct RecommendedMovie: Codable {
    let adult: Bool
    let backdropPath: String?
    let id: Int
    let title: String
    let originalLanguage: OriginalLanguage
    let originalTitle, overview: String
    let posterPath: String?
    let mediaType: MediaType
    let genreIDS: [Int]
    let popularity: Double
    let releaseDate: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case id, title
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case genreIDS = "genre_ids"
        case popularity
        case releaseDate = "release_date"
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

enum OriginalLanguage: String, Codable {
    case en = "en"
    case it = "it"
    case no = "no"
    case pl = "pl"
}
