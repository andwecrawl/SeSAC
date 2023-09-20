//
//  Network.swift
//  Cheers!
//
//  Created by yeoni on 2023/09/20.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    
    case beers
    case singleBeer
    case randomBeer
    
    private var baseURL: URL {
        return URL(string: "https://api.punkapi.com/v2/beers")!
    }
    
    private var path: String {
        switch self {
        case .beers:
            return ""
        case .singleBeer: // 325가지 있음
            return "/1"
        case .randomBeer:
            return "/random"
        }
    }
    
    private var method: HTTPMethod {
        return .get
    }
    
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        let request = try URLRequest(url: url, method: method)
        
        return request
    }
    
    
}
