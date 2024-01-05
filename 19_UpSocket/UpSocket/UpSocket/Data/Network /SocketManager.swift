//
//  SocketManager.swift
//  UpSocket
//
//  Created by yeoni on 1/4/24.
//

import Foundation
import Alamofire
import Combine

class SocketManager: NSObject {
    
    static let shared = SocketManager()
    var codes: [MarketName] = []
    private var request: [String] {
        codes.map { $0.market }
    }
    
    private override init() {
        super.init()
    }
    
    // ping
    private var timer: Timer?
    
    private var webSocket: URLSessionWebSocketTask?
    
    private var isOpen = false
    
    var data = PassthroughSubject<SocketResponse, Never>()
    // 이후 next 대신 send!!
    
    
    // open -> ping ->
    func openWebSocket() {
        if let url = URL(string: "wss://api.upbit.com/websocket/v1") {
            
            let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
                
            self.webSocket = session.webSocketTask(with: url)
            
            webSocket?.resume()
            
            ping()
        }
    }
    
    func closeWebSocket() {
        webSocket?.cancel(with: .goingAway, reason: nil)
        webSocket = nil
        
        isOpen = false
        
        timer?.invalidate()
        timer = nil
    }
    
    
    func send() {
        let str = """
        [
          {
            "ticket": "test example"
          },
          {
            "type": "ticker",
            "codes": \(request)
          },
          {
            "format": "DEFAULT"
          }
        ]
        """
        
        print("==============================================")
        print("===================== request =========================")
        print(request)
        
        webSocket?.send(.string(str), completionHandler: { error in
            if let error {
                print("send error, \(error)")
            }
        })
    }
    
    
    func receive() {
        if isOpen {
            webSocket?.receive(completionHandler: { [weak self] response in
                switch response {
                case .success(let result):
                    switch result {
                    case .data(let data):
                        if let decodeData = try? JSONDecoder().decode(SocketResponse.self, from: data) {
                            print(decodeData)
                            self?.data.send(decodeData)
                        } else {
                            print("decode error")
                        }
                    case .string(let str):
                        print(str)
                        self?.closeWebSocket()
                    @unknown default: print("unknown error")
                    }
                case .failure(let error):
                    print("receive error, \(error)")
                }
            })
        } else {
            print("not open!!")
        }
    }
    
    
    func ping() {
        print("===================== ping!! =====================")
        self.timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true, block: { [weak self] _ in
            self?.webSocket?.sendPing(pongReceiveHandler: { error in
                if let error {
                    print("ping pong error: \(error)")
                } else {
                    print("ping")
                }
            })
        })
        
    }
}


extension SocketManager: URLSessionWebSocketDelegate {
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
        // 연결된 이후 receive 가능!!
        
        print("WebSocket OPEN")
        isOpen = true
        receive()
    }
    
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        isOpen = false
        print("WebSocket closed")
    }
}
