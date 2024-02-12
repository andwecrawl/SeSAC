//
//  Router.swift
//  SeSACWeek10
//
//  Created by yeoni on 2023/09/20.
//

import Foundation
import Alamofire


enum Router: URLRequestConvertible {
    
    private static let key: String = "xP4JMd7k7O-FK8MpsOQsjh8wtGhUxveUlom_v8YPlr0"
    
    case search(query: String)
    case random
    case photo(id: String)
    
    // private keyword를 통해 컴파일 성능을 높일 수 있음!!
    private var baseURL: URL {
        return URL(string: "https://api.unsplash.com/")!
    }
    
    // baseURL이 각각 하나라고 생각하면 안댐!!
    // 같은 baseURL이어도 조건에 따라 다르구 다 다르당
    private var path: String { // 오잉 이제는 다른 파일로 넘어갈 필요가 없넹
        switch self {
        case .search:
            return "search/photos"
        case .random:
            return "photos/random"
        case .photo(let id):
            return "photos/\(id)"
        }
    }
    
    private var header: HTTPHeaders {
        return ["Authorization": "Client-ID \(Router.key)"]
    }
    
    private var method: HTTPMethod {
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
    
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        // 얘를 만들 때 애초에 구성을 해 주는 거임!!
        var request = URLRequest(url: url)
        request.headers = header
        request.method = method
        
        // JSONParameterEncoder도 잇음
        // 어떤 방식으로 인코딩하는지 확인!!
        request = try URLEncodedFormParameterEncoder(destination: .methodDependent).encode(query, into: request)
        
        // 궁금하면 destination의 조건에 따라 요청값이 어떻게 달라지는지 확인해봐도 좋을 것 같음
        
        
        return request
    }
    
}
