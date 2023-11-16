//
//  Person.swift
//  TMDB Project
//
//  Created by yeoni on 2023/09/03.
//

import Foundation

// MARK: - Person
struct Person: Decodable {
    let page: Int
    let results: [People]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct People: Decodable {
    let adult: Bool
    let id: Int
    let name, originalName: String
    let popularity: Double
    let gender: Int
    let knownForDepartment: String
    let profilePath: String?
    let knownFor: [KnownFor]

    enum CodingKeys: String, CodingKey {
        case adult, id, name
        case originalName = "original_name"
        case popularity, gender
        case knownForDepartment = "known_for_department"
        case profilePath = "profile_path"
        case knownFor = "known_for"
    }
    
    var descriptions: String {
        let gender = gender == 0 ? "male" : "female"
        return "\(knownForDepartment) | \(gender)"
    }
    
    var knownForArr: String {
        let arr = knownFor.map { $0.title ?? $0.originalTitle ?? $0.originalName ?? "이전 작품이 없어요!" }
        var result = ""
        for index in arr.indices {
            result.append(arr[index])
            print(result)
            if index >= 2 {
                return result
            } else {
                result.append(" | ")
            }
            print(result)
        }
        print(result)
        return result
    }
}

// MARK: - KnownFor
struct KnownFor: Decodable {
    let adult: Bool
    let backdropPath: String?
    let id: Int
    let title: String?
    let originalLanguage: String
    let originalTitle: String?
    let overview: String
    let posterPath: String?
    let mediaType: MediaType
    let genreIDS: [Int]
    let popularity: Double
    let releaseDate: String?
    let video: Bool?
    let voteAverage: Double
    let voteCount: Int
    let name, originalName, firstAirDate: String?
    let originCountry: [String]?

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
        case name
        case originalName = "original_name"
        case firstAirDate = "first_air_date"
        case originCountry = "origin_country"
    }
}


