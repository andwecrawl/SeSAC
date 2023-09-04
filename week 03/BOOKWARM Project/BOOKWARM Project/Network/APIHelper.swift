//
//  APIHelper.swift
//  BOOKWARM Project
//
//  Created by yeoni on 2023/09/04.
//

import Foundation
import Alamofire

class APIHelper {
    
    static let shared = APIHelper()
    
    private init() { }
    
    func callRequest(text: String, page: Int, completionHandler: @escaping (Book?) -> ()) {
        
        guard let text = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        let url = "https://dapi.kakao.com/v3/search/book?target=title&query=\(text)&size=20&page=\(page)"
        let header: HTTPHeaders = ["Authorization": "KakaoAK cf98a391517cae5208a42c51880b5107"]
        AF.request(url, method: .get, headers: header).validate(statusCode: 200...500).responseDecodable(of: Book.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(value)
            case .failure(let error):
                guard let statusCode = response.response?.statusCode else { return }
                switch statusCode {
                case 300..<400:
                    print("300... error")
                    print(error)
                case 400..<500:
                    print("400... error")
                    print(error)
                default:
                    print(error)
                }
            }
        }
        
    }
    
}
