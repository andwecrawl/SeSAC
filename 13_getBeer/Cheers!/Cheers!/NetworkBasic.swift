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
    
    func request(api: BeerAPI, completionHandler: @escaping (Beer?, Error?) -> ()) {
        AF.request(api.endpoint, method: api.method).responseDecodable(of: Beer.self) { response in
            switch response.result {
            case .success(let data):
                completionHandler(data, nil)
            case .failure(_):
                let statusCode = response.response?.statusCode ?? 500
                guard let error = NetworkError(rawValue: statusCode) else { return }
                completionHandler(nil, error)
            }
        }
    }
    
}
