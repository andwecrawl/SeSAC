//
//  APIManager.swift
//  TMDB Project
//
//  Created by yeoni on 2023/08/13.
//


import Foundation
import Alamofire
import SwiftyJSON

class TMDBManager {
    
    static var movieGenre: [Genre] = []
    static var tvGenre: [Genre] = []
    
    static let shared = TMDBManager()
    
    private init() { }
    
    let headers: HTTPHeaders = [
        "accept": "application/json",
        "Authorization": APIKey.auth.rawValue
    ]
    
    func callRequest(page: Int = 1, deliverValue: @escaping (TMDB, [String]) -> ()) {
        
        let url = "https://api.themoviedb.org/3/trending/all/day?language=en-US&page=\(page)"
        
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
                    print(error)
                }
            }
        
    }
    
    func callRequestCodable(page: Int = 1, completionHandler: @escaping (TMDB, [String]) -> ()) {
       
        
        if TMDBManager.movieGenre.isEmpty && TMDBManager.tvGenre.isEmpty {
            
            self.callMovieRequest(url: URL.getGenreURL(media: .movie)) {
                self.callTvRequest(url: URL.getGenreURL(media: .tv)) {
                    self.callRequest(page: page) { data, genre in
                        completionHandler(data, genre)
                    }
                }
            }
            
        } else {
            
            self.callRequest(page: page) { data, genre in
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
                        print(error)
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
                    print(error)
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
                    print(error)
                }
            }
    }
}

extension TMDBManager {
    
    func callSearchRequest(query: String, completionHandler: @escaping (Int) -> ()) {
        let url = "https://api.themoviedb.org/3/search/movie?query=\(query)"
        AF.request(url, method: .get, headers: headers).validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    print("JSON: \(json)")
                    let id = json["results"][0]["id"].intValue
                    print(id)
                    
                    completionHandler(id)
                case .failure(let error):
                    print(error)
                }
            }
        
    }
    
    func callRecommendationRequest(movieID: Int, completionHandler: @escaping ([RecommendedMovie]) -> ()) {
        let url = "https://api.themoviedb.org/3/movie/\(movieID)/recommendations"
        AF.request(url, method: .get, headers: headers).validate()
            .responseDecodable(of: Recommendation.self) { response in
                switch response.result {
                case .success(let value):
                    let movies = value.results
                    completionHandler(movies)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    
    
}
