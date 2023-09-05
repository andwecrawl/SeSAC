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
    
    let header = ["Authorization": "KakaoAK cf98a391517cae5208a42c51880b5107"]
    
    func callSessionRequest(text: String, page: Int, completionHandler: @escaping (Book?) -> ()) {
        guard let text = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        guard let url = URL(string: "https://dapi.kakao.com/v3/search/book?target=title&query=\(text)&size=20&page=\(page)") else { return }
        print(text, url)
        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        request.addValue("KakaoAK cf98a391517cae5208a42c51880b5107", forHTTPHeaderField: "Authorization")
        request.allHTTPHeaderFields = header
        
//        let defaultSession = URLSession(configuration: .default)
        
        print("hello")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            print("it worked!")
            if let error = error {
                print("error", error)
                completionHandler(nil)
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...500).contains(response.statusCode) else {
                completionHandler(nil)
                return
            }
            
            print("result?")
            print(String(data: data ?? Data(), encoding: .utf8))
            do {
                let result = try JSONDecoder().decode(Book.self, from: data!)
                DispatchQueue.main.async {
                    completionHandler(result)
                }
            } catch {
                print(error)
                completionHandler(nil)
            }
            
        }.resume()
    }
//    
//    func callRequest(text: String, page: Int, completionHandler: @escaping (Book?) -> ()) {
//        
//        guard let text = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
//        let url = "https://dapi.kakao.com/v3/search/book?target=title&query=\(text)&size=20&page=\(page)"
//        
//        AF.request(url, method: .get, headers: header).validate(statusCode: 200...500).responseDecodable(of: Book.self) { response in
//            switch response.result {
//            case .success(let value):
//                completionHandler(value)
//            case .failure(let error):
//                guard let statusCode = response.response?.statusCode else { return }
//                switch statusCode {
//                case 300..<400:
//                    print("300... error")
//                    print(error)
//                case 400..<500:
//                    print("400... error")
//                    print(error)
//                default:
//                    print(error)
//                }
//            }
//        }
//        
//    }
    
}
