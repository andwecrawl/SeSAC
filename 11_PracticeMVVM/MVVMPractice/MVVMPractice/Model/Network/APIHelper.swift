//
//  APIHelper.swift
//  MVVMPractice
//
//  Created by yeoni on 2023/09/14.
//

import Foundation

class APIHelper {
    
    static let shared = APIHelper()
    
    private init() { }
    
    func requestLotto(drwNo: Int, completionHandler: @escaping (Lotto?, String) -> ()) {
        
        guard let url = URL(string: "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(drwNo)") else { return }
        let request = URLRequest(url: url, timeoutInterval: 3)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                completionHandler(nil, "서버 통신 실패!")
            }
            
            guard let response = response as? HTTPURLResponse, (200...500).contains(response.statusCode) else {
                return
            }
            
            guard let data else { return }
            
            if (200..<300) ~= response.statusCode {
                do {
                    let result = try JSONDecoder().decode(Lotto.self, from: data)
                    DispatchQueue.main.async {
                        completionHandler(result, "success!")
                    }
                } catch {
                    print(error)
                }
            } else if (400..<500) ~= response.statusCode {
                do {
                    let result = try JSONDecoder().decode(Lotto.self, from: data)
                    DispatchQueue.main.async {
                        completionHandler(result, "서버 통신 오류!")
                    }
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
}
