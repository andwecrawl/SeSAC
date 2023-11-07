//
//  RxValidationViewModel.swift
//  PracticeRxSwift
//
//  Created by yeoni on 2023/11/05.
//

import Foundation
import RxSwift
import RxCocoa

class RxValidationViewModel {
    
    struct Input {
        var username: ControlProperty<String?>
        var password: ControlProperty<String?>
        
        let tap: ControlEvent<Void>
    }
    
    struct Output {
        
        var usernameValidation: Observable<Bool>
        var passwordValidation: Observable<Bool>
        
        let tap: ControlEvent<Void>
        
    }
    
    func transform(input: Input) -> Output {
        
        let usernameValidation = input.username.orEmpty
            .map({ $0.count >= 5 })
        
        let passwordValidation = input.password.orEmpty
            .map({ $0.count >= 5 })
        
        return Output(
            usernameValidation: usernameValidation,
            passwordValidation: passwordValidation,
            tap: input.tap
        )
    }
    
}
