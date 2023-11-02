//
//  PhoneViewModel.swift
//  SeSACRxThreads
//
//  Created by yeoni on 2023/11/03.
//

import Foundation
import RxSwift
import RxCocoa

class PhoneViewModel {
    
    let phone = BehaviorSubject(value: "010")
    let isEnabled = BehaviorSubject(value: false)
    
    let disposeBag = DisposeBag()
    
    init() {
        
        phone
            .map({ $0.count > 12 })
            .subscribe(with: self) { owner, value in
                
                owner.isEnabled.onNext(value)
                owner.isEnabled.on(.next(value))
                
            }
            .disposed(by: disposeBag)
        
    }
    
}
