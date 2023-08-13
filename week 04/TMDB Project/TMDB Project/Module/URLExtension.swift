//
//  URLExtension.swift
//  TMDB Project
//
//  Created by yeoni on 2023/08/13.
//

import Foundation

extension URL {
    static let basicImageURL = "https://image.tmdb.org/t/p/w500/"
    
    static func makeImageURL(imagePath: String) -> String {
        return basicImageURL + imagePath
    }
}

extension URL {
    static var media: Media = .movie
    static var genreURL: String {
        return "https://api.themoviedb.org/3/genre/\(media.rawValue)/list"
    }
}
