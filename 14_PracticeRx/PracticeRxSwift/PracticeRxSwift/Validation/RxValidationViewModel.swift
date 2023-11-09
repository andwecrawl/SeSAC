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
        var buttonValidation: PublishSubject<Bool>
        
        let tap: ControlEvent<Void>
        
    }
    
    let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        
        let usernameValidation = input.username.orEmpty
            .map({ $0.count >= 5 })
        
        let passwordValidation = input.password.orEmpty
            .map({ $0.count >= 5 })
        
        var buttonValidation = PublishSubject<Bool>()
        
        Observable.combineLatest(usernameValidation, passwordValidation)
            .bind(with: self) { owner, isValid in
                let validation = isValid.0 && isValid.1
                buttonValidation.onNext(validation)
            }
            .disposed(by: disposeBag)
        
        return Output(
            usernameValidation: usernameValidation,
            passwordValidation: passwordValidation,
            buttonValidation: buttonValidation,
            tap: input.tap
        )
    }
    
}
