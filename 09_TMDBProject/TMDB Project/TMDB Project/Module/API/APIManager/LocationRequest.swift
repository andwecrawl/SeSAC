//
//  LocationRequest.swift
//  TMDB Project
//
//  Created by yeoni on 12/11/23.
//

import Foundation
import Alamofire

class LocationRequest {
    
    static let shared = LocationRequest()
    
    private init() { }
    
    let headers: HTTPHeaders = [
        "Authorization": APIKey.kakao.rawValue
    ]
    
    
    func getNearbyCinema(currentLong: String, currentLait: String, completionHandler: @escaping ([Theater]) -> ()) {
        let url = "https://dapi.kakao.com/v2/local/search/keyword.json"
        
        let query: [String: Any] = [
            "query": "영화관",
            "x": "\(currentLong)",
            "y": "\(currentLait)",
            "radius": 16000
        ]
        
        AF.request(url, method: .get, parameters: query, encoding: URLEncoding.default, headers: headers)
            .responseDecodable(of: NearbyCinema.self) { response in
                switch response.result {
                case .success(let success):
                    completionHandler(success.documents)
                case .failure(let failure):
                    print(failure)
                }
            }
    }
    
    
    
}
