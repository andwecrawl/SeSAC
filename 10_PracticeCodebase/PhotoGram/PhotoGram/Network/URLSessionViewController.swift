//
//  URLSessionViewController.swift
//  PhotoGram
//
//  Created by yeoni on 2023/08/30.
//

import UIKit

class URLSessionViewController: UIViewController {
    
    var session: URLSession!
    
    var total: Double = 0
    
    var buffer: Data? {
        // 프로퍼티 옵저버!!
        didSet {
            let result = Double(buffer?.count ?? 0) // total
            if total == 0 {
                progressLabel.text = "0%"
            } else {
                progressLabel.text = "\(Int(result / total * 100))%"
            }
            print(result, total)
        }
    }
    
    let progressLabel = {
        let view = UILabel()
        view.backgroundColor = .black
        view.textColor = .white
        return view
    }()
    
    let imageView = {
        let view = UIImageView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    
    // 어떤 특성이 있고 그래서 우리가 alamofire에서 어떤 식으로 구현했군아
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        // buffer?.append(data)가 실행되기 위함!!
        // buffer가 nil이면 append가 실행되지 않으니까!
        buffer = Data()
        
        view.addSubview(imageView)
        view.addSubview(progressLabel)
        
        progressLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(100)
        }
        
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(300)
        }
        
        
        
        
        let url = URL(string: "https://apod.nasa.gov/apod/image/2308/M66_JwstTomlinson_3521.jpg")
        
        // delegate: self <- 너 딜리게이트 method는 어디서 할 거야?? 가 있음
        // delegateQueue => main에서 할 거라고 말하고 잇음 ..
        // 만약에 이걸 global로 만들어놨다고 한다면 view 업데이트의 경우에는 메인에서 하는 걸 추가해야 했을 텐데 요기서는 지금 main에서 하고 잇음!!
        session = URLSession(configuration: .default, delegate: self, delegateQueue: .main)
        
        // 시작점과 끝점을 알 수 있도록!!
        
        session.dataTask(with: url!).resume()
        
//        URLSession.shared.dataTask(with: <#T##URLRequest#>, completionHandler: <#T##(Data?, URLResponse?, Error?) -> Void#>)
    }
    
    // 카카오톡 사진 다운로드: 다운로드 중에 다른 채팅방으로 넘어가면?
        // 그냥 다운로드 받을 수 있게 해 줌...
        // 근데 이게 힘들 것 같으면 현재 다운로드되고 있는 네트워크 통신을 중단해 주는 코드가 필요할 거잉
        // ㅋㅋ 우리는 못 멈춤!!!!!!!!!!!!!!
        // 그럼 어케 할 수 있을까?
        // 시점은 우리가 고려해 주면 댐 ㅇㅇ
        
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        // 취소 액션(화면이 사라질 때 등)
        // 리소스를 바로 정리하는 거임!! (실행 중인 것도 무시하고 정리함)
        session.invalidateAndCancel()
        
        
        // 기다렸다가 리소스 끝나면 정리해 주는 코드도 있음
        session.finishTasksAndInvalidate()
        
        
    }
    
}

extension URLSessionViewController: URLSessionDataDelegate {
    
    // 서버에서 최초로 응답받은 경우에 호출(상태코드 처리)
    // 200~500까지 상태코드를 처리했던 것처럼 처리하는 게 필요함!!
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse) async -> URLSession.ResponseDisposition {
        // response가 잘 왔는지 체크하고 상태코드 구성!!
        print("RESPONSE", response)
        if let response = response as? HTTPURLResponse, (200...500).contains(response.statusCode) {
            
            // 이 헤더키에 있는 값을 가져오는 거잉
            total = Double(response.value(forHTTPHeaderField: "Content-Length")!)!
            
            
            return .allow
        } else {
            // 이후 서버에서 데이터를 호출하는 경우에 대해서 미리 처리해 주는 거임
            // 응답이 이상하게 됐을 때 이후 반복적으로 호출하거나 호출이 완료되었을 때 method가 실행되지 않도록!!
            return .cancel
        }
        
    }
    
    
    // 서버에서 데이터 받을 때마다 반복적으로 호출!!
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        print("Data:", data)
        
        // buffer가 nil이면 append 구문 자체가 실행이 안 될 수 있음!!
        buffer?.append(data)
    }
    
    
    // 서버에서 응답이 완료된 이후에 호출
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        print("End")
        if let error {
            print(error)
        } else {
            
            guard let buffer = buffer else {
                print(error)
                return
            }
            
            imageView.image = UIImage(data: buffer)
                
        }
    }
    
    
    
    
}
