//
//  URLExtension.swift
//  TMDB Project
//
//  Created by yeoni on 2023/08/13.
//

import Foundation

// 이미지를 가져오기 위한 URL을 생성하기 위한 extension
extension URL {
    static let basicImageURL = "https://image.tmdb.org/t/p/w500/"
    
    static func makeImageURL(imagePath: String) -> URL? {
        return URL(string: basicImageURL + imagePath)
    }
}

// tv인지 movie인지를 알고 가져오는 URL을 return
extension URL {
    static func getGenreURL(media: MediaType) -> String {
        return "https://api.themoviedb.org/3/genre/\(media.rawValue)/list"
    }
}
