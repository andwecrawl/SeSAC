//
//  ViewController.swift
//  SignInWith
//
//  Created by yeoni on 12/28/23.
//

import UIKit
import AuthenticationServices

/*
<<<<<<< HEAD
=======
 1. Build Configuration: Debug / Release
    만약에 같은 앱을 light / origin / pro로 비슷한데 조금~~씩만 다른 버전을 배포한다고 하면?
 2.
 */

/*
>>>>>>> upsocket_network
 소셜 로그인 기능 구현 시 애플 로그인 기능 구현 필수
 근데 자체 로그인만 구성되어 있다면? 굳이 애플 로그인 기능을 구현하지 않아도 댐
 애플로 로그인 -> 개인 개발자 계정이 있어야 가능함
 */

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
    }
    
}

class ViewController: UIViewController {
    
    @IBOutlet weak var appleLoginButton: ASAuthorizationAppleIDButton!
    
    @IBOutlet weak var faceIDButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appleLoginButton.addTarget(self, action: #selector(appleLoginButtonTapped), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    
    @objc func appleLoginButtonTapped() {
        let appleProvider = ASAuthorizationAppleIDProvider()
        let request = appleProvider.createRequest()
        request.requestedScopes = [.email, .fullName]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self // 로직
        controller.presentationContextProvider = self
        controller.performRequests()
        
    }
    
}

extension ViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
        // 항상 같은 UI로 띄워줄 수 있게끔 정의되어 잇음
    }
    
    
}



extension ViewController: ASAuthorizationControllerDelegate {
    
    
    // 실패함
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        
        print("login failed \(error.localizedDescription)")
        
    }
    
    // 성공함 -> 로그인 페이지로 이동 등...
    // 첫 번째 시도: 계속, Email, Fullname wprhd
    // 두 번째 시도: 로그인 할래요? Email, fullName 값이 nil로 온다.
    // 사용자에 대한 정보를 계속 제공해 주지 않음 => 최초에만 적용!
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            print(appleIDCredential)
            
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            guard let token = appleIDCredential.identityToken,
                  let tokenToString = String(data: token, encoding: .utf8) else {
                print("token error")
                return
            }
            
            // UserDefaults
            print(userIdentifier)
            print(fullName ?? "no fullName")
            print(email ?? "no Email")
            print(tokenToString)
            
            if email?.isEmpty ?? true {
                // email이 없는 정보! => 내부에서 디코딩 해주장 ㅇ.ㅇ
                let result = decode(jwtToken: tokenToString)["email"] as? String ?? ""
                print(result) // 디코딩한 결괏값 UserDefaults에 update
            }
            
            
            // 이메일, 토큰, 이름 -> UserDefaults & API로 서버에 POST
            // 서버에 request 후 response를 받게 되면 성공 시 화면 전환
            
            UserDefaults.standard.set(userIdentifier, forKey: "User")
            
            DispatchQueue.main.async {
                self.present(MainViewController(), animated: true)
            }
            
            
        case let passwordCredential as ASPasswordCredential:
            
            let username = passwordCredential.user
            let password = passwordCredential.password
            
            print(username, password)
            
        default: break
        }
        
    }
    
    
    private func decode(jwtToken jwt: String) -> [String: Any] {
        
        func base64UrlDecode(_ value: String) -> Data? {
            var base64 = value
                .replacingOccurrences(of: "-", with: "+")
                .replacingOccurrences(of: "_", with: "/")
            
            let length = Double(base64.lengthOfBytes(using: String.Encoding.utf8))
            let requiredLength = 4 * ceil(length / 4.0)
            let paddingLength = requiredLength - length
            if paddingLength > 0 {
                let padding = "".padding(toLength: Int(paddingLength), withPad: "=", startingAt: 0)
                base64 = base64 + padding
            }
            return Data(base64Encoded: base64, options: .ignoreUnknownCharacters)
        }
        
        func decodeJWTPart(_ value: String) -> [String: Any]? {
            guard let bodyData = base64UrlDecode(value),
                  let json = try? JSONSerialization.jsonObject(with: bodyData, options: []), let payload = json as? [String: Any] else {
                return nil
            }
            
            return payload
        }
        
        let segments = jwt.components(separatedBy: ".")
        return decodeJWTPart(segments[1]) ?? [:]
    }
    
}
