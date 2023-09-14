//
//  APIHelper.swift
//  PhotoGram
//
//  Created by yeoni on 2023/09/01.
//

import Foundation

class APIHelper {
    
    static let shared = APIHelper()
    
    private init() { }
    
    func callRequest(query: String, completionHandler: @escaping (Search?) -> ()) {
        guard let url = URL(string: "https://api.unsplash.com/search/photos?query=\(query)&client_id=\(APIKey.unsplash.rawValue)") else { return }
        
        let request = URLRequest(url: url, timeoutInterval: 5)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error {
                // error 처리
                completionHandler(nil)
            }
            
            guard let response = response as? HTTPURLResponse, (200...500).contains(response.statusCode) else {
                // error 처리
                completionHandler(nil)
                return
            }
            
            guard let data = data else {
                // error 처리
                completionHandler(nil)
                return
            }
            
            do {
                // 코더블 구조가 잘 들어갈 경우!!
                let result = try JSONDecoder().decode(Search.self, from: data)
                // 데이터 전달 클로저!!
                completionHandler(result)
                
            } catch {
                // try에서 던진 에러 잡기
                // 여기서도 error처리 코드!!
                completionHandler(nil)
            }
        }.resume()
    }
}
