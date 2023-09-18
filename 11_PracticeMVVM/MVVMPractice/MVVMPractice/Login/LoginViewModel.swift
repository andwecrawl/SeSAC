//
//  LoginViewModel.swift
//  MVVMPractice
//
//  Created by yeoni on 2023/09/16.
//

import Foundation

class LoginViewModel {
    
    var id = Observable("id")
    var password = Observable("password")
    var nickname = Observable("nickname")
    var inviteCode = Observable("12345678")
    var isVailed = Observable(false)
    
    func checkValidation() {
        if id.value.count > 5 && password.value.count > 8
            && inviteCode.value.count > 5 {
            isVailed.value = true
        } else {
            isVailed.value = false
        }
    }
    
    func signIn(completion: @escaping () -> Void) {
        UserDefaults.standard.set(nickname.value, forKey: "nickname")
        
        completion()
    }
    
}
