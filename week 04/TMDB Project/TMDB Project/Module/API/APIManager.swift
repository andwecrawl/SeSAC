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
    
    static let shared = TMDBManager()
    
    private init() { }
    
    let headers: HTTPHeaders = [
        "accept": "application/json",
        "Authorization": APIKey.auth.rawValue
    ]
    
    
    func callRequest(page: Int = 1, completionHandler: @escaping (JSON) -> ()) {
        let url = "https://api.themoviedb.org/3/trending/all/day?language=en-US&page=\(page)"
        AF.request(url, method: .get, headers: headers).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                for element in json["results"].arrayValue {
                    completionHandler(element)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func callGenereRequest(url: String, id: Int, completionHandler: @escaping (JSON) -> ()) {
        AF.request(url, method: .get, headers: headers).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                for genre in json["genres"] {
                    let content = genre.1
                    if content["id"].intValue == id {
                        print(content["name"].stringValue)
                        completionHandler(content)
                        return
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
}
