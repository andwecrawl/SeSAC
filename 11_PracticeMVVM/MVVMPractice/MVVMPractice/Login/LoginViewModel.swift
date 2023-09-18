//
//  LoginViewModel.swift
//  MVVMPractice
//
//  Created by yeoni on 2023/09/16.
//

import Foundation

class LoginViewModel {
    
    var id = Observable("")
    var password = Observable("")
    var nickname = Observable("")
    var inviteCode = Observable("")
    var isVailed = Observable(false)
    
    func checkValidation(completion: @escaping (String) -> ()) {
        var checkID = false
        var checkPassword = false
        var checkCode = false
        
        if id.value.count > 5 && id.value.contains("@") {
            checkID = true
        }
        if password.value.count > 5 && password.value.count < 11 {
            checkPassword = true
        }
        if inviteCode.value.count > 5 {
            checkCode = true
        }
        
        if checkID && checkPassword && checkCode {
            completion("환영합니다!")
            isVailed.value = true
        } else {
            isVailed.value = false
            if !checkID {
                completion("id를 6자 이상, @를 포함하여 입력해 주세요!")
            } else if !checkPassword {
                completion("비밀번호는 6자 이상, 10자 이하로 입력해 주세요")
            } else if !checkCode {
                completion("추천 코드를 입력해 주세요!")
            }
        }
    }
    
    func signIn(completion: @escaping () -> Void) {
        UserDefaults.standard.set(nickname.value, forKey: "nickname")
        
        completion()
    }
    
}
