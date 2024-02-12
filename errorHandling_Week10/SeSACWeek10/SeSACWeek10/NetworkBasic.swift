//
//  NetworkBasic.swift
//  SeSACWeek10
//
//  Created by yeoni on 2023/09/19.
//

import Foundation
import Alamofire


enum SeSACError: Int, Error {
    case missingParameter = 400
    case unauthorized = 401 // 웬만해서는 토큰 error
    case permissionDenied = 403
    case invaildServer = 500

//    error 관련 프로토콜 => Localized Error
    var errorDescription: String {
        switch self {
        case .missingParameter:
            return ""
        case .unauthorized:
            return "인증 정보가 습니다"
        case .permissionDenied:
            return "권한이 업습니다"
        case .invaildServer:
            return "서버 점검 중입니다"
        }
    }
}



final class NetworkBasic {
    
    static let shared = NetworkBasic()
    
    private init() { }
    
    // searchPhoto
    // func request(query: String, completionHandler: @escaping (Photo?, Error?)
    func request(api: SeSACAPI, query: String, completion: @escaping (Result<Photo, SeSACError>) -> ()) {
        let api = SeSACAPI.search(query: query)
        
        // encoding parameter를 queryString으로 보내게끔!!
        AF.request(api.endpoint, method: api.method, parameters: api.query, encoding: URLEncoding(destination: .queryString), headers: api.header).validate(statusCode: 200...500).responseDecodable(of: Photo.self) { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure(_):
                    let statusCode = response.response?.statusCode ?? 500
                    guard let error = SeSACError(rawValue: statusCode) else { return }
                    // 프로토콜 타입으로 사용하고 있기 때문에 AFError <- Error가 변환댄거잉
                    completion(.failure((error)))
                    
                }
            }
    }
    
    func random(api: SeSACAPI, completion: @escaping (Result<PhotoResult, SeSACError>) -> Void) {
        let api = SeSACAPI.random
        
        // encoding parameter를 queryString으로 보내게끔!!
        AF.request(api.endpoint, method: .get, headers: api.header).validate(statusCode: 200...500)
            .responseDecodable(of: PhotoResult.self) { response in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                    
                case .failure(_):
                    let statusCode = response.response?.statusCode ?? 500
                    guard let error = SeSACError(rawValue: statusCode) else { return }
                    // 프로토콜 타입으로 사용하고 있기 때문에 AFError <- Error가 변환댄거잉
                    completion(.failure((error)))
                    
                }
            }
    }
    
    func detailPhoto(api: SeSACAPI, id: String, completion: @escaping (Result<PhotoResult, SeSACError>) -> ()) {
        let api = SeSACAPI.photo(id: id)
        
        AF.request(api.endpoint, method: api.method, headers: api.header).validate(statusCode: 200...500)
            .responseDecodable(of: PhotoResult.self) { response in
                switch response.result {
                case .success(let value):
                    dump(value)
                    completion(.success(value))
                case .failure(_):
                    let statusCode = response.response?.statusCode ?? 500
                    guard let error = SeSACError(rawValue: statusCode) else { return }
                    // 프로토콜 타입으로 사용하고 있기 때문에 AFError <- Error가 변환댄거잉
                    completion(.failure((error)))
                }
            }
    }
    
    
}
