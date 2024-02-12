//
//  SeSACAPI.swift
//  SeSACWeek10
//
//  Created by yeoni on 2023/09/19.
//

import Foundation
import Alamofire

// 어떤 구조로 이루어져 있겠거니~ 하는 걸 알 수 있음
//enum Router: URLRequestConvertible {
//    func asURLRequest() throws -> URLRequest {
//        
//    }
//    
//}


enum SeSACAPI {
    
    private static let key: String = "xP4JMd7k7O-FK8MpsOQsjh8wtGhUxveUlom_v8YPlr0"
    
    case search(query: String)
    case random
    case photo(id: String)
    
    // private keyword를 통해 컴파일 성능을 높일 수 있음!!
    private var baseURL: String {
        return "https://api.unsplash.com/"
    }
    
    // baseURL이 각각 하나라고 생각하면 안댐!!
    // 같은 baseURL이어도 조건에 따라 다르구 다 다르당
    var endpoint: URL {
        switch self {
        case .search:
            return URL(string: baseURL + "search/photos")!
        case .random:
            return URL(string: baseURL + "photos/random")!
        case .photo(let id):
            return URL(string: baseURL + "photos/\(id)")!
        }
    }
    
    var header: HTTPHeaders {
        return ["Authorization": "Client-ID \(SeSACAPI.key)"]
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var query: [String: String] {
        switch self {
        case .search(let query):
            return ["query": query]
        case .random, .photo:
            return ["": ""]
        }
    }
}

