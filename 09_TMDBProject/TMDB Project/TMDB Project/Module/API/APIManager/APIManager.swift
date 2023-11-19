//
//  APIManager.swift
//  TMDB Project
//
//  Created by yeoni on 2023/08/13.
//


import Foundation
import Alamofire

enum Trends: String {
    case all, movie, tv, person
    
    var index: Int {
        get {
            switch self {
            case .all:
                return 0
            case .movie:
                return 1
            case .tv:
                return 2
            case .person:
                return 3
            }
        }
    }
    
    static func caseAtIndex(_ index: Int) -> Trends? {
        switch index {
        case 0:
            return .all
        case 1:
            return .movie
        case 2:
            return .tv
        case 3:
            return .person
        default:
            return nil
        }
    }
    
    mutating func setIndex(_ newIndex: Int) {
        if let newCase = Trends.caseAtIndex(newIndex) {
            self = newCase
        }
    }
}

class TMDBManager {
    
    static var movieGenre: [Genre] = []
    static var tvGenre: [Genre] = []
    
    static let shared = TMDBManager()
    
    private init() { }
    
    let headers: HTTPHeaders = [
        "accept": "application/json",
        "Authorization": APIKey.auth.rawValue
    ]
    
    func callRequest(page: Int = 1, segment: Trends, deliverValue: @escaping (TMDB, [String]) -> ()) {
        var url = ""
        switch segment {
        case .all:
            url = "https://api.themoviedb.org/3/trending/all/day?language=en-US&page=\(page)"
        default:
            url = "https://api.themoviedb.org/3/trending/\(segment.rawValue)/day?language=en-US"
        }
        
        AF.request(url, method: .get, headers: headers).validate()
            .responseDecodable(of: TMDB.self) { response in
                switch response.result {
                case .success(let value):
                    var genreArray: [String] = []
                    
                    for element in value.results {
                        if element.mediaType == .movie {
                            for genre in TMDBManager.movieGenre {
                                if genre.id == element.genreIDS[0] {
                                    genreArray.append(genre.name)
                                }
                            }
                        } else {
                            for genre in TMDBManager.tvGenre {
                                if genre.id == element.genreIDS[0] {
                                    genreArray.append(genre.name)
                                }
                            }
                        }
                        
                    }
                    deliverValue(value, genreArray)
                    
                case .failure(let error):
                    print("movie", error)
                }
            }
        
    }
    
    
    func callRequestCodable(page: Int = 1, segment: Trends, completionHandler: @escaping (TMDB, [String]) -> ()) {
       
        
        if TMDBManager.movieGenre.isEmpty && TMDBManager.tvGenre.isEmpty {
            
            self.callMovieRequest(url: URL.getGenreURL(media: .movie)) {
                self.callTvRequest(url: URL.getGenreURL(media: .tv)) {
                    self.callRequest(page: page, segment: segment) { data, genre in
                        completionHandler(data, genre)
                    }
                }
            }
            
        } else {
            
            self.callRequest(page: page, segment: segment) { data, genre in
                completionHandler(data, genre)
            }
        }
    }
    
    func callTvRequest(url: String, completionHandler: @escaping () -> ()) {
            AF.request(url, method: .get, headers: headers).validate()
                .responseDecodable(of: Tv.self) { response in
                    switch response.result {
                    case .success(let value):
                        TMDBManager.tvGenre = value.genres
                        completionHandler()
                    case .failure(let error):
                        print("tvGenre", error)
                    }
                }
        }
    
    func callMovieRequest(url: String, completionHandler: @escaping () -> ()) {
        AF.request(url, method: .get, headers: headers).validate()
            .responseDecodable(of: Movie.self) { response in
                switch response.result {
                case .success(let value):
                    TMDBManager.movieGenre = value.genres
                    completionHandler()
                case .failure(let error):
                    print("movieGenre", error)
                }
            }
    }
    
    
    func callCastRequest(movieID: Int, completionHandler: @escaping ([CastElement]) -> ()) {
        let url = "https://api.themoviedb.org/3/movie/\(movieID)/credits"
        AF.request(url, method: .get, headers: headers).validate()
            .responseDecodable(of: Cast.self) { response in
                switch response.result {
                case .success(let value):
                    let casting = value.cast
                    completionHandler(casting)
                case .failure(let error):
                    print("cast", error)
                }
            }
    }
}
