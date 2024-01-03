//
//  Router.swift
//  UpSocket
//
//  Created by yeoni on 1/4/24.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    case marketName
    case marketData
    
    var baseURL: URL {
        return URL(string: "https://api.upbit.com/v1/")!
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        switch self {
        case .marketData:
            return ""
        case .marketName:
           return "v1/market/all?isDetails=false"
        }
    }
   
    var header: HTTPHeaders {[
        "accept": "application/json"
    ]}
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.method = method
        request.headers = header
        
        return request
    }
    
    
}
