//
//  Network.swift
//  Cheers!
//
//  Created by yeoni on 2023/09/20.
//

import Foundation
import Alamofire

class Network {
    static let shared = Network()
    
    private init() { }
    
    func request<T: Decodable>(type: T.Type, api: Router, completionHandler: @escaping (Result<T, Error>) -> ()) {
        AF.request(api).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                print(data)
                completionHandler(.success(data))
            case .failure(let error):
                print(error)
                let statusCode = response.response?.statusCode ?? 500
                guard let error = NetworkError(rawValue: statusCode) else { return }
                completionHandler(.failure(error))
            }
        }
    }
    
}
