//
//  BeerAPI.swift
//  Cheers!
//
//  Created by yeoni on 2023/09/20.
//

import Foundation
import Alamofire

enum BeerAPI {
    case beers
    case singleBeer
    case randomBeer
    
    private var baseURL: String {
        return "https://api.punkapi.com/v2/beers"
    }
    
    var endpoint: URL {
        switch self {
        case .beers:
            return URL(string: baseURL)!
        case .singleBeer: // 325가지 있음
            return URL(string: baseURL + "/1")!
        case .randomBeer:
            return URL(string: baseURL + "/random")!
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
}
