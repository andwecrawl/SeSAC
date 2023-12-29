//
//  FaceIDManager.swift
//  SignInWith
//
//  Created by yeoni on 12/29/23.
//

import Foundation
import LocalAuthentication

/*
 - 페이스아이디 권한 요청
 - FaceID가 없다면?
    - 앱 내에서 설정할 수 있는 다른 인증 방법 권장 혹은 FaceID 등록 유도
    - 아이폰 잠금을 아예 사용하지 않거나 비밀번호만 등록한 사람......
    - FaceID 설정 -> 아이폰 암호가 먼저 설정되어야 함 => 아예 안 쓰는 경우도 있을 수 있음!!
 - FaceID 추가 / 변경 / 삭제
 - FaceID가 계속 실패할 때
    FallBack에 대한 처리가 필요함
    다른 인증 방법으로 처리하기
 성공할 때는 크게 신경쓸 게 없음 ㅇ.ㅇ
    성공 했을 때 화면전환 / 사용자에 대한 로그인을 엮는다면 관련하여 로직을 고민해 봐야 할 거임
 - FaceID 결과는 mainThread 보장 X -> DispatchQueue.main.async 필요!!
 - 한 화면에서 FaceID 인증을 성공하면, 해당 화면에서는 success!!
    근데 SwiftUI에서는? State가 변경되면 body가 렌더링되어 다른 요소들도 초기화될 수 있을 거임
    ... 구럼 우케야 할까? 를 신경써서 개발하면 좋음!!
 
 - 실제 서비스 테스트 + LSLP에 생체 인증 연동
    어느 시점에 언제 띄워줘서 생체 인증을 연동시키는 게 좋을지
    어느 시점까지 FaceID를 처리해 주는 게 좋을지
    
 */

final class AuthenticationManger {
    
    static let shared = AuthenticationManger()
    
    private init() { }
    
    // deviceOwnerAuthentication와 withBiometrics가 있는데 생체 ID만 쓰려고 하면 후자 / 생체 인증이나 암호도 사용하려면 전자!
    var selectedPolicy: LAPolicy = .deviceOwnerAuthentication
    
    // 인증!!
    func auth() {
        
        let context = LAContext()
        context.localizedCancelTitle = "FaceID 인증 취소"
        context.localizedFallbackTitle = "비밀번호로 대신 인증하기" // 페이스 아이디가 실패할 경우 다른 경우로 나가깅.
        
        context.evaluatePolicy(selectedPolicy, localizedReason: "페이스 아이디 인증이 필요합니다.") { result, error in
            print(result)
            
            if let error {
                let code = error._code
                let laError = LAError(LAError.Code(rawValue: code)!)
                print(laError)
            }
        }
        
    }
    
    
    // faceID를 쓸 수 있는 상황인지 확인!!
    func checkPolicy() -> Bool {
        let context = LAContext()
        let policy: LAPolicy = selectedPolicy
        return context.canEvaluatePolicy(policy, error: nil)
    }
    
    
    // 변경 시
    func isFaceIDChanged() -> Bool {
        let context = LAContext()
        context.canEvaluatePolicy(selectedPolicy, error: nil)
        
        // 생체 인증에 대한 정보 -> 사람마다 고유한 정보를 주게 댐
            // 삭제했다가 다시 등록하거나 사람이 바뀌거나 한다면 바뀜!
        let state = context.evaluatedPolicyDomainState
        
        // 생체 인증 정보를 UserDefaults에 저장
            // 나중에 자동로그인을 구현하고 싶을 수도 있으니까 ㅇㅇ
            // 저장을 해 두어야 나중에 새로운 인증 정보와 비교하여 판단하기 편할 거임
            // 기존 저장된 DomainState와 새롭게 변경된 DomainState를 비교 => 새로운 DomainState를 ㅑ
        print(state)
        
        // 로직 추가를 해야 댐
        return false
    }
    
}
