//
//  SearchRequest.swift
//  TMDB Project
//
//  Created by yeoni on 2023/09/03.
//

import Foundation
import Alamofire

extension TMDBManager {
    
    func callSearchRequest(query: String, completionHandler: @escaping ([Result]) -> ()) {
        let url = "https://api.themoviedb.org/3/search/movie?query=\(query)&size=18"
        
        AF.request(url, method: .get, headers: headers).validate()
            .responseDecodable(of: Search.self, completionHandler: { response in
                switch response.result {
                    
                case .success(let value):
                    guard let result = value.results.first else { return }
                    let id = result.id
                    self.callRecommendationRequest(movieID: id) { movies in
                        completionHandler(movies)
                    }
                case .failure(let error):
                    print(error)
                }
            })
        
    }
    
    func callRecommendationRequest(movieID: Int, completionHandler: @escaping ([Result]) -> ()) {
        let url = "https://api.themoviedb.org/3/movie/\(movieID)/recommendations"
        AF.request(url, method: .get, headers: headers).validate()
            .responseDecodable(of: TMDB.self) { response in
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
