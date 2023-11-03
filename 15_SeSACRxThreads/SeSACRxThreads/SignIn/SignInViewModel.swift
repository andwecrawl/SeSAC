//
//  SignInViewModel.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/10/30.
//

import Foundation
import RxSwift
import RxCocoa

class SignInViewModel {
    
    var email = BehaviorSubject(value: "")
    var password = BehaviorSubject(value: "")
    
    var isEnable = BehaviorSubject(value: false)
    
    lazy var validation = Observable.combineLatest(email, password) { email, password in
        return email.count > 5 && password.count > 5
    }
    
    let disposeBag = DisposeBag()
    
    init() {
        validation
            .bind(to: isEnable)
            .disposed(by: disposeBag)
    }
    
}
