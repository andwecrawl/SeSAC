//
//  MarketManager.swift
//  UpSocket
//
//  Created by yeoni on 12/27/23.
//

import Foundation
import Alamofire
import Combine

class NetworkManager {
    
    static let shared = MarketNetworkManager()
    
    private init() { }
    
    let url = URL(string: "https://api.upbit.com/v1/market/all?isDetails=false")!
    let header: HTTPHeaders = [
        "accept": "application/json"
    ]
    
//    func fetchMarket() -> AnyPublisher<MarketModel, AFError> {
//        return AF.request(url, method: .get, headers: header)
//            .validate()
//            .publishDecodable(type: MarketModel.self)
//            .map({ response in
//                response.mapError { error in
//                    return
//                }
//            })
//            .receive(on: DispatchQueue.main)
//            .eraseToAnyPublisher()
//    }
    
    func fetchMarketData(completion: @escaping ([MarketModel]) -> ()) {
        AF.request(url, method: .get, headers: header)
            .validate(statusCode: 200...500)
            .responseDecodable(of: [MarketModel].self) { response in
                switch response.result {
                case .success(let success):
                    completion(success)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
    
}
