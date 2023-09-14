//
//  APIService.swift
//  PhotoGram
//
//  Created by yeoni on 2023/08/30.
//

import Foundation

class APIService {
    
    private init() { }
    
    // 인스턴스 생성 방지
    static let shared = APIService()
    
    // 굉장히 오랜 시간 동안 네트워크에 대한 응답을 기다려야 함
    // 중간중간에 진행률을 알 수 있다!!
    
    func callRequest(query: String, completionHandler: @escaping (Photo?) -> Void) {
        // 첫 번째 필수 Method url / 두 번째 캐시 정책 / 세 번째 타임아웃인터벌(시간 설정)
        // 네트워크 통신에서 응답이 너무 안 오면 사용자는 기다릴 수 없음 ㅡㅡ
        // 걍 n초만 기다리다가 안 오면 다시 시도해달라고 하자!! => 기본으로 60초 가지고 있지만 보통 3~5초 정도로 사용함
        guard let url = URL(string: "https://api.unsplash.com/search/photos?query=\(query)&client_id=\(APIKey.unsplash.rawValue)") else { return }
        let request = URLRequest(url: url, timeoutInterval: 5)
        
        // 요청을 보내는 게 앞에 시작!!
        // 어디를 보낼지에 대한 게 첫 번째 매개변수로 실행댐
        // 응답 받고 나면 클로저 실행!!
        // 클로저의 첫 번째 매개변수는 data 형식으로 매개변수 반환
        // 근데 안에 다 optional로 되어잇음
        // data가 잘 오면 error는 nil / 반대도 마찬가지임!
        // 모든 값들이 nil을 받을 수 있는 상태여야 함
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            // 본래라면 뷰를 설정해 줄 때 main Thread로 넘겨줘야 하지만 응답값을 받고 나서 여기서부터 넘겨주게 되면 이후 mainThread로 넘겨주는 코드를 매번 작성하지 않아도 댐
            DispatchQueue.main.async {
                // dataTask의 경우에는 global Thread에서 실행되게 됨
                
                // error가 nil인지 아닌지를 한번 봐야 할 거 가틈
                
                if let error = error {
                    // 에러라믄...
                    completionHandler(nil)
                    return
                }
                
                guard let response = response as? HTTPURLResponse, (200...500).contains(response.statusCode) else {
                    // 지금은 프린트문으로 띄워주고 잇지만
                    // Alert 또는 Do try Catch로 구현하여 사용자한테 알려주는 게 필요할 거잉
                    completionHandler(nil)
                    return
                }
                
                guard let data = data else {
                    completionHandler(nil)
                    return
                }
                
                do {
                    // 코더블 구조에 데이터가 잘 들어갈 경우!!
                    let result = try JSONDecoder().decode(Photo.self, from: data)
                    completionHandler(result)
                    print(result)
                } catch {
                    // 문제가 생겼을 때는 그 에러를 잡아줄 거잉
                    // 이렇게 에러를 잡아야 디코딩 오류가 났을 때 어떤 키가 문제인지 알 수 있을 거임
                    // 서버쪽 오류도 생길 수 잇고 내가 오류를 맹글었을 수도 있기에 아래 error를 보고 맞는지 판단해야 하는 거임
                    completionHandler(nil)
                }
            }
            
            // 위와 아래는 비슷함
            // 근데 do-try문을 안 쓰고 아래처럼 쓴다면 그냥 result는 nil이 뜨고 말아버림
            // 디코딩이 불가!!
            // try! < try? < do try catch문으로 ^_^
            
//            let result = try? JSONDecoder().decode(Photo.self, from: data)
            
            
            
        }.resume()
        
    }
}


struct Photo: Codable {
    let total: Int
    let total_pages: Int
    let results: [PhotoResult]
}

struct PhotoResult: Codable {
    var id: String
    var urls: PhotoURL
}

// 서버 입장에서는 이미지 해상도도 중요함 ㅇ.ㅇ
// 만들 때도 이미지 해상도에 따라 로딩 시간이 달라질 수 있으니 생각해 보는 것두!! 좋음
struct PhotoURL: Codable {
    var full: String
    var thumb: String
}

