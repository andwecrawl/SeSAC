//
//  NetworkBasic.swift
//  Cheers!
//
//  Created by yeoni on 2023/09/20.
//

import Foundation
import Alamofire

class APIHelper {
    static let shared = APIHelper()
    
    private init() { }
    
    func request<T: Decodable>(type: T.Type, api: BeerAPI, completionHandler: @escaping (Result<T, Error>) -> ()) {
        print("hello?")
        AF.request(api.endpoint, method: api.method).responseDecodable(of: T.self) { response in
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
