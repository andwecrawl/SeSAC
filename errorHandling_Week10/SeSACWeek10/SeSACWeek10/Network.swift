//
//  Network.swift
//  SeSACWeek10
//
//  Created by yeoni on 2023/09/19.
//

import Foundation
import Alamofire

class Network {
    
    static let shared = Network()
    
    private init() { }
    
    func requestConvertible<T: Decodable>(type: T.Type, api: Router, completion: @escaping (Result<T, SeSACError>) -> ()) {
        
        AF.request(api).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(_):
                let statusCode = response.response?.statusCode ?? 500
                guard let error = SeSACError(rawValue: statusCode) else { return }
                // 프로토콜 타입으로 사용하고 있기 때문에 AFError <- Error가 변환댄거잉
                completion(.failure(error))
                
            }
        }
    }
    
    
    func request<T: Decodable>(type: T.Type, api: SeSACAPI, completion: @escaping (Result<T, SeSACError>) -> ()) {
        
        // encoding parameter를 queryString으로 보내게끔!!
        AF.request(api.endpoint, method: api.method, parameters: api.query, encoding: URLEncoding(destination: .queryString), headers: api.header)
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(_):
                    let statusCode = response.response?.statusCode ?? 500
                    guard let error = SeSACError(rawValue: statusCode) else { return }
                    // 프로토콜 타입으로 사용하고 있기 때문에 AFError <- Error가 변환댄거잉
                    completion(.failure(error))
                    
                }
            }
    }
}
